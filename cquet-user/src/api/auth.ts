import request from './request'

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
  return request.post<any, any>('/login', data)
}

export const getInfo = () => {
  return request.get<any, any>('/getInfo')
}
