import { defineStore } from 'pinia'
import { ref } from 'vue'
import { listVenue, getVenue, listVenueImages } from '@/api/venue'

export const useVenueStore = defineStore('venue', () => {
  const venues = ref<any[]>([])
  const currentVenue = ref<any | null>(null)
  const venueImages = ref<string[]>([])
  const total = ref(0)
  const isLoading = ref(false)

  const fetchVenues = async (query: { pageNum: number; pageSize: number; name?: string }) => {
    isLoading.value = true
    try {
      const res: any = await listVenue(query)
      venues.value = res.rows || res.data?.rows || []
      total.value = res.total || res.data?.total || 0
    } finally {
      isLoading.value = false
    }
  }

  const fetchVenueDetail = async (id: number) => {
    isLoading.value = true
    try {
      const res: any = await getVenue(id)
      currentVenue.value = res.data || res
    } finally {
      isLoading.value = false
    }
  }

  const fetchVenueImages = async (id: number) => {
    const res: any = await listVenueImages(id)
    venueImages.value = res.data || res || []
  }

  return { venues, currentVenue, venueImages, total, isLoading, fetchVenues, fetchVenueDetail, fetchVenueImages }
})
