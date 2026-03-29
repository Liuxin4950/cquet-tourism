<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps<{
  venue: {
    id: number
    name: string
    type?: string
    city?: string
    description?: string
    openHours?: string
    images?: string[]
  }
}>()

const router = useRouter()

const coverImage = computed(() => {
  return props.venue.images?.[0] || `https://picsum.photos/600/400?random=${props.venue.id}`
})

const goDetail = () => {
  router.push(`/venues/${props.venue.id}`)
}
</script>

<template>
  <div
    class="group cursor-pointer"
    @click="goDetail"
  >
    <div class="aspect-[4/3] bg-[#dfdfdf] rounded-[2px] overflow-hidden mb-[1vw]">
      <img
        :src="coverImage"
        :alt="venue.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
      />
    </div>
    <span
      v-if="venue.type"
      class="inline-block font-body text-[0.6vw] tracking-[0.15em] text-muted uppercase mb-[0.5vw]"
    >
      {{ venue.type }}
    </span>
    <h3 class="font-heading font-light text-[1vw] text-brand mb-[0.4vw] line-clamp-1 group-hover:text-[#648992] transition-colors">
      {{ venue.name }}
    </h3>
    <p class="font-body text-[0.75vw] text-muted line-clamp-2 mb-[0.4vw]">{{ venue.description || '' }}</p>
    <p class="font-body text-[0.65vw] text-muted/70">{{ venue.city || '' }}</p>
  </div>
</template>
