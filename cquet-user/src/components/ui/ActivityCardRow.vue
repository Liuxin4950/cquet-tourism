<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps<{
  activity: {
    id: number
    name: string
    type?: string
    venueName?: string
    startTime?: string
    endTime?: string
    description?: string
    status?: string
    capacity?: number
    currentParticipants?: number
    images?: string[]
  }
}>()

const router = useRouter()

const coverImage = computed(() => props.activity.images?.[0] || '')
const hasImage = computed(() => !!coverImage.value)

const statusColor = computed(() => {
  const s = props.activity.status
  if (s === '报名中') return 'text-green-600 bg-green-50'
  if (s === '进行中') return 'text-blue-600 bg-blue-50'
  if (s === '已结束') return 'text-muted bg-light'
  if (s === '已取消') return 'text-red-600 bg-red-50'
  return 'text-muted bg-light'
})

const goDetail = () => {
  router.push(`/activities/${props.activity.id}`)
}
</script>

<template>
  <article
    class="flex flex-col md:flex-row border-t border-dark/10 cursor-pointer group hover:bg-light transition-colors duration-200"
    @click="goDetail"
    :aria-label="`查看 ${activity.name} 详情`"
  >
    <!-- 图片区域 -->
    <div class="w-full md:w-1/3 aspect-[16/9] md:aspect-[4/3] overflow-hidden bg-[#e8e6e3] flex-shrink-0">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="activity.name"
        loading="lazy"
        class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
      />
      <div v-else class="w-full h-full flex items-center justify-center text-muted">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
        </svg>
      </div>
    </div>

    <!-- 内容区域 -->
    <div class="flex-1 p-5 md:p-6 flex flex-col justify-center min-h-[120px]">
      <div class="flex items-center gap-2 mb-1">
        <span class="font-montserrat text-[11px] tracking-[0.15em] text-muted uppercase">
          {{ activity.type || '暂无类型' }}
        </span>
        <span
          v-if="activity.status"
          class="font-montserrat text-[10px] tracking-wider px-2 py-0.5 rounded-full"
          :class="statusColor"
        >
          {{ activity.status }}
        </span>
      </div>
      <h3 class="font-heading font-light text-brand text-lg mb-1 group-hover:text-muted transition-colors line-clamp-1">
        {{ activity.name || '暂无名称' }}
      </h3>
      <p class="font-body text-muted text-sm line-clamp-2 mb-2">{{ activity.description || '暂无描述...' }}</p>
      <p class="font-body text-muted/70 text-xs">
        <span v-if="activity.venueName">{{ activity.venueName }}</span>
        <span v-if="activity.venueName && activity.startTime"> · </span>
        <span v-if="activity.startTime">{{ activity.startTime.slice(0, 10) }}</span>
        <span v-if="!activity.venueName && !activity.startTime">暂无时间地点</span>
      </p>
    </div>
  </article>
</template>
