<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps<{
  spot: {
    id: number
    name: string
    level?: string
    city?: string
    description?: string
    openHours?: string
    images?: string[]
  }
}>()

const router = useRouter()

const coverImage = computed(() => {
  return props.spot.images?.[0] || `https://picsum.photos/600/400?random=${props.spot.id}`
})

const goDetail = () => {
  router.push(`/spots/${props.spot.id}`)
}
</script>

<template>
  <div
    class="group cursor-pointer"
    @click="goDetail"
  >
    <!-- 图片 -->
    <div class="aspect-[4/3] bg-[#dfdfdf] rounded-[2px] overflow-hidden mb-[1vw]">
      <img
        :src="coverImage"
        :alt="spot.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
      />
    </div>
    <!-- 标签 -->
    <span
      v-if="spot.level"
      class="inline-block font-body text-[0.6vw] tracking-[0.15em] text-muted uppercase mb-[0.5vw]"
    >
      {{ spot.level }}
    </span>
    <!-- 标题 -->
    <h3 class="font-heading font-light text-[1vw] text-brand mb-[0.4vw] line-clamp-1 group-hover:text-[#648992] transition-colors">
      {{ spot.name }}
    </h3>
    <!-- 描述 -->
    <p class="font-body text-[0.75vw] text-muted line-clamp-2 mb-[0.4vw]">{{ spot.description || '' }}</p>
    <!-- 底部信息 -->
    <p class="font-body text-[0.65vw] text-muted/70">{{ spot.city || '' }}</p>
  </div>
</template>
