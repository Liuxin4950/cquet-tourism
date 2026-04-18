import request from './request'

export interface Activity {
  id: number
  name: string
  type: string
  venueId: number
  venueName: string
  startTime: string
  endTime: string
  description: string
  capacity: number
  currentParticipants: number
  status: string
}

export interface ActivityQuery {
  pageNum: number
  pageSize: number
  name?: string
  venueId?: number
  auditStatus?: string
}

export const listActivity = (query: ActivityQuery) => {
  return request.get<any, any>('/web/tourism/activity/list', { params: query })
}

export const getActivity = (id: number) => {
  return request.get<any, any>(`/web/tourism/activity/${id}`)
}
