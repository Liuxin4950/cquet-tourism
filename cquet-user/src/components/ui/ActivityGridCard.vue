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
    capacity?: number
    currentParticipants?: number
    status?: string
    images?: string[]
  }
}>()

const router = useRouter()

const coverImage = computed(() => props.activity.images?.[0] || '')
const hasImage = computed(() => !!coverImage.value)

const progress = computed(() => {
  if (!props.activity.capacity || !props.activity.currentParticipants) return 0
  return Math.min(100, (props.activity.currentParticipants / props.activity.capacity) * 100)
})

const goDetail = () => {
  router.push(`/activities/${props.activity.id}`)
}
</script>

<template>
  <article
    class="grid-card cursor-pointer"
    @click="goDetail"
    :aria-label="`查看 ${activity.name} 详情`"
  >
    <!-- 图片 -->
    <div class="aspect-[4/3] bg-[#e8e6e3] overflow-hidden">
      <img
        v-if="hasImage"
        :src="coverImage"
        :alt="activity.name"
        loading="lazy"
        class="w-full h-full object-cover hover:scale-105 transition-transform duration-500"
      />
      <div v-else class="w-full h-full flex flex-col items-center justify-center text-[#648992]">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 h-10 mb-2 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" />
        </svg>
        <span class="text-[11px] font-body opacity-60">暂无图片</span>
      </div>
    </div>
    <!-- 内容 -->
    <div class="p-4 lg:p-5">
      <div class="flex justify-between items-start mb-2">
        <h3 class="font-heading font-light text-[15px] text-brand line-clamp-1 flex-1 hover:text-muted transition-colors">
          {{ activity.name || '暂无名称' }}
        </h3>
        <span
          v-if="activity.status"
          class="text-[10px] font-body px-2 py-0.5 rounded-full ml-2 shrink-0"
          :class="{
            'bg-green-100 text-green-700': activity.status === '进行中',
            'bg-yellow-100 text-yellow-700': activity.status === '报名中',
            'bg-gray-100 text-gray-500': !activity.status || activity.status === '已结束',
          }"
        >
          {{ activity.status }}
        </span>
      </div>
      <p class="font-body text-[12px] text-muted line-clamp-2 mb-3">{{ activity.description || '暂无内容...' }}</p>
      <div class="flex justify-between text-[11px] text-muted/70">
        <span>{{ activity.venueName || '暂无场馆信息' }}</span>
        <span>{{ activity.startTime ? activity.startTime.slice(0, 10) : '暂无时间' }}</span>
      </div>
      <div v-if="activity.capacity" class="mt-3">
        <div class="h-0.5 bg-[#e8e6e3] rounded-full overflow-hidden">
          <div class="h-full bg-brand rounded-full transition-all" :style="{ width: progress + '%' }"></div>
        </div>
        <p class="font-body text-[11px] text-muted/60 mt-1">{{ activity.currentParticipants || 0 }}/{{ activity.capacity }} 人</p>
      </div>
    </div>
  </article>
</template>
