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
  status?: string
}

export const listActivity = (query: ActivityQuery) => {
  return request.get<any, any>('/tourism/activity/list', { params: query })
}

export const getActivity = (id: number) => {
  return request.get<any, any>(`/tourism/activity/${id}`)
}

export const applyActivity = (data: { activityId: number; userId?: number; remark?: string }) => {
  return request.post<any, any>('/tourism/activity-approval', data)
}
