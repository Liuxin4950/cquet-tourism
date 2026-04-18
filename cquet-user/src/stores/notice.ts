import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listNotice, getNotice } from '@/api/notice'

export const useNoticeStore = defineStore('notice', () => {
  const noticeList = ref<any[]>([])
  const currentNotice = ref<any | null>(null)
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchNoticeList = async (query: { pageNum: number; pageSize: number; title?: string; startDate?: string; endDate?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listNotice(query)
      noticeList.value = (res.rows || res.data?.rows || []).map((n: any) => ({
        ...n,
        // 兼容不同字段名
        publishTime: n.publishTime || n.createTime || ''
      }))
      total.value = res.total || res.data?.total || 0
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchNoticeDetail = async (id: number) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await getNotice(id)
      currentNotice.value = res.data || res
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  return { noticeList, currentNotice, total, isLoading, error, fetchNoticeList, fetchNoticeDetail }
})
