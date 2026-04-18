<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useVenueStore } from '@/stores/venue'

const props = defineProps<{ id: string }>()
const store = useVenueStore()
const route = useRoute()

onMounted(() => {
  const venueId = Number(props.id || route.params.id)
  store.fetchVenueDetail(venueId)
  store.fetchVenueImages(venueId)
})

const handleRetry = () => {
  const venueId = Number(props.id || route.params.id)
  store.fetchVenueDetail(venueId)
  store.fetchVenueImages(venueId)
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
    <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
    <EmptyState v-else-if="!store.currentVenue" message="未找到该场馆" />
    <div v-else-if="store.currentVenue" class="px-6 lg:px-8 py-8">
      <div class="relative h-[50vh] rounded-lg overflow-hidden mb-8">
        <img
          v-if="store.venueImages[0]"
          :src="store.venueImages[0]"
          :alt="store.currentVenue.name"
          class="w-full h-full object-cover"
        />
        <div v-else class="w-full h-full bg-[#e8e6e3] flex items-center justify-center">
          <div class="text-center text-[#648992]">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-16 h-16 mx-auto mb-3 opacity-40" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
            </svg>
            <span class="text-sm font-body opacity-60">场馆图片</span>
          </div>
        </div>
        <div class="absolute inset-0 bg-gradient-to-t from-dark/80 to-transparent"></div>
        <div class="absolute bottom-8 left-[5vw]">
          <span v-if="store.currentVenue.type" class="bg-accent text-white text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">
            {{ store.currentVenue.type }}
          </span>
          <span v-else class="bg-accent/50 text-white text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">暂无类型</span>
          <h1 class="font-montserrat font-bold text-4xl text-white">{{ store.currentVenue.name || '暂无名称' }}</h1>
        </div>
      </div>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="md:col-span-2">
          <h2 class="font-montserrat font-bold text-xl text-brand mb-4">场馆介绍</h2>
          <p class="text-muted leading-relaxed">{{ store.currentVenue.description || '暂无内容...' }}</p>
        </div>
        <div class="bg-accent/20 border border-border rounded-lg p-6">
          <h3 class="font-montserrat font-bold text-brand mb-4">场馆信息</h3>
          <div class="space-y-3 text-sm">
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">地址</span>
              <span class="text-brand">{{ store.currentVenue.address || '暂无内容...' }}</span>
            </div>
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">开放时间</span>
              <span class="text-brand">{{ store.currentVenue.openHours || '暂无内容...' }}</span>
            </div>
            <div class="flex justify-between items-center min-h-[24px]">
              <span class="text-muted">容量</span>
              <span class="text-brand">{{ store.currentVenue.capacity ? `${store.currentVenue.capacity} 人` : '暂无内容...' }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
