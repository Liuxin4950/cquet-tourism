<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import LoadingState from '@/components/ui/LoadingState.vue'
import { useActivityStore } from '@/stores/activity'
import { useAuthStore } from '@/stores/auth'

const props = defineProps<{ id: string }>()
const store = useActivityStore()
const authStore = useAuthStore()
const route = useRoute()
const remark = ref('')
const applySuccess = ref(false)
const applyError = ref('')

onMounted(() => {
  const activityId = Number(props.id || route.params.id)
  store.fetchActivityDetail(activityId)
})

const handleApply = async () => {
  if (!authStore.isAuthenticated()) {
    applyError.value = '请先登录'
    return
  }
  const activityId = Number(props.id || route.params.id)
  const ok = await store.apply({ activityId, remark: remark.value })
  if (ok) {
    applySuccess.value = true
  } else {
    applyError.value = '报名失败，请重试'
  }
}
</script>

<template>
  <div class="min-h-screen bg-primary-dark pt-[72px]">
    <LoadingState :isLoading="store.isLoading" />
    <div v-else-if="store.currentActivity" class="px-[5vw] py-8">
      <div class="bg-primary/20 border border-border-color rounded-lg p-8 mb-8">
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
              {{ store.currentActivity.status || '报名中' }}
            </span>
            <h1 class="font-montserrat font-bold text-4xl text-text-primary">{{ store.currentActivity.name }}</h1>
          </div>
        </div>
        <p class="text-text-secondary leading-relaxed mb-6">{{ store.currentActivity.description }}</p>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 text-sm">
          <div>
            <span class="text-text-secondary block mb-1">活动时间</span>
            <span class="text-text-primary">{{ store.currentActivity.startTime?.slice(0, 16) || '' }} ~ {{ store.currentActivity.endTime?.slice(0, 16) || '' }}</span>
          </div>
          <div>
            <span class="text-text-secondary block mb-1">活动地点</span>
            <span class="text-text-primary">{{ store.currentActivity.venueName }}</span>
          </div>
          <div>
            <span class="text-text-secondary block mb-1">活动类型</span>
            <span class="text-text-primary">{{ store.currentActivity.type }}</span>
          </div>
          <div>
            <span class="text-text-secondary block mb-1">报名人数</span>
            <span class="text-text-primary">{{ store.currentActivity.currentParticipants || 0 }} / {{ store.currentActivity.capacity }}</span>
          </div>
        </div>
      </div>

      <!-- 报名区 -->
      <div class="bg-primary-dark border border-border-color rounded-lg p-6 max-w-lg">
        <h3 class="font-montserrat font-bold text-text-primary mb-4">立即报名</h3>
        <div v-if="applySuccess" class="text-accent text-sm">报名成功！</div>
        <div v-else>
          <textarea
            v-model="remark"
            placeholder="备注信息（选填）"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm mb-4 focus:border-primary outline-none resize-none"
            rows="3"
          ></textarea>
          <p v-if="applyError" class="text-red-400 text-xs mb-3">{{ applyError }}</p>
          <button
            @click="handleApply"
            class="w-full bg-primary text-text-primary py-3 text-xs font-montserrat tracking-wider rounded hover:bg-primary-light transition-colors"
          >
            提交报名
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
