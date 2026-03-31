import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listScenicSpot, getScenicSpot, listScenicSpotImages } from '@/api/scenicSpot'

export const useScenicSpotStore = defineStore('scenicSpot', () => {
  const spots = ref<any[]>([])
  const currentSpot = ref<any | null>(null)
  const spotImages = ref<string[]>([])
  const total = ref(0)
  const isLoading = ref(false)
  const error = ref(false)

  const fetchSpots = async (query: { pageNum: number; pageSize: number; name?: string }) => {
    isLoading.value = true
    error.value = false
    try {
      const res: any = await listScenicSpot(query)
      spots.value = res.rows || res.data?.rows || []
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
      currentSpot.value = res.data || res
    } catch {
      error.value = true
    } finally {
      isLoading.value = false
    }
  }

  const fetchSpotImages = async (id: number) => {
    try {
      const res: any = await listScenicSpotImages(id)
      spotImages.value = res.data || res || []
    } catch (e) {
      console.warn(`fetchSpotImages(${id}) failed:`, e)
      spotImages.value = []
    }
  }

  return { spots, currentSpot, spotImages, total, isLoading, error, fetchSpots, fetchSpotDetail, fetchSpotImages }
})
