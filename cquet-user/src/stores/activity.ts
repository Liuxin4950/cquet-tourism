import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listActivity, getActivity, applyActivity } from '@/api/activity'

export const useActivityStore = defineStore('activity', () => {
  const activities = ref<any[]>([])
  const currentActivity = ref<any | null>(null)
  const total = ref(0)
  const isLoading = ref(false)

  const fetchActivities = async (query: { pageNum: number; pageSize: number; name?: string }) => {
    isLoading.value = true
    try {
      const res: any = await listActivity(query)
      activities.value = res.rows || res.data?.rows || []
      total.value = res.total || res.data?.total || 0
    } finally {
      isLoading.value = false
    }
  }

  const fetchActivityDetail = async (id: number) => {
    isLoading.value = true
    try {
      const res: any = await getActivity(id)
      currentActivity.value = res.data || res
    } finally {
      isLoading.value = false
    }
  }

  const apply = async (data: { activityId: number; userId?: number; remark?: string }) => {
    const res: any = await applyActivity(data)
    return res.code === 200 || res.code === 0
  }

  return { activities, currentActivity, total, isLoading, fetchActivities, fetchActivityDetail, apply }
})
