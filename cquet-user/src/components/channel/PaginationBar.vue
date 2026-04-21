<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  page: number
  totalPages: number
  showSinglePage?: boolean
}>()

const emit = defineEmits<{
  change: [page: number]
}>()

const pageCount = computed(() => Math.max(1, props.totalPages))

const visiblePages = computed(() => {
  const pages: number[] = []
  const max = Math.min(pageCount.value, 5)
  for (let i = 1; i <= max; i += 1) {
    pages.push(i)
  }
  return pages
})

const go = (page: number) => {
  if (page < 1 || page > pageCount.value || page === props.page) return
  emit('change', page)
}
</script>

<template>
  <nav v-if="showSinglePage || pageCount > 1" class="flex items-center justify-center gap-3 pt-10" aria-label="分页">
    <button
      type="button"
      class="flex h-10 min-w-10 items-center justify-center rounded-[14px] border border-border bg-white px-4 font-body text-sm text-muted transition-colors hover:border-brand hover:text-brand disabled:cursor-not-allowed disabled:opacity-40"
      :disabled="page === 1"
      @click="go(page - 1)"
    >
      上一页
    </button>
    <button
      v-for="item in visiblePages"
      :key="item"
      type="button"
      class="flex h-10 min-w-10 items-center justify-center rounded-[14px] px-4 font-body text-sm transition-colors"
      :class="item === page ? 'bg-brand text-white' : 'text-brand hover:bg-light'"
      @click="go(item)"
    >
      {{ item }}
    </button>
    <span v-if="totalPages > visiblePages.length" class="font-body text-sm text-muted">...</span>
    <button
      type="button"
      class="flex h-10 min-w-10 items-center justify-center rounded-[14px] border border-border bg-white px-4 font-body text-sm text-muted transition-colors hover:border-brand hover:text-brand disabled:cursor-not-allowed disabled:opacity-40"
      :disabled="page === pageCount"
      @click="go(page + 1)"
    >
      下一页
    </button>
  </nav>
</template>
