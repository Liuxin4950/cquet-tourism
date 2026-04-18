<script setup lang="ts">
defineProps<{
  title: string
  description: string
  ctaText: string
  to: string
}>()
</script>

<template>
  <div class="flex flex-col items-center justify-center rounded-[20px] border border-border bg-light px-6 py-12 text-center">
    <div class="mb-5 flex h-14 w-14 items-center justify-center rounded-full border border-border bg-white text-muted">
      <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.4" d="M20 13V7a2 2 0 00-2-2H6a2 2 0 00-2 2v6m16 0v4a2 2 0 01-2 2H6a2 2 0 01-2-2v-4m16 0h-3.2a1.5 1.5 0 00-1.06.44l-1.48 1.48a1.5 1.5 0 01-1.06.44h-2.4a1.5 1.5 0 01-1.06-.44l-1.48-1.48A1.5 1.5 0 006.2 13H4" />
      </svg>
    </div>
    <h3 class="font-heading text-[18px] font-semibold text-brand">{{ title }}</h3>
    <p class="mt-3 max-w-[360px] font-body text-sm leading-6 text-muted">{{ description }}</p>
    <router-link :to="to" class="btn-pill dark mt-6">
      {{ ctaText }}
    </router-link>
  </div>
</template>
