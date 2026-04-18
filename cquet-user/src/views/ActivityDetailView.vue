<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useActivityStore } from '@/stores/activity'

const props = defineProps<{ id: string }>()
const store = useActivityStore()
const route = useRoute()

onMounted(() => {
  const activityId = Number(props.id || route.params.id)
  store.fetchActivityDetail(activityId)
})

const handleRetry = () => {
  const activityId = Number(props.id || route.params.id)
  store.fetchActivityDetail(activityId)
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
    <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
    <EmptyState v-else-if="!store.currentActivity" message="未找到该活动" />
    <div v-else-if="store.currentActivity" class="px-6 lg:px-8 py-8">
      <div class="bg-brand/20 border border-border rounded-lg p-8 mb-8">
        <div class="flex justify-between items-start mb-4">
          <div>
            <span
              class="text-xs font-montserrat px-3 py-1 rounded mb-3 inline-block"
              :class="{
                'bg-green-600/20 text-green-400': store.currentActivity.status === '进行中',
                'bg-yellow-600/20 text-yellow-400': store.currentActivity.status === '报名中',
                'bg-gray-600/20 text-gray-400': store.currentActivity.status === '已结束',
              }"
            >
              {{ store.currentActivity.status || '暂无状态' }}
            </span>
            <h1 class="font-montserrat font-bold text-4xl text-brand">{{ store.currentActivity.name || '暂无名称' }}</h1>
          </div>
        </div>
        <p class="text-muted leading-relaxed mb-6">{{ store.currentActivity.description || '暂无内容...' }}</p>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 text-sm">
          <div class="min-h-[48px]">
            <span class="text-muted block mb-1">活动时间</span>
            <span class="text-brand">{{ store.currentActivity.startTime?.slice(0, 16) || '暂无时间' }} ~ {{ store.currentActivity.endTime?.slice(0, 16) || '暂无时间' }}</span>
          </div>
          <div class="min-h-[48px]">
            <span class="text-muted block mb-1">活动地点</span>
            <span class="text-brand">{{ store.currentActivity.venueName || '暂无场馆信息' }}</span>
          </div>
          <div class="min-h-[48px]">
            <span class="text-muted block mb-1">活动类型</span>
            <span class="text-brand">{{ store.currentActivity.type || store.currentActivity.category || '暂无类型' }}</span>
          </div>
          <div class="min-h-[48px]">
            <span class="text-muted block mb-1">参与人数</span>
            <span class="text-brand">{{ store.currentActivity.currentParticipants || 0 }} / {{ store.currentActivity.capacity || '暂无' }}</span>
          </div>
        </div>
      </div>

      <div class="bg-dark border border-border rounded-lg p-6 max-w-lg">
        <h3 class="font-montserrat font-bold text-brand mb-4">功能规划</h3>
        <p class="text-sm text-muted leading-7">
          当前用户端仅提供活动展示与信息查询。后续接入 Python 智能体后，登录用户可基于站内数据获得路线规划与个性化推荐，并按使用次数进行控制。
        </p>
      </div>
    </div>
  </div>
</template>
