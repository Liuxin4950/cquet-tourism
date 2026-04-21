<script setup lang="ts">
export interface VenueFilterOption {
  id: number
  name: string
}

defineProps<{
  search: string
  status: string
  venueId: string
  sort: string
  resultCount: number
  venueOptions: VenueFilterOption[]
}>()

const emit = defineEmits<{
  'update:search': [value: string]
  'update:status': [value: string]
  'update:venueId': [value: string]
  'update:sort': [value: string]
  submit: []
  reset: []
}>()

const statusOptions = [
  { label: '全部状态', value: '' },
  { label: '报名中', value: '报名中' },
  { label: '进行中', value: '进行中' },
  { label: '已结束', value: '已结束' },
]

const sortOptions = [
  { label: '时间从近到远', value: 'timeAsc' },
  { label: '时间从远到近', value: 'timeDesc' },
  { label: '名称排序', value: 'nameAsc' },
]
</script>

<template>
  <section class="rounded-[20px] border border-border bg-white p-5 shadow-[0_12px_36px_rgba(9,44,56,0.10)] md:p-6">
    <div class="flex flex-col gap-5">
      <div class="grid grid-cols-1 gap-4 lg:grid-cols-[minmax(260px,1fr)_170px_210px]">
        <form class="flex min-h-[52px] overflow-hidden rounded-[16px] border border-border bg-light" @submit.prevent="emit('submit')">
          <span class="flex items-center pl-4 text-muted">
            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M21 21l-4.35-4.35m1.1-5.4a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" />
            </svg>
          </span>
          <input
            :value="search"
            type="search"
            placeholder="搜索活动名称或场馆..."
            class="min-w-0 flex-1 bg-transparent px-4 py-3 font-body text-sm text-brand outline-none placeholder:text-muted"
            @input="emit('update:search', ($event.target as HTMLInputElement).value)"
          />
        </form>

        <select
          :value="status"
          class="min-h-[52px] rounded-[16px] border border-border bg-light px-4 py-3 font-body text-sm text-brand outline-none"
          @change="emit('update:status', ($event.target as HTMLSelectElement).value); emit('submit')"
        >
          <option v-for="item in statusOptions" :key="item.value" :value="item.value">
            {{ item.label }}
          </option>
        </select>

        <select
          :value="sort"
          class="min-h-[52px] rounded-[16px] border border-border bg-light px-4 py-3 font-body text-sm text-brand outline-none"
          @change="emit('update:sort', ($event.target as HTMLSelectElement).value)"
        >
          <option v-for="item in sortOptions" :key="item.value" :value="item.value">
            {{ item.label }}
          </option>
        </select>
      </div>

      <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <p class="font-body text-sm text-muted">
          找到 <span class="text-brand">{{ resultCount }}</span> 个结果
          <button type="button" class="ml-2 text-accent hover:text-brand" @click="emit('submit')">预览状态</button>
        </p>
        <button
          type="button"
          class="w-fit rounded-[16px] border border-border px-4 py-2.5 font-body text-sm text-muted transition-colors hover:border-brand hover:text-brand"
          @click="emit('reset')"
        >
          清除筛选
        </button>
      </div>
    </div>
  </section>
</template>
