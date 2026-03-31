<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

export interface Venue {
  id: number
  name: string
  type?: string
  city?: string
  description?: string
  openHours?: string
  images?: string[]
}

const props = defineProps<{
  venue: Venue
}>()

const router = useRouter()

const coverImage = computed(() => {
  return props.venue.images?.[0] || ''
})

const hasImage = computed(() => !!coverImage.value)

const goDetail = () => {
  router.push(`/venues/${props.venue.id}`)
}
</script>

<template>
  <div
    class="group cursor-pointer"
    @click="goDetail"
  >
    <div class="aspect-[4/3] bg-[#e8e6e3] rounded overflow-hidden mb-4 flex items-center justify-center">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="venue.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
      />
      <div v-else class="flex flex-col items-center justify-center text-[#648992]">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 mb-2 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
        </svg>
        <span class="text-[11px] font-body opacity-60">暂无图片</span>
      </div>
    </div>
    <span
      v-if="venue.type"
      class="inline-block font-body text-card-meta tracking-[0.15em] text-muted uppercase mb-2"
    >
      {{ venue.type }}
    </span>
    <h3 class="font-heading font-light text-card-title text-brand mb-1 line-clamp-1 group-hover:text-muted transition-colors">
      {{ venue.name }}
    </h3>
    <p class="font-body text-card-desc text-muted line-clamp-2 mb-1">{{ venue.description || '' }}</p>
    <p class="font-body text-card-meta text-muted/70">{{ venue.city || '' }}</p>
  </div>
</template>
