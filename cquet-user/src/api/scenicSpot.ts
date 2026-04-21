import request from './request'

export interface ScenicSpotVenue {
  id: number
  name?: string
  address?: string
  capacity?: number
  description?: string
  facilities?: string[] | string
  images?: string[]
}

export interface ScenicSpot {
  id: number
  name: string
  level: string
  province?: string
  city?: string
  district?: string
  address: string
  description?: string
  openTime?: string
  openHours?: string
  openingHours?: string
  ticketInfo?: string
  ticketPrice?: number | string
  coverImage?: string
  images?: string[]
  status?: string
  venues?: ScenicSpotVenue[]
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
