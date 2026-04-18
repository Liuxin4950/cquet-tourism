import { defineStore } from 'pinia'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login as loginApi, getInfo as getInfoApi } from '@/api/auth'
import type { LoginParams } from '@/api/auth'

export const useAuthStore = defineStore('auth', () => {
  const router = useRouter()
  const token = ref<string | null>(localStorage.getItem('token'))
  const userInfo = ref<any>(null)

  // 初始化时从 localStorage 恢复用户信息
  const storedUserInfo = localStorage.getItem('userInfo')
  if (storedUserInfo) {
    try {
      userInfo.value = JSON.parse(storedUserInfo)
    } catch {
      localStorage.removeItem('userInfo')
    }
  }

  const isAuthenticated = () => !!token.value

  const login = async (params: LoginParams) => {
    const res: any = await loginApi(params)
    const code = res?.data?.code
    if (code === 200 || code === 0) {
      token.value = res.data?.token
      userInfo.value = res.data?.userInfo
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
    router.push('/')
  }

  const fetchUserInfo = async () => {
    if (!token.value) return
    try {
      const res: any = await getInfoApi()
      const code = res?.data?.code
      if (code === 200 || code === 0) {
        userInfo.value = res.data?.user || res.data
        localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
      }
    } catch {
      // token invalid — logout and redirect to login
      token.value = null
      userInfo.value = null
      localStorage.removeItem('token')
      localStorage.removeItem('userInfo')
      router.push('/login')
    }
  }

  return { token, userInfo, isAuthenticated, login, logout, fetchUserInfo }
})
