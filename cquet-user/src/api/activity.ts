import request from './request'

export interface Activity {
  id: number
  name: string
  category?: string
  type?: string
  coverImage?: string
  venueId: number
  venueName?: string
  startTime: string
  endTime: string
  description: string
  organizer?: string
  contactPhone?: string
  currentParticipants?: number
  maxParticipants?: number
  status: string
  auditStatus?: string
  auditReason?: string
  auditor?: string
  auditTime?: string
  applicantName?: string
  applyReason?: string
  applyTime?: string
  createTime?: string
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
