import request from './request'

export interface Notice {
  id: number
  title: string
  content: string
  publishTime: string
}

export interface NoticeQuery {
  pageNum: number
  pageSize: number
  title?: string
  startDate?: string
  endDate?: string
}

export const listNotice = (query: NoticeQuery) => {
  return request.get<any, any>('/web/tourism/notice/list', { params: query })
}

export const getNotice = (id: number) => {
  return request.get<any, any>(`/web/tourism/notice/${id}`)
}
