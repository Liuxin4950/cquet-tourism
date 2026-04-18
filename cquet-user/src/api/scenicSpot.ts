import request from './request'

export interface ScenicSpot {
  id: number
  name: string
  level: string
  province: string
  city: string
  address: string
  description: string
  openHours: string
  ticketInfo: string
  images: string[]
}

export interface ScenicSpotQuery {
  pageNum: number
  pageSize: number
  name?: string
  city?: string
  level?: string
}

export const listScenicSpot = (query: ScenicSpotQuery) => {
  return request.get<any, any>('/web/tourism/scenic-spot/list', { params: query })
}

export const getScenicSpot = (id: number) => {
  return request.get<any, any>(`/web/tourism/scenic-spot/${id}`)
}

export const listScenicSpotImages = (id: number) => {
  return request.get<any, any>(`/web/tourism/scenic-spot/${id}/images`)
}
