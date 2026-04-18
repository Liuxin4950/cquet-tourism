import request from './request'

export interface Venue {
  id: number
  name: string
  type: string
  province: string
  city: string
  address: string
  description: string
  capacity: number
  openHours: string
  ticketInfo: string
  images: string[]
}

export interface VenueQuery {
  pageNum: number
  pageSize: number
  name?: string
  city?: string
}

export const listVenue = (query: VenueQuery) => {
  return request.get<any, any>('/web/tourism/venue/list', { params: query })
}

export const getVenue = (id: number) => {
  return request.get<any, any>(`/web/tourism/venue/${id}`)
}

export const listVenueImages = (id: number) => {
  return request.get<any, any>(`/web/tourism/venue/${id}/images`)
}
