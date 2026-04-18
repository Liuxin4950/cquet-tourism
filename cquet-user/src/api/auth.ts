import request from './request'
import type { AxiosResponse } from 'axios'
import type { LoginPayload, UserInfoPayload } from '@/types/auth'

export interface LoginParams {
  username: string
  password: string
}

export const login = (data: LoginParams) => {
  return request.post<LoginPayload, AxiosResponse<LoginPayload>>('/login', data)
}

export const getInfo = () => {
  return request.get<UserInfoPayload, AxiosResponse<UserInfoPayload>>('/getInfo')
}

export const register = (data: LoginParams) => {
  return request.post('/register', data)
}
