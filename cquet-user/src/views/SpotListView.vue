<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import NavBar from '@/components/layout/NavBar.vue'
import HeroBanner from '@/components/ui/HeroBanner.vue'
import SpotGridCard from '@/components/ui/SpotGridCard.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'

const store = useScenicSpotStore()
const page = ref(1)
const pageSize = ref(12)

const HERO_IMAGE = 'https://images.unsplash.com/photo-1609609697762-87d2c2c944b4?w=1920&h=1080&fit=crop&q=80'

onMounted(() => {
  store.fetchSpots({ pageNum: page.value, pageSize: pageSize.value })
})

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchSpots({ pageNum: p, pageSize: pageSize.value })
}

const handleRetry = () => {
  store.fetchSpots({ pageNum: page.value, pageSize: pageSize.value })
}

const totalPages = computed(() => Math.ceil(store.total / pageSize))

// 将一维数组转为二维数组，每行3个
const rows = computed(() => {
  const result: any[][] = []
  for (let i = 0; i < store.spots.length; i += 3) {
    result.push(store.spots.slice(i, i + 3))
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
        title="景区列表"
        backgroundImage="https://images.unsplash.com/photo-1609609697762-87d2c2c944b4?w=1920&h=1080&fit=crop&q=80"
        theme="black"
      />
    </div>

    <!-- 页面内容 -->
    <div class="bg-white">
      <!-- 标题栏 -->
      <div class="border-b border-dark/10">
        <div class="max-w-[1280px] mx-auto px-6 lg:px-10">
          <h2 class="font-heading text-lg font-semibold text-brand py-8">A级景区</h2>
        </div>
      </div>

      <!-- Loading / Error / Empty -->
      <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
      <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
      <EmptyState v-else-if="store.spots.length === 0" message="暂无景区数据" />

      <!-- 3列网格 -->
      <div v-else>
        <div
          v-for="(row, rowIndex) in rows"
          :key="rowIndex"
          class="max-w-[1280px] mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 border-t border-dark/10"
          :class="rowIndex < rows.length - 1 ? 'border-b border-dark/10' : ''"
        >
          <div
            v-for="(spot, colIndex) in row"
            :key="spot.id"
            class="border-r border-dark/10 last:border-r-0"
          >
            <SpotGridCard :spot="spot" />
          </div>
          <!-- 如果最后一行不足3个，填充空白格子保持边框完整 -->
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

    <!-- 返回顶部 -->
    <BackToTop />
  </div>
</template>
