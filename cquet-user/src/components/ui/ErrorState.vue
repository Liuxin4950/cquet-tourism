<script setup lang="ts">
defineEmits<{
  retry: []
}>()

defineProps<{
  message?: string
}>()
</script>

<template>
  <div class="flex flex-col items-center justify-center py-12 text-center">
    <svg class="w-12 h-12 text-muted mb-4 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
    </svg>
    <p class="font-body text-sm text-muted mb-4">{{ message || '加载失败，请稍后重试' }}</p>
    <button
      @click="$emit('retry')"
      class="px-6 py-2 text-xs font-montserrat tracking-wider border border-border text-muted rounded hover:border-brand hover:text-brand transition-colors"
    >
      重试
    </button>
  </div>
</template>
