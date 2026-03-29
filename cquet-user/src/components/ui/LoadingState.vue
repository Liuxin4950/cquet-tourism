<script setup lang="ts">
defineProps<{
  isLoading: boolean
}>()
</script>

<template>
  <div v-if="isLoading" class="flex items-center justify-center py-[5vw]">
    <div class="w-[2vw] h-[2vw] border border-[#dfdfdf] border-t-[#222a2c] rounded-full animate-spin"></div>
  </div>
</template>
