import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listActivity, getActivity } from '@/api/activity'
import { imgUrl } from '@/utils/imgUrl'

export const useActivityStore = defineStore('activity', () => {
  const activities = ref<any[]>([])
  const currentActivity = ref<any | null>(null)
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchActivities = async (query: { pageNum: number; pageSize: number; name?: string; venueId?: number; status?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listActivity(query)
      const list: any[] = res.rows || res.data?.rows || []
      // coverImage → images[]，URL 经过 imgUrl 处理
      activities.value = list.map(a => ({
        ...a,
        images: a.coverImage ? [imgUrl(a.coverImage)] : [],
      }))
      total.value = res.total || res.data?.total || 0
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchActivityDetail = async (id: number) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await getActivity(id)
      const data = res.data || res
      // 统一 coverImage → images[]
      if (data && data.coverImage) {
        currentActivity.value = { ...data, images: [imgUrl(data.coverImage)] }
      } else {
        currentActivity.value = data
      }
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  return { activities, currentActivity, total, isLoading, error, fetchActivities, fetchActivityDetail }
})
