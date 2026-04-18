<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps<{
  venue: {
    id: number
    name: string
    type?: string
    city?: string
    address?: string
    description?: string
    openHours?: string
    images?: string[]
  }
}>()

const router = useRouter()

const coverImage = computed(() => props.venue.images?.[0] || '')
const hasImage = computed(() => !!coverImage.value)

const goDetail = () => {
  router.push(`/venues/${props.venue.id}`)
}
</script>

<template>
  <article
    class="flex flex-col md:flex-row border-t border-dark/10 cursor-pointer group hover:bg-light transition-colors duration-200"
    @click="goDetail"
    :aria-label="`查看 ${venue.name} 详情`"
  >
    <!-- 图片区域 -->
    <div class="w-full md:w-1/3 aspect-[16/9] md:aspect-[4/3] overflow-hidden bg-[#e8e6e3] flex-shrink-0">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="venue.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
      />
      <div v-else class="w-full h-full flex items-center justify-center text-muted">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
        </svg>
      </div>
    </div>

    <!-- 内容区域 -->
    <div class="flex-1 p-5 md:p-6 flex flex-col justify-center min-h-[120px]">
      <span class="font-montserrat text-[11px] tracking-[0.15em] text-muted uppercase mb-1">
        {{ venue.type || '暂无类型' }}
      </span>
      <h3 class="font-heading font-light text-brand text-lg mb-1 group-hover:text-muted transition-colors line-clamp-1">
        {{ venue.name || '暂无名称' }}
      </h3>
      <p class="font-body text-muted text-sm line-clamp-2 mb-2">{{ venue.description || '暂无描述...' }}</p>
      <p class="font-body text-muted/70 text-xs">
        <span v-if="venue.city">{{ venue.city }}</span>
        <span v-if="venue.city && venue.openHours"> · </span>
        <span v-if="venue.openHours">{{ venue.openHours }}</span>
        <span v-if="!venue.city && !venue.openHours">暂无更多信息</span>
      </p>
    </div>
  </article>
</template>
