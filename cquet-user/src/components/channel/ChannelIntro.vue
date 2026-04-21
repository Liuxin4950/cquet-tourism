<script setup lang="ts">
defineProps<{
  eyebrow: string
  title: string
  subtitle: string
  totalLabel?: string
  totalValue?: number
  filteredLabel?: string
  filteredValue?: number
  note?: string
}>()
</script>

<template>
  <section class="relative w-full overflow-hidden rounded-[24px] bg-gradient-to-br from-brand via-muted to-dark px-6 py-16 text-white lg:px-10 lg:py-20">
    <div class="pointer-events-none absolute inset-0 opacity-10">
      <div
        v-for="item in 18"
        :key="item"
        class="absolute h-20 w-20 rounded-[24px] border border-white"
        :style="{
          left: `${(item % 6) * 16}%`,
          top: `${Math.floor(item / 6) * 30}%`,
        }"
      ></div>
    </div>
    <div class="pointer-events-none absolute inset-0 bg-gradient-to-tr from-dark/85 via-white/14 to-light/65"></div>

    <div class="relative z-10 grid min-h-[230px] gap-8 md:grid-cols-[minmax(0,1fr)_360px] md:items-end">
      <div>
        <p class="inline-flex items-center rounded-full border border-white/25 bg-white/10 px-4 py-2 font-body text-xs uppercase tracking-[0.16em] text-white/80">
          <svg class="mr-2 h-4 w-4 text-white/60" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M6.75 3v2.25m10.5-2.25v2.25M4.5 9h15M5.25 5.25h13.5A1.5 1.5 0 0120.25 6.75v11.5a1.5 1.5 0 01-1.5 1.5H5.25a1.5 1.5 0 01-1.5-1.5V6.75a1.5 1.5 0 011.5-1.5z" />
          </svg>
          {{ eyebrow }}
        </p>
        <h1 class="mt-7 font-heading text-[48px] font-bold leading-none text-white md:text-[56px]">
          {{ title }}
        </h1>
        <p class="mt-5 max-w-[680px] font-body text-[17px] leading-8 text-white/72 md:text-[18px]">
          {{ subtitle }}
        </p>
      </div>

      <div class="rounded-[20px] border border-white/12 bg-dark/12 p-5 backdrop-blur-sm md:p-6">
        <div class="grid grid-cols-2 divide-x divide-white/16">
          <div>
            <p class="font-body text-xs text-white/50">{{ totalLabel || '活动总数' }}</p>
            <p class="mt-3 font-heading text-[38px] font-semibold leading-none text-white">{{ totalValue ?? 0 }}</p>
          </div>
          <div class="pl-6">
            <p class="font-body text-xs text-white/50">{{ filteredLabel || '当前结果' }}</p>
            <p class="mt-3 font-heading text-[38px] font-semibold leading-none text-white">{{ filteredValue ?? 0 }}</p>
          </div>
        </div>
        <p v-if="note" class="mt-5 border-t border-white/10 pt-4 font-body text-sm leading-6 text-white/60">
          {{ note }}
        </p>
      </div>
    </div>
  </section>
</template>
