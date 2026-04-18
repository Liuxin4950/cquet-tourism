export interface ApiResponse<T = unknown> {
  code?: number
  msg?: string
  state?: boolean
  data?: T
  time?: number
}

export interface RawUserProfile {
  userId?: number
  username?: string
  nickName?: string
  email?: string
  phonenumber?: string
  phone?: string
  avatar?: string
  sex?: string
  deptId?: number
  status?: string
}

export interface UserProfile {
  userId: number | null
  username: string
  nickName: string
  email: string
  phone: string
  avatar: string
  sex: string
  deptId: number | null
  status: string
  roles: string[]
  permissions: string[]
}

export interface LoginNestedPayload {
  code?: number
  token?: string
  userInfo?: RawUserProfile
}

export interface LoginPayload extends ApiResponse<LoginNestedPayload | null> {
  token?: string
  userInfo?: RawUserProfile
}

export interface UserInfoPayload extends ApiResponse<RawUserProfile> {
  user?: RawUserProfile
  roles?: string[]
  permissions?: string[]
}
