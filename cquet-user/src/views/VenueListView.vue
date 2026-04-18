<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import NavBar from '@/components/layout/NavBar.vue'
import HeroBanner from '@/components/ui/HeroBanner.vue'
import VenueGridCard from '@/components/ui/VenueGridCard.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import { useVenueStore } from '@/stores/venue'

const store = useVenueStore()
const page = ref(1)
const pageSize = ref(12)

onMounted(() => {
  store.fetchVenues({ pageNum: page.value, pageSize: pageSize.value })
})

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchVenues({ pageNum: p, pageSize: pageSize.value })
}

const handleRetry = () => {
  store.fetchVenues({ pageNum: page.value, pageSize: pageSize.value })
}

const totalPages = computed(() => Math.ceil(store.total / pageSize))

const rows = computed(() => {
  const result: any[][] = []
  for (let i = 0; i < store.venues.length; i += 3) {
    result.push(store.venues.slice(i, i + 3))
  }
  return result
})
</script>

<template>
  <div class="relative bg-white">
    <NavBar />

    <!-- Hero Banner: 100vh + 纯黑渐变 -->
    <div class="relative" style="z-index: 1;">
      <HeroBanner
        title="文化场馆"
        backgroundImage="https://images.unsplash.com/photo-1514539079130-25950c84af65?w=1920&h=1080&fit=crop&q=80"
        theme="black"
      />
    </div>

    <!-- 页面内容 -->
    <div class="bg-white">
      <!-- 标题栏 -->
      <div class="border-b border-dark/10">
        <div class="max-w-[1280px] mx-auto px-6 lg:px-10">
          <h2 class="font-heading text-lg font-semibold text-brand py-8">文化场馆</h2>
        </div>
      </div>

      <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
      <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
      <EmptyState v-else-if="store.venues.length === 0" message="暂无场馆数据" />

      <div v-else>
        <div
          v-for="(row, rowIndex) in rows"
          :key="rowIndex"
          class="max-w-[1280px] mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 border-t border-dark/10"
          :class="rowIndex < rows.length - 1 ? 'border-b border-dark/10' : ''"
        >
          <div
            v-for="(venue, colIndex) in row"
            :key="venue.id"
            class="border-r border-dark/10 last:border-r-0"
          >
            <VenueGridCard :venue="venue" />
          </div>
          <div
            v-for="n in (3 - row.length)"
            :key="'empty-' + n"
            class="border-r border-dark/10 last:border-r-0 hidden lg:block"
          ></div>
        </div>
      </div>

      <!-- 分页器 -->
      <div v-if="totalPages > 1" class="flex items-center justify-center gap-3 py-10 border-t border-dark/10">
        <button
          @click="handlePageChange(page - 1)"
          :disabled="page === 1"
          class="w-8 h-8 rounded border border-border flex items-center justify-center text-muted hover:border-brand hover:text-brand transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15.75 19.5L8.25 12l7.5-7.5" />
          </svg>
        </button>
        <span class="font-montserrat text-sm text-muted px-2">{{ page }} / {{ totalPages }}</span>
        <button
          @click="handlePageChange(page + 1)"
          :disabled="page === totalPages"
          class="w-8 h-8 rounded border border-border flex items-center justify-center text-muted hover:border-brand hover:text-brand transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
          </svg>
        </button>
      </div>
    </div>

    <BackToTop />
  </div>
</template>
