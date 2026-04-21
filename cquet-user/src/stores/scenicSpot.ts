import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listScenicSpot, getScenicSpot, listScenicSpotImages } from '@/api/scenicSpot'
import { imgUrl } from '@/utils/imgUrl'

const normalizeImageList = (source: any): string[] => {
  if (!source) return []
  const list = Array.isArray(source) ? source : String(source).split(',')
  return list
    .map((item: any) => {
      if (!item) return ''
      if (typeof item === 'string') return item.trim()
      return item.url || item.imageUrl || item.path || ''
    })
    .filter(Boolean)
    .map((item: string) => imgUrl(item))
}

export const useScenicSpotStore = defineStore('scenicSpot', () => {
  const spots = ref<any[]>([])
  const currentSpot = ref<any | null>(null)
  const spotImages = ref<string[]>([])
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchSpots = async (query: { pageNum: number; pageSize: number; name?: string; city?: string; level?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listScenicSpot(query)
      const list: any[] = res.rows || res.data?.rows || []
      // 统一 coverImage → images[] 格式，兼容卡片组件；URL 经过 imgUrl 处理
      spots.value = list.map(s => ({
        ...s,
        images: s.coverImage ? [imgUrl(s.coverImage)] : [],
      }))
      total.value = res.total || res.data?.total || 0
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchSpotDetail = async (id: number) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await getScenicSpot(id)
      const body = res.data || res
      const detail = body.data || body
      const detailImages = normalizeImageList(detail.images)
      const coverImages = normalizeImageList(detail.coverImage)
      currentSpot.value = {
        ...detail,
        images: detailImages.length > 0 ? detailImages : coverImages,
      }
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchSpotImages = async (id: number) => {
    try {
      const res: any = await listScenicSpotImages(id)
      const body = res.data || res
      const images: any[] = body.data || body || []
      spotImages.value = normalizeImageList(images)
    } catch (e) {
      console.warn(`fetchSpotImages(${id}) failed:`, e)
      spotImages.value = []
    }
  }

  return { spots, currentSpot, spotImages, total, isLoading, error, fetchSpots, fetchSpotDetail, fetchSpotImages }
})
