<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import LoadingState from '@/components/ui/LoadingState.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'

const props = defineProps<{ id: string }>()
const store = useScenicSpotStore()
const route = useRoute()

onMounted(() => {
  const spotId = Number(props.id || route.params.id)
  store.fetchSpotDetail(spotId)
  store.fetchSpotImages(spotId)
})
</script>

<template>
  <div class="min-h-screen bg-primary-dark pt-[72px]">
    <LoadingState :isLoading="store.isLoading" />
    <div v-else-if="store.currentSpot" class="px-[5vw] py-8">
      <div class="relative h-[50vh] rounded-lg overflow-hidden mb-8">
        <img
          :src="store.spotImages[0] || 'https://picsum.photos/1920/800?random=' + id"
          :alt="store.currentSpot.name"
          class="w-full h-full object-cover"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-primary-dark/80 to-transparent"></div>
        <div class="absolute bottom-8 left-[5vw]">
          <span v-if="store.currentSpot.level" class="bg-primary text-text-primary text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">
            {{ store.currentSpot.level }}
          </span>
          <h1 class="font-montserrat font-bold text-4xl text-text-primary">{{ store.currentSpot.name }}</h1>
        </div>
      </div>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="md:col-span-2">
          <h2 class="font-montserrat font-bold text-xl text-text-primary mb-4">景区介绍</h2>
          <p class="text-text-secondary leading-relaxed">{{ store.currentSpot.description }}</p>
        </div>
        <div class="bg-primary/20 border border-border-color rounded-lg p-6">
          <h3 class="font-montserrat font-bold text-text-primary mb-4">游览信息</h3>
          <div class="space-y-3 text-sm">
            <div class="flex justify-between">
              <span class="text-text-secondary">地址</span>
              <span class="text-text-primary">{{ store.currentSpot.address }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-secondary">开放时间</span>
              <span class="text-text-primary">{{ store.currentSpot.openHours }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-secondary">票务信息</span>
              <span class="text-text-primary">{{ store.currentSpot.ticketInfo || '免费' }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
