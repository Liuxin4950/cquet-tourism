import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listVenue, getVenue, listVenueImages } from '@/api/venue'
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

export const useVenueStore = defineStore('venue', () => {
  const venues = ref<any[]>([])
  const currentVenue = ref<any | null>(null)
  const venueImages = ref<string[]>([])
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchVenues = async (query: { pageNum: number; pageSize: number; name?: string; city?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listVenue(query)
      const list: any[] = res.rows || res.data?.rows || []
      // 统一 coverImage → images[]；category → type（兼容前端类型）；URL 经过 imgUrl 处理
      venues.value = list.map(v => ({
        ...v,
        type: v.type || v.category,
        images: normalizeImageList(v.images).length > 0 ? normalizeImageList(v.images) : normalizeImageList(v.coverImage),
      }))
      total.value = res.total || res.data?.total || 0
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchVenueDetail = async (id: number) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await getVenue(id)
      const body = res.data || res
      const detail = body.data || body
      const detailImages = normalizeImageList(detail.images)
      const coverImages = normalizeImageList(detail.coverImage)
      currentVenue.value = {
        ...detail,
        type: detail.type || detail.category,
        images: detailImages.length > 0 ? detailImages : coverImages,
      }
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchVenueImages = async (id: number) => {
    try {
      const res: any = await listVenueImages(id)
      const body = res.data || res
      const images: any[] = body.data || body || []
      venueImages.value = normalizeImageList(images)
    } catch (e) {
      console.warn(`fetchVenueImages(${id}) failed:`, e)
      venueImages.value = []
    }
  }

  return { venues, currentVenue, venueImages, total, isLoading, error, fetchVenues, fetchVenueDetail, fetchVenueImages }
})
