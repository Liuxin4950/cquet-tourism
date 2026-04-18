<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

export interface Spot {
  id: number
  name: string
  level?: string
  city?: string
  description?: string
  openHours?: string
  images?: string[]
}

const props = defineProps<{
  spot: Spot
}>()

const router = useRouter()

const coverImage = computed(() => {
  return props.spot.images?.[0] || ''
})

const hasImage = computed(() => !!coverImage.value)

const goDetail = () => {
  router.push(`/spots/${props.spot.id}`)
}
</script>

<template>
  <div
    class="group cursor-pointer border border-border rounded overflow-hidden hover:border-brand transition-colors"
    @click="goDetail"
  >
    <!-- 图片 -->
    <div class="aspect-[4/3] bg-[#e8e6e3] flex items-center justify-center">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="spot.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
      />
      <div v-else class="flex flex-col items-center justify-center text-[#648992]">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 mb-2 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
        <span class="text-[11px] font-body opacity-60">暂无图片</span>
      </div>
    </div>
    <!-- 内容 -->
    <div class="p-6">
    <!-- 标签 -->
    <span
      v-if="spot.level"
      class="inline-block font-body text-card-meta tracking-[0.15em] text-muted uppercase mb-2"
    >
      {{ spot.level }}
    </span>
    <span v-else class="inline-block font-body text-card-meta tracking-[0.15em] text-muted uppercase mb-2">暂无等级</span>
    <!-- 标题 -->
    <h3 class="font-heading font-light text-card-title text-brand mb-1 line-clamp-1 group-hover:text-muted transition-colors">
      {{ spot.name || '暂无名称' }}
    </h3>
    <!-- 描述 -->
    <p class="font-body text-card-desc text-muted line-clamp-2 mb-1">{{ spot.description || '暂无内容...' }}</p>
    <!-- 底部信息 -->
    <p class="font-body text-card-meta text-muted/70">{{ spot.city || '暂无地区信息' }}</p>
    </div>
  </div>
</template>
