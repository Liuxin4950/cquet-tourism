<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useActivityStore } from '@/stores/activity'
import { useAuthStore } from '@/stores/auth'

const props = defineProps<{ id: string }>()
const store = useActivityStore()
const authStore = useAuthStore()
const route = useRoute()
const remark = ref('')
const applyStatus = ref<'idle' | 'submitting' | 'submitted' | 'error'>('idle')
const applyErrorMsg = ref('')

onMounted(() => {
  const activityId = Number(props.id || route.params.id)
  store.fetchActivityDetail(activityId)
})

const handleRetry = () => {
  const activityId = Number(props.id || route.params.id)
  store.fetchActivityDetail(activityId)
}

const handleApply = async () => {
  if (!authStore.isAuthenticated()) {
    applyErrorMsg.value = '请先登录'
    return
  }
  const activityId = Number(props.id || route.params.id)
  applyStatus.value = 'submitting'
  applyErrorMsg.value = ''
  const result = await store.apply({ activityId, remark: remark.value })
  if (result.ok) {
    applyStatus.value = 'submitted'
  } else {
    applyStatus.value = 'error'
    applyErrorMsg.value = result.msg || '报名失败，请稍后重试'
  }
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <LoadingState :isLoading="store.isLoading" />
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
          <div>
            <span class="text-muted block mb-1">活动时间</span>
            <span class="text-brand">{{ store.currentActivity.startTime?.slice(0, 16) || '暂无时间' }} ~ {{ store.currentActivity.endTime?.slice(0, 16) || '暂无时间' }}</span>
          </div>
          <div>
            <span class="text-muted block mb-1">活动地点</span>
            <span class="text-brand">{{ store.currentActivity.venueName || '暂无场馆信息' }}</span>
          </div>
          <div>
            <span class="text-muted block mb-1">活动类型</span>
            <span class="text-brand">{{ store.currentActivity.type || '暂无类型' }}</span>
          </div>
          <div>
            <span class="text-muted block mb-1">报名人数</span>
            <span class="text-brand">{{ store.currentActivity.currentParticipants || 0 }} / {{ store.currentActivity.capacity || '暂无' }}</span>
          </div>
        </div>
      </div>

      <!-- 报名区 -->
      <div class="bg-dark border border-border rounded-lg p-6 max-w-lg">
        <h3 class="font-montserrat font-bold text-brand mb-4">立即报名</h3>

        <!-- 已提交待审核状态 -->
        <div v-if="applyStatus === 'submitted'" class="text-center py-4">
          <div class="w-12 h-12 bg-[#105670]/20 rounded-full flex items-center justify-center mx-auto mb-3">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-[#105670]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
            </svg>
          </div>
          <p class="font-heading text-[16px] text-brand mb-1">报名已提交</p>
          <p class="text-xs text-muted">请等待管理员审核，审核结果将通过站内消息通知</p>
        </div>

        <!-- 提交中状态 -->
        <div v-else-if="applyStatus === 'submitting'" class="text-center py-4">
          <p class="text-sm text-muted">提交中...</p>
        </div>

        <!-- 错误状态 -->
        <div v-else-if="applyStatus === 'error'">
          <p class="text-red-400 text-xs mb-3">{{ applyErrorMsg }}</p>
          <button
            @click="handleApply"
            class="w-full bg-brand text-brand py-3 text-xs font-montserrat tracking-wider rounded hover:bg-brand-light transition-colors"
          >
            重新提交
          </button>
        </div>

        <!-- 报名表单 -->
        <div v-else>
          <textarea
            v-model="remark"
            placeholder="备注信息（选填）"
            class="w-full bg-dark border border-border text-brand px-4 py-3 rounded text-sm mb-4 focus:border-brand outline-none resize-none"
            rows="3"
          ></textarea>
          <button
            @click="handleApply"
            class="w-full bg-brand text-white py-3 text-xs font-montserrat tracking-wider rounded hover:bg-brand-light transition-colors"
          >
            提交报名
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
