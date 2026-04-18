import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login as loginApi, getInfo as getInfoApi } from '@/api/auth'
import type { LoginParams } from '@/api/auth'
import type { LoginPayload, RawUserProfile, UserInfoPayload, UserProfile } from '@/types/auth'

const emptyUserProfile = (): UserProfile => ({
  userId: null,
  username: '',
  nickName: '',
  email: '',
  phone: '',
  avatar: '',
  sex: '',
  deptId: null,
  status: '',
  roles: [],
  permissions: [],
})

const isSuccessCode = (code?: number) => code === 200 || code === 0

const normalizeUserProfile = (
  raw?: RawUserProfile | null,
  roles: string[] = [],
  permissions: string[] = []
): UserProfile => {
  const base = emptyUserProfile()
  if (!raw) return { ...base, roles, permissions }

  return {
    userId: raw.userId ?? null,
    username: raw.username ?? '',
    nickName: raw.nickName ?? raw.username ?? '',
    email: raw.email ?? '',
    phone: raw.phonenumber ?? raw.phone ?? '',
    avatar: raw.avatar ?? '',
    sex: raw.sex ?? '',
    deptId: raw.deptId ?? null,
    status: raw.status ?? '',
    roles,
    permissions,
  }
}

const parseStoredUserInfo = (value: string | null): UserProfile | null => {
  if (!value) return null
  try {
    const parsed = JSON.parse(value) as UserProfile
    return {
      ...emptyUserProfile(),
      ...parsed,
      roles: Array.isArray(parsed.roles) ? parsed.roles : [],
      permissions: Array.isArray(parsed.permissions) ? parsed.permissions : [],
    }
  } catch {
    localStorage.removeItem('userInfo')
    return null
  }
}

const getLoginPayload = (response: { data: LoginPayload }): LoginPayload => {
  return response.data
}

const getUserInfoPayload = (response: { data: UserInfoPayload }): UserInfoPayload => {
  return response.data
}

export const useAuthStore = defineStore('auth', () => {
  const token = ref<string | null>(localStorage.getItem('token'))
  const userInfo = ref<UserProfile | null>(parseStoredUserInfo(localStorage.getItem('userInfo')))
  const isAuthReady = ref(!token.value)

  const isAuthenticated = () => !!token.value

  const login = async (params: LoginParams) => {
    const res = await loginApi(params)
    const payload = getLoginPayload(res)
    const nestedPayload = payload.data && typeof payload.data === 'object' ? payload.data : null
    const code = payload.code ?? nestedPayload?.code
    const nextToken = payload.token ?? nestedPayload?.token

    if (isSuccessCode(code)) {
      if (!nextToken) return false
      token.value = nextToken
      localStorage.setItem('token', nextToken)

      const rawUser = payload.userInfo ?? nestedPayload?.userInfo
      if (rawUser) {
        userInfo.value = normalizeUserProfile(rawUser)
        localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      }

      await fetchUserInfo()
      return true
    }
    return false
  }

  const logout = () => {
    token.value = null
    userInfo.value = null
    localStorage.removeItem('token')
    localStorage.removeItem('userInfo')
  }

  const fetchUserInfo = async () => {
    if (!token.value) {
      isAuthReady.value = true
      return false
    }

    try {
      const res = await getInfoApi()
      const payload = getUserInfoPayload(res)
      if (isSuccessCode(payload.code)) {
        userInfo.value = normalizeUserProfile(
          payload.user ?? payload.data ?? null,
          payload.roles ?? [],
          payload.permissions ?? []
        )
        localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
        isAuthReady.value = true
        return true
      }
    } catch {
      logout()
    }
    isAuthReady.value = true
    return false
  }

  return { token, userInfo, isAuthReady, isAuthenticated, login, logout, fetchUserInfo }
})
