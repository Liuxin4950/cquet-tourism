<script setup lang="ts">
defineProps<{
  isLoading: boolean
}>()
</script>

<template>
  <div v-if="isLoading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
    <div v-for="i in 8" :key="i" class="animate-pulse">
      <div class="aspect-[4/3] bg-border rounded mb-4"></div>
      <div class="h-3 bg-border rounded w-1/3 mb-2"></div>
      <div class="h-4 bg-border rounded w-2/3 mb-2"></div>
      <div class="h-3 bg-border rounded w-1/2"></div>
    </div>
  </div>
</template>
