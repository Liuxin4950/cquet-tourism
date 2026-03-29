<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import LoadingState from '@/components/ui/LoadingState.vue'
import { useVenueStore } from '@/stores/venue'

const props = defineProps<{ id: string }>()
const store = useVenueStore()
const route = useRoute()

onMounted(() => {
  const venueId = Number(props.id || route.params.id)
  store.fetchVenueDetail(venueId)
  store.fetchVenueImages(venueId)
})
</script>

<template>
  <div class="min-h-screen bg-primary-dark pt-[72px]">
    <LoadingState :isLoading="store.isLoading" />
    <div v-else-if="store.currentVenue" class="px-[5vw] py-8">
      <div class="relative h-[50vh] rounded-lg overflow-hidden mb-8">
        <img
          :src="store.venueImages[0] || 'https://picsum.photos/1920/800?random=' + id"
          :alt="store.currentVenue.name"
          class="w-full h-full object-cover"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-primary-dark/80 to-transparent"></div>
        <div class="absolute bottom-8 left-[5vw]">
          <span v-if="store.currentVenue.type" class="bg-accent text-primary-dark text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block">
            {{ store.currentVenue.type }}
          </span>
          <h1 class="font-montserrat font-bold text-4xl text-text-primary">{{ store.currentVenue.name }}</h1>
        </div>
      </div>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="md:col-span-2">
          <h2 class="font-montserrat font-bold text-xl text-text-primary mb-4">场馆介绍</h2>
          <p class="text-text-secondary leading-relaxed">{{ store.currentVenue.description }}</p>
        </div>
        <div class="bg-primary/20 border border-border-color rounded-lg p-6">
          <h3 class="font-montserrat font-bold text-text-primary mb-4">场馆信息</h3>
          <div class="space-y-3 text-sm">
            <div class="flex justify-between">
              <span class="text-text-secondary">地址</span>
              <span class="text-text-primary">{{ store.currentVenue.address }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-secondary">开放时间</span>
              <span class="text-text-primary">{{ store.currentVenue.openHours }}</span>
            </div>
            <div class="flex justify-between">
              <span class="text-text-secondary">容量</span>
              <span class="text-text-primary">{{ store.currentVenue.capacity }} 人</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
