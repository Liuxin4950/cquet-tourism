<script setup lang="ts">
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useToast } from '@/composables/useToast'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()
const toast = useToast()

const username = ref('')
const password = ref('')
const showPassword = ref(false)
const isLoading = ref(false)
const isProcessing = ref(false)

const togglePassword = () => {
  showPassword.value = !showPassword.value
}

const handleLogin = async () => {
  if (isProcessing.value) return
  if (!username.value || !password.value) {
    toast.error('请填写用户名和密码')
    return
  }
  isProcessing.value = true
  setTimeout(() => {
    isProcessing.value = false
  }, 2000)
  isLoading.value = true
  try {
    const ok = await authStore.login({ username: username.value, password: password.value })
    if (ok) {
      await authStore.fetchUserInfo()
      toast.success('登录成功')
      const redirect = (route.query.redirect as string) || '/'
      router.push(redirect)
    } else {
      toast.error('用户名或密码错误')
    }
  } catch {
    toast.error('登录失败，请检查网络')
  } finally {
    isLoading.value = false
  }
}
</script>

<template>
  <div class="min-h-screen bg-white flex items-center justify-center px-6">
    <div class="w-full max-w-[420px]">
      <!-- Logo -->
      <div class="text-center mb-12">
        <h1 class="font-heading font-bold text-[28px] text-brand mb-2">山城文旅</h1>
        <p class="font-body text-[13px] text-muted tracking-wide">登录探索更多重庆之美</p>
      </div>

      <!-- 表单卡片 -->
      <div class="bg-white border border-[#dfdfdf] rounded-[4px] p-10">
        <h2 class="font-heading font-light text-[24px] text-brand mb-8 text-center">登录</h2>

        <div class="space-y-5">
          <div>
            <label for="login-username" class="sr-only">用户名</label>
            <input
              id="login-username"
              v-model="username"
              type="text"
              placeholder="用户名"
              autocomplete="username"
              class="w-full border border-[#dfdfdf] text-brand px-5 py-3.5 rounded-[100vw] text-[13px] font-body bg-white focus:outline-none focus:border-[#105670] focus:ring-2 focus:ring-[#105670]/20 transition-colors placeholder:text-[#aaa]"
            />
          </div>
          <div class="relative">
            <label for="login-password" class="sr-only">密码</label>
            <input
              id="login-password"
              v-model="password"
              :type="showPassword ? 'text' : 'password'"
              placeholder="密码"
              autocomplete="current-password"
              @keyup.enter="handleLogin"
              class="w-full border border-[#dfdfdf] text-brand px-5 py-3.5 rounded-[100vw] text-[13px] font-body bg-white focus:outline-none focus:border-[#105670] focus:ring-2 focus:ring-[#105670]/20 transition-colors placeholder:text-[#aaa]"
            />
            <button
              type="button"
              @click="togglePassword"
              aria-label="切换密码可见性"
              class="absolute right-4 top-1/2 -translate-y-1/2 text-[#aaa] hover:text-[#648992] transition-colors"
            >
              <!-- 睁眼 -->
              <svg v-if="!showPassword" xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
              </svg>
              <!-- 闭眼 -->
              <svg v-else xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
              </svg>
            </button>
          </div>

          <button
            @click="handleLogin"
            :disabled="isLoading || isProcessing"
            class="w-full bg-[#222a2c] text-white py-3.5 text-[12px] font-body tracking-[0.15em] uppercase rounded-[100vw] hover:bg-[#092c38] transition-colors disabled:opacity-50 mt-2"
          >
            {{ isLoading ? '登录中...' : '登录' }}
          </button>

          <!-- 返回首页 -->
          <div class="mt-6 text-center">
            <router-link to="/" class="text-[13px] text-[#105670] hover:text-[#648992] transition-colors">
              返回首页
            </router-link>
          </div>
        </div>
      </div>

      <!-- 注册链接 -->
      <div class="mt-8 text-center font-body text-[13px] text-muted">
        还没有账号？
        <router-link to="/register" class="text-[#105670] hover:text-[#648992] transition-colors ml-1">立即注册</router-link>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* 隐藏浏览器原生的密码显示按钮 */
input::-webkit-credentials-auto-fill-button {
  display: none !important;
  width: 0 !important;
}
input::-webkit-caps-lock-indicator {
  display: none !important;
}
input::-ms-reveal {
  display: none !important;
}
</style>
