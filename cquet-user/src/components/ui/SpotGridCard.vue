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

const coverImage = computed(() => props.spot.images?.[0] || '')
const hasImage = computed(() => !!coverImage.value)

const goDetail = () => {
  router.push(`/spots/${props.spot.id}`)
}
</script>

<template>
  <article
    class="grid-card cursor-pointer"
    @click="goDetail"
    :aria-label="`查看 ${spot.name} 详情`"
  >
    <!-- 图片 -->
    <div class="aspect-[4/3] bg-[#e8e6e3] overflow-hidden">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="spot.name"
        loading="lazy"
        class="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
      />
      <div v-else class="w-full h-full flex flex-col items-center justify-center text-[#648992]">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 mb-2 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
        <span class="text-[11px] font-body opacity-60">暂无图片</span>
      </div>
    </div>
    <!-- 内容 -->
    <div class="p-4 lg:p-5">
      <span
        v-if="spot.level"
        class="inline-block font-body text-[10px] tracking-[0.15em] text-muted uppercase mb-2"
      >
        {{ spot.level }}
      </span>
      <span v-else class="inline-block font-body text-[10px] tracking-[0.15em] text-muted uppercase mb-2">暂无等级</span>
      <h3 class="font-heading font-light text-[15px] text-brand mb-1.5 line-clamp-1 hover:text-muted transition-colors">
        {{ spot.name || '暂无名称' }}
      </h3>
      <p class="font-body text-[12px] text-muted line-clamp-2 mb-2">{{ spot.description || '暂无内容...' }}</p>
      <p class="font-body text-[11px] text-muted/70">{{ spot.city || '暂无地区信息' }}</p>
    </div>
  </article>
</template>
