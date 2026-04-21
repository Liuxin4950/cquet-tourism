<script setup lang="ts">
import { computed } from 'vue'

export interface ScheduleActivity {
  id: number
  name: string
  type?: string
  category?: string
  venueName?: string
  startTime?: string
  endTime?: string
  description?: string
  capacity?: number
  currentParticipants?: number
  status?: string
}

const props = defineProps<{
  activity: ScheduleActivity
}>()

const dateInfo = computed(() => {
  if (!props.activity.startTime) {
    return {
      day: '--',
      month: '时间待定',
      weekday: '',
      range: '暂无时间',
    }
  }

  const date = new Date(props.activity.startTime.replace(/-/g, '/'))
  if (Number.isNaN(date.getTime())) {
    return {
      day: '--',
      month: '时间待定',
      weekday: '',
      range: props.activity.startTime,
    }
  }

  const end = props.activity.endTime ? props.activity.endTime.slice(11, 16) : ''
  const start = props.activity.startTime.slice(11, 16)

  return {
    day: String(date.getDate()).padStart(2, '0'),
    month: `${date.getMonth() + 1}月`,
    weekday: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'][date.getDay()],
    range: end ? `${start} - ${end}` : start,
  }
})

const categoryLabel = computed(() => props.activity.type || props.activity.category || '')
const hasCapacity = computed(() => typeof props.activity.capacity === 'number' && props.activity.capacity > 0)
const statusClass = computed(() => {
  if (props.activity.status === '报名中') return 'bg-yellow-100 text-yellow-700'
  if (props.activity.status === '进行中') return 'bg-green-100 text-green-700'
  if (props.activity.status === '已结束') return 'bg-light text-muted'
  return 'bg-light text-muted'
})
</script>

<template>
  <article class="group rounded-[20px] border border-border bg-white p-5 shadow-sm transition-all hover:border-accent hover:shadow-[0_14px_34px_rgba(9,44,56,0.08)] md:p-6">
    <div class="grid gap-5 md:grid-cols-[150px_minmax(0,1fr)_150px] md:items-center">
      <div class="border-b border-border pb-5 md:border-b-0 md:border-r md:pb-0 md:pr-6">
        <div class="flex items-end gap-3">
          <span class="font-heading text-[46px] font-semibold leading-none text-brand">{{ dateInfo.day }}</span>
          <span class="pb-2 font-body text-base text-muted">{{ dateInfo.month }}</span>
        </div>
        <p class="mt-3 font-body text-sm text-muted">{{ dateInfo.weekday || '日期待定' }}</p>
      </div>

      <div class="min-w-0">
        <div class="mb-3 flex flex-wrap items-center gap-2">
          <span v-if="categoryLabel" class="font-body text-sm text-muted">
            {{ categoryLabel }}
          </span>
          <span v-if="activity.status" class="rounded-full px-3 py-1 font-body text-xs" :class="statusClass">
            {{ activity.status }}
          </span>
        </div>
        <h3 class="font-heading text-[20px] font-semibold leading-snug text-brand transition-colors group-hover:text-accent">
          {{ activity.name || '暂无名称' }}
        </h3>
        <p class="mt-3 line-clamp-2 font-body text-sm leading-6 text-muted">
          {{ activity.description || '暂无活动介绍' }}
        </p>
        <div class="mt-4 flex flex-wrap items-center gap-x-6 gap-y-2 font-body text-sm text-muted">
          <span class="inline-flex items-center gap-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            {{ dateInfo.range }}
          </span>
          <span v-if="activity.venueName" class="inline-flex items-center gap-2">
            <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
            </svg>
            {{ activity.venueName }}
          </span>
          <span v-if="hasCapacity" class="rounded-full bg-light px-3 py-1 text-xs">
            {{ activity.currentParticipants || 0 }} / {{ activity.capacity }} 人
          </span>
        </div>
      </div>

      <div class="flex md:justify-end">
        <router-link
          :to="`/activities/${activity.id}`"
          class="inline-flex w-fit items-center justify-center rounded-[16px] px-5 py-3 font-body text-sm text-brand transition-colors hover:bg-light"
        >
          查看详情
          <svg class="ml-2 h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
          </svg>
        </router-link>
      </div>
    </div>
  </article>
</template>
