import request from './request'

export interface Venue {
  id: number
  name: string
  type?: string
  category?: string
  province?: string
  city?: string
  district?: string
  address?: string
  description?: string
  capacity?: number
  openHours?: string
  openingHours?: string
  ticketInfo?: string
  ticketPrice?: number | string
  coverImage?: string
  images?: string[]
  contactPhone?: string
  website?: string
  bookingRequired?: string
  status?: string
  facilities?: string[] | string | null
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
