<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useToast } from '@/composables/useToast'
import AnimatedCharacters from '@/components/ui/AnimatedCharacters.vue'
import InteractiveHoverButton from '@/components/ui/InteractiveHoverButton.vue'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()
const toast = useToast()

const username = ref('')
const password = ref('')
const showPassword = ref(false)
const isLoading = ref(false)
const isProcessing = ref(false)

// 动画角色状态
const isTyping = computed(() => username.value.length > 0 || password.value.length > 0)

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
  <div class="min-h-screen max-h-screen overflow-hidden grid lg:grid-cols-2">
    <!-- 左侧：动画角色区域 (桌面端) -->
    <div
      class="relative hidden lg:flex flex-col justify-between bg-gradient-to-br from-[#9ca3af] via-[#6b7280] to-[#4b5563] p-12 text-white"
    >
      <!-- 顶部 Logo -->
      <div class="relative z-20">
        <router-link to="/" class="flex items-center gap-2 text-lg font-semibold">
          <div class="w-8 h-8 bg-white/10 backdrop-blur-sm p-1 rounded-lg flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
          </div>
          <span>山城文旅</span>
        </router-link>
      </div>

      <!-- 中间：动画角色 -->
      <div class="relative z-20 flex items-end justify-center h-[500px]">
        <AnimatedCharacters
          :is-typing="isTyping"
          :show-password="showPassword"
          :password-length="password.length"
        />
      </div>

      <!-- 底部链接 -->
      <div class="relative z-20 flex items-center gap-8 text-sm text-white/60">
        <router-link to="/privacy-policy" class="hover:text-white transition-colors">
          隐私政策
        </router-link>
        <router-link to="/terms" class="hover:text-white transition-colors">
          服务条款
        </router-link>
      </div>

      <!-- 装饰元素 -->
      <div class="absolute inset-0 bg-grid-white/[0.05] bg-[size:20px_20px]" />
      <div class="absolute top-1/4 right-1/4 size-64 bg-gray-400/20 rounded-full blur-3xl" />
      <div class="absolute bottom-1/4 left-1/4 size-96 bg-gray-300/20 rounded-full blur-3xl" />
    </div>

    <!-- 右侧：登录表单 -->
    <div class="flex items-center justify-center p-8 bg-white">
      <div class="w-full max-w-[420px]">
        <!-- 移动端 Logo -->
        <div class="lg:hidden flex items-center justify-center gap-2 text-lg font-semibold mb-12">
          <div class="w-8 h-8 bg-[#105670]/10 p-1 rounded-lg flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-[#105670]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
          </div>
          <span class="text-[#105670]">山城文旅</span>
        </div>

        <!-- 标题 -->
        <div class="text-center mb-10">
          <h1 class="text-3xl font-heading font-bold tracking-tight mb-2 text-brand">
            Welcome back!
          </h1>
          <p class="text-muted-foreground text-sm font-body">
            请输入您的登录信息
          </p>
        </div>

        <!-- 登录表单 -->
        <form @submit.prevent="handleLogin" class="space-y-5">
          <div class="space-y-2">
            <label for="login-username" class="text-sm font-medium font-body text-[#333]">
              用户名
            </label>
            <input
              id="login-username"
              v-model="username"
              type="text"
              placeholder="请输入用户名"
              autocomplete="username"
              class="w-full border border-[#dfdfdf] text-brand px-5 py-3.5 rounded-[100vw] text-[13px] font-body bg-white focus:outline-none focus:border-[#105670] focus:ring-2 focus:ring-[#105670]/20 transition-colors placeholder:text-[#aaa]"
            />
          </div>

          <div class="space-y-2">
            <label for="login-password" class="text-sm font-medium font-body text-[#333]">
              密码
            </label>
            <div class="relative">
              <input
                id="login-password"
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                placeholder="请输入密码"
                autocomplete="current-password"
                class="w-full border border-[#dfdfdf] text-brand px-5 py-3.5 pr-10 rounded-[100vw] text-[13px] font-body bg-white focus:outline-none focus:border-[#105670] focus:ring-2 focus:ring-[#105670]/20 transition-colors placeholder:text-[#aaa]"
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
          </div>

          <!-- 记住我 & 忘记密码 -->
          <div class="flex items-center justify-between">
            <label class="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                class="w-4 h-4 rounded border-[#dfdfdf] text-[#105670] focus:ring-[#105670]/20"
              />
              <span class="text-sm font-normal text-[#666]">记住我</span>
            </label>
            <router-link
              to="/forgot-password"
              class="text-sm text-[#105670] hover:underline font-medium"
            >
              忘记密码？
            </router-link>
          </div>

          <!-- 登录按钮 -->
          <InteractiveHoverButton
            type="submit"
            :text="isLoading ? '登录中...' : '登录'"
            :disabled="isLoading || isProcessing"
            class="w-full bg-[#222a2c] text-white border-[#222a2c] hover:bg-[#092c38] hover:border-[#092c38] hover:text-white mt-2"
          />

          <!-- 返回首页 -->
          <div class="mt-6 text-center">
            <router-link to="/" class="text-[13px] text-[#105670] hover:text-[#648992] transition-colors">
              返回首页
            </router-link>
          </div>
        </form>

        <!-- 注册链接 -->
        <div class="mt-8 text-center font-body text-[13px] text-muted">
          还没有账号？
          <router-link to="/register" class="text-[#105670] hover:text-[#648992] transition-colors ml-1">
            立即注册
          </router-link>
        </div>
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
