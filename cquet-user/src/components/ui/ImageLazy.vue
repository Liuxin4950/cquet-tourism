<script setup lang="ts">
import { ref } from 'vue'

const props = defineProps<{
  src: string
  alt?: string
  class?: string
}>()

const loaded = ref(false)
const error = ref(false)

const onLoad = () => {
  loaded.value = true
}

const onError = () => {
  error.value = true
  loaded.value = true
}
</script>

<template>
  <div :class="$props.class">
    <img
      v-if="loaded"
      :src="src"
      :alt="alt"
      loading="lazy"
      @load="onLoad"
      @error="onError"
      class="w-full h-full object-cover transition-opacity duration-300"
    />
    <div
      v-else
      class="w-full h-full bg-light/20 flex items-center justify-center"
    >
      <span v-if="error" class="text-muted text-xs">图片加载失败</span>
    </div>
  </div>
</template>
