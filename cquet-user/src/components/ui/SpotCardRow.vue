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
    class="flex flex-col md:flex-row border-t border-dark/10 cursor-pointer group hover:bg-light transition-colors duration-200"
    @click="goDetail"
    :aria-label="`查看 ${spot.name} 详情`"
  >
    <!-- 图片区域 -->
    <div class="w-full md:w-1/3 aspect-[16/9] md:aspect-[4/3] overflow-hidden bg-[#e8e6e3] flex-shrink-0">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="spot.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
      />
      <div v-else class="w-full h-full flex items-center justify-center text-muted">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
      </div>
    </div>

    <!-- 内容区域 -->
    <div class="flex-1 p-5 md:p-6 flex flex-col justify-center min-h-[120px]">
      <span class="font-montserrat text-[11px] tracking-[0.15em] text-muted uppercase mb-1">
        {{ spot.level || '暂无等级' }}
      </span>
      <h3 class="font-heading font-light text-brand text-lg mb-1 group-hover:text-muted transition-colors line-clamp-1">
        {{ spot.name || '暂无名称' }}
      </h3>
      <p class="font-body text-muted text-sm line-clamp-2 mb-2">{{ spot.description || '暂无描述...' }}</p>
      <p class="font-body text-muted/70 text-xs">
        <span v-if="spot.city">{{ spot.city }}</span>
        <span v-if="spot.city && spot.openHours"> · </span>
        <span v-if="spot.openHours">{{ spot.openHours }}</span>
        <span v-if="!spot.city && !spot.openHours">暂无更多信息</span>
      </p>
    </div>
  </article>
</template>
