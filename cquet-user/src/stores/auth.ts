import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login as loginApi, getInfo as getInfoApi } from '@/api/auth'
import type { LoginParams } from '@/api/auth'

export const useAuthStore = defineStore('auth', () => {
  const token = ref<string | null>(localStorage.getItem('token'))
  const userInfo = ref<any>(null)

  const isAuthenticated = () => !!token.value

  const login = async (params: LoginParams) => {
    const res: any = await loginApi(params)
    if (res.code === 200 || res.code === 0) {
      token.value = res.token || res.data?.token
      userInfo.value = res.userInfo || res.data?.userInfo
      localStorage.setItem('token', token.value!)
      localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
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
    if (!token.value) return
    try {
      const res: any = await getInfoApi()
      if (res.code === 200 || res.code === 0) {
        userInfo.value = res.user || res.data?.user || res
        localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      }
    } catch {
      // token invalid
    }
  }

  return { token, userInfo, isAuthenticated, login, logout, fetchUserInfo }
})
