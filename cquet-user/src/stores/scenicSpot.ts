import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listScenicSpot, getScenicSpot, listScenicSpotImages } from '@/api/scenicSpot'

export const useScenicSpotStore = defineStore('scenicSpot', () => {
  const spots = ref<any[]>([])
  const currentSpot = ref<any | null>(null)
  const spotImages = ref<string[]>([])
  const total = ref(0)
  const isLoading = ref(false)

  const fetchSpots = async (query: { pageNum: number; pageSize: number; name?: string }) => {
    isLoading.value = true
    try {
      const res: any = await listScenicSpot(query)
      spots.value = res.rows || res.data?.rows || []
      total.value = res.total || res.data?.total || 0
    } finally {
      isLoading.value = false
    }
  }

  const fetchSpotDetail = async (id: number) => {
    isLoading.value = true
    try {
      const res: any = await getScenicSpot(id)
      currentSpot.value = res.data || res
    } finally {
      isLoading.value = false
    }
  }

  const fetchSpotImages = async (id: number) => {
    const res: any = await listScenicSpotImages(id)
    spotImages.value = res.data || res || []
  }

  return { spots, currentSpot, spotImages, total, isLoading, fetchSpots, fetchSpotDetail, fetchSpotImages }
})
