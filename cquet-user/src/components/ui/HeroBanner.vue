<script setup lang="ts">
defineProps<{
  title: string
  subtitle?: string
  backgroundImage: string
  theme?: 'dark' | 'black'
}>()
</script>

<template>
  <div
    class="relative w-full overflow-hidden"
    style="height: 100vh; z-index: 1;"
  >
    <!-- 背景图 -->
    <img
      :src="backgroundImage"
      :alt="title"
      class="absolute inset-0 w-full h-full object-cover"
      loading="eager"
      fetchpriority="high"
      aria-hidden="true"
    />

    <!-- 底部渐变遮罩：dark=深青色 / black=纯黑 -->
    <div
      class="absolute inset-0"
      :style="theme === 'black'
        ? 'background: linear-gradient(to top, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.5) 40%, transparent 70%);'
        : 'background: linear-gradient(to top, rgba(9,44,56,0.88) 0%, rgba(9,44,56,0.5) 40%, transparent 70%);'"
    />

    <!-- 标题区域 -->
    <div class="absolute bottom-0 left-0 pl-8 lg:pl-16 pb-12 lg:pb-20">
      <h1
        class="font-heading text-white font-bold leading-tight"
        style="font-size: 3.5rem;"
      >
        {{ title }}
      </h1>
      <p
        v-if="subtitle"
        class="font-montserrat text-white/80 mt-3"
        style="font-size: 0.875rem; letter-spacing: 0.15em;"
      >
        {{ subtitle }}
      </p>
    </div>
  </div>
</template>
