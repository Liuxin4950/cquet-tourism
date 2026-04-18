import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listNews, getNews } from '@/api/news'
import { imgUrl } from '@/utils/imgUrl'

export const useNewsStore = defineStore('news', () => {
  const newsList = ref<any[]>([])
  const currentNews = ref<any | null>(null)
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchNewsList = async (query: { pageNum: number; pageSize: number; title?: string; startDate?: string; endDate?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listNews(query)
      const list: any[] = res.rows || res.data?.rows || []
      newsList.value = list.map(n => ({
        ...n,
        coverImage: n.coverImage ? imgUrl(n.coverImage) : '',
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

  const fetchNewsDetail = async (id: number) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await getNews(id)
      const data = res.data || res
      currentNews.value = data ? { ...data, coverImage: data.coverImage ? imgUrl(data.coverImage) : '' } : null
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  return { newsList, currentNews, total, isLoading, error, fetchNewsList, fetchNewsDetail }
})
