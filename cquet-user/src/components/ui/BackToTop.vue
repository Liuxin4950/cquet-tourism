<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const show = ref(false)

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const handleScroll = () => {
  show.value = window.scrollY > window.innerHeight * 0.5
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
  <Teleport to="body">
    <Transition name="fade">
      <button
        v-if="show"
        @click="scrollToTop"
        class="fixed bottom-[3vw] right-[3vw] z-50 w-[3.5vw] h-[3.5vw] bg-brand/90 backdrop-blur-sm rounded-full flex items-center justify-center cursor-pointer hover:bg-brand transition-all duration-300 group"
        aria-label="回到顶部"
      >
        <svg class="w-[1.2vw] h-[1.2vw] text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M5 15l7-7 7 7" />
        </svg>
      </button>
    </Transition>
  </Teleport>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
