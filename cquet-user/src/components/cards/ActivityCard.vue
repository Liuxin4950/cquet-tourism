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
  }
}>()

const router = useRouter()

const progress = computed(() => {
  if (!props.activity.capacity || !props.activity.currentParticipants) return 0
  return Math.min(100, (props.activity.currentParticipants / props.activity.capacity) * 100)
})

const goDetail = () => {
  router.push(`/activities/${props.activity.id}`)
}
</script>

<template>
  <div
    class="group cursor-pointer border border-[#dfdfdf] rounded-[2px] p-[1.5vw] hover:border-brand transition-colors"
    @click="goDetail"
  >
    <div class="flex justify-between items-start mb-[0.8vw]">
      <h3 class="font-heading font-light text-[1vw] text-brand line-clamp-1 flex-1 group-hover:text-muted transition-colors">
        {{ activity.name }}
      </h3>
      <span
        class="text-[0.6vw] font-body px-[0.8vw] py-[0.2vw] rounded-pill ml-[0.5vw] shrink-0"
        :class="{
          'bg-green-100 text-green-700': activity.status === '进行中',
          'bg-yellow-100 text-yellow-700': activity.status === '报名中',
          'bg-gray-100 text-gray-500': !activity.status || activity.status === '已结束',
        }"
      >
        {{ activity.status || '报名中' }}
      </span>
    </div>
    <p class="font-body text-[0.75vw] text-muted line-clamp-2 mb-[1vw]">{{ activity.description || '' }}</p>
    <div class="flex justify-between text-[0.65vw] text-muted/70 mb-[1vw]">
      <span>{{ activity.venueName || '' }}</span>
      <span>{{ activity.startTime ? activity.startTime.slice(0, 10) : '' }}</span>
    </div>
    <div v-if="activity.capacity" class="mt-auto">
      <div class="h-[2px] bg-[#dfdfdf] rounded-full overflow-hidden">
        <div class="h-full bg-brand rounded-full transition-all" :style="{ width: progress + '%' }"></div>
      </div>
      <p class="font-body text-[0.6vw] text-muted/60 mt-[0.3vw]">{{ activity.currentParticipants || 0 }}/{{ activity.capacity }} 人</p>
    </div>
  </div>
</template>
