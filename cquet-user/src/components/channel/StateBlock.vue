<script setup lang="ts">
withDefaults(defineProps<{
  type: 'loading' | 'empty' | 'error'
  title?: string
  description?: string
  actionText?: string
  secondaryActionText?: string
}>(), {
  title: '',
  description: '',
  actionText: '',
  secondaryActionText: '',
})

const emit = defineEmits<{
  action: []
  secondary: []
}>()
</script>

<template>
  <section v-if="type === 'loading'" class="space-y-4">
    <div v-for="item in 4" :key="item" class="animate-pulse rounded-[20px] border border-border bg-white p-5">
      <div class="grid gap-5 md:grid-cols-[128px_minmax(0,1fr)_132px] md:items-center">
        <div class="h-24 rounded-[18px] bg-light"></div>
        <div class="space-y-3">
          <div class="h-4 w-1/2 rounded bg-light"></div>
          <div class="h-3 w-2/3 rounded bg-light"></div>
          <div class="h-3 w-1/3 rounded bg-light"></div>
        </div>
        <div class="space-y-3">
          <div class="h-8 rounded-full bg-light"></div>
          <div class="h-10 rounded-[14px] bg-light"></div>
        </div>
      </div>
    </div>
  </section>

  <section v-else class="rounded-[24px] border border-border bg-white px-6 py-12 text-center shadow-sm">
    <div class="mx-auto mb-5 flex h-14 w-14 items-center justify-center rounded-[18px] bg-light text-muted">
      <svg v-if="type === 'empty'" class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.4" d="M6.75 3v2.25m10.5-2.25v2.25M4.5 9h15M5.25 5.25h13.5A1.5 1.5 0 0120.25 6.75v11.5a1.5 1.5 0 01-1.5 1.5H5.25a1.5 1.5 0 01-1.5-1.5V6.75a1.5 1.5 0 011.5-1.5z" />
      </svg>
      <svg v-else class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.4" d="M12 9v4m0 4h.01M10.29 3.86L2.82 17a2 2 0 001.71 3h14.94a2 2 0 001.71-3L13.71 3.86a2 2 0 00-3.42 0z" />
      </svg>
    </div>
    <h3 class="font-heading text-[22px] font-semibold text-brand">
      {{ title || (type === 'empty' ? '暂时没有符合条件的活动' : '活动加载失败') }}
    </h3>
    <p class="mx-auto mt-3 max-w-[420px] font-body text-sm leading-6 text-muted">
      {{ description || (type === 'empty' ? '你可以调整筛选条件，或先浏览全部活动内容。' : '网络异常或数据暂不可用，请稍后重试。') }}
    </p>
    <div class="mt-6 flex flex-col items-center justify-center gap-3 sm:flex-row">
      <button
        v-if="actionText"
        type="button"
        class="rounded-[16px] bg-brand px-5 py-3 font-body text-sm text-white transition-colors hover:bg-dark"
        @click="emit('action')"
      >
        {{ actionText }}
      </button>
      <button
        v-if="secondaryActionText"
        type="button"
        class="rounded-[16px] border border-border px-5 py-3 font-body text-sm text-muted transition-colors hover:border-brand hover:text-brand"
        @click="emit('secondary')"
      >
        {{ secondaryActionText }}
      </button>
    </div>
  </section>
</template>
