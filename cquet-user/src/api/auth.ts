import request from './request'

const API_BASE = import.meta.env.VITE_API_BASE_URL || ''

export interface LoginParams {
  username: string
  password: string
}

export interface LoginResult {
  token: string
  userInfo: {
    userId: number
    username: string
    nickName: string
    phone: string
    avatar?: string
  }
}

export const login = (data: LoginParams) => {
  return request.post<any, any>(`${API_BASE}/login`, data)
}

export const getInfo = () => {
  return request.get<any, any>(`${API_BASE}/getInfo`)
}
