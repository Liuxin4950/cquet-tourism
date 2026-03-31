<script setup lang="ts">
import NavBar from '@/components/layout/NavBar.vue'
</script>

<template>
  <NavBar />
  <main class="pt-[72px]">
    <section class="about-hero">
      <h1 class="text-center">关于重庆文旅</h1>
    </section>
  </main>
</template>

<style scoped>
.about-hero {
  min-height: calc(100vh - 72px);
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
