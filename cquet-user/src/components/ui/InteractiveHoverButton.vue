<script setup lang="ts">
defineProps<{
  text: string
  disabled?: boolean
  onClick?: () => void
  icon?: any
}>()
</script>

<template>
  <button
    type="button"
    :disabled="disabled"
    class="relative overflow-hidden px-6 py-3 rounded-[100vw] border border-[#dfdfdf] font-body text-[13px] tracking-wide transition-all duration-300 hover:border-[#648992] hover:text-[#648992] disabled:opacity-50 disabled:cursor-not-allowed"
    v-bind="$attrs"
    @click="onClick"
  >
    <span class="relative z-10 flex items-center justify-center gap-2">
      <!-- Google 图标插槽 -->
      <span v-if="icon" class="flex items-center">
        <slot name="icon">{{ icon }}</slot>
      </span>
      {{ text }}
    </span>
    <!-- 悬停动画背景 -->
    <span
      class="absolute inset-0 bg-[#648992]/5 transform -translate-x-full hover:translate-x-0 transition-transform duration-300"
    />
  </button>
</template>
