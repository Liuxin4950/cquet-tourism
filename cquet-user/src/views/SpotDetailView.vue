<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'

const props = defineProps<{ id: string }>()
const store = useScenicSpotStore()
const route = useRoute()

onMounted(() => {
  const spotId = Number(props.id || route.params.id)
  store.fetchSpotDetail(spotId)
  store.fetchSpotImages(spotId)
})

const handleRetry = () => {
  const spotId = Number(props.id || route.params.id)
  store.fetchSpotDetail(spotId)
  store.fetchSpotImages(spotId)
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
    <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
    <EmptyState v-else-if="!store.currentSpot" message="未找到该景区" />
    <div v-else-if="store.currentSpot" class="px-6 lg:px-8 py-8">
      <div class="relative h-[50vh] rounded-lg overflow-hidden mb-8">
        <img
          v-if="store.spotImages[0]"
          :src="store.spotImages[0]"
          :alt="store.currentSpot.name"
          class="w-full h-full object-cover"
        />
        <div v-else class="w-full h-full bg-[#e8e6e3] flex items-center justify-center">
          <div class="text-center text-[#648992]">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 mx-auto mb-3 opacity-40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            <span class="text-sm font-body opacity-60">景区图片</span>
          </div>
        </div>
        <div class="absolute inset-0 bg-gradient-to-t from-dark/80 to-transparent"></div>
        <div class="absolute bottom-8 left-[5vw]">
          <span v-if="store.currentSpot.level" class="bg-brand text-white text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">
            {{ store.currentSpot.level }}
          </span>
          <span v-else class="bg-brand/50 text-white text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">暂无等级</span>
          <h1 class="font-montserrat font-bold text-4xl text-white">{{ store.currentSpot.name || '暂无名称' }}</h1>
        </div>
      </div>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="md:col-span-2">
          <h2 class="font-montserrat font-bold text-xl text-brand mb-4">景区介绍</h2>
          <p class="text-muted leading-relaxed">{{ store.currentSpot.description || '暂无内容...' }}</p>
        </div>
        <div class="bg-accent/20 border border-border rounded-lg p-6">
          <h3 class="font-montserrat font-bold text-brand mb-4">游览信息</h3>
          <div class="space-y-3 text-sm">
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">地址</span>
              <span class="text-brand">{{ store.currentSpot.address || '暂无内容...' }}</span>
            </div>
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">开放时间</span>
              <span class="text-brand">{{ store.currentSpot.openHours || '暂无内容...' }}</span>
            </div>
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">票务信息</span>
              <span class="text-brand">{{ store.currentSpot.ticketInfo || '暂无内容...' }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
