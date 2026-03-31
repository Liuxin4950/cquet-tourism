import request from './request'

export interface News {
  id: number
  title: string
  content: string
  author: string
  publishTime: string
  coverImage?: string
}

export interface NewsQuery {
  pageNum: number
  pageSize: number
  title?: string
  startDate?: string
  endDate?: string
}

export const listNews = (query: NewsQuery) => {
  return request.get<any, any>('/tourism/news/list', { params: query })
}

export const getNews = (id: number) => {
  return request.get<any, any>(`/tourism/news/${id}`)
}
