<script setup lang="ts">
import { ref } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const username = ref('')
const password = ref('')
const errorMsg = ref('')
const isLoading = ref(false)

const handleLogin = async () => {
  if (!username.value || !password.value) {
    errorMsg.value = '请填写用户名和密码'
    return
  }
  isLoading.value = true
  errorMsg.value = ''
  try {
    const ok = await authStore.login({ username: username.value, password: password.value })
    if (ok) {
      const redirect = (route.query.redirect as string) || '/'
      router.push(redirect)
    } else {
      errorMsg.value = '用户名或密码错误'
    }
  } catch {
    errorMsg.value = '登录失败，请检查网络'
  } finally {
    isLoading.value = false
  }
}
</script>

<template>
  <div class="min-h-screen bg-primary-dark flex items-center justify-center px-[5vw]">
    <div class="w-full max-w-md">
      <div class="text-center mb-10">
        <h1 class="font-montserrat font-bold text-3xl text-text-primary mb-2">山城文旅</h1>
        <p class="text-text-secondary text-sm">登录探索更多重庆之美</p>
      </div>
      <div class="bg-primary-dark border border-border-color rounded-lg p-8">
        <h2 class="font-montserrat font-bold text-xl text-text-primary mb-6">登录</h2>
        <div class="space-y-4">
          <div>
            <input
              v-model="username"
              type="text"
              placeholder="用户名"
              class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
            />
          </div>
          <div>
            <input
              v-model="password"
              type="password"
              placeholder="密码"
              @keyup.enter="handleLogin"
              class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
            />
          </div>
          <p v-if="errorMsg" class="text-red-400 text-xs">{{ errorMsg }}</p>
          <button
            @click="handleLogin"
            :disabled="isLoading"
            class="w-full bg-primary text-text-primary py-3 text-xs font-montserrat tracking-wider rounded hover:bg-primary-light transition-colors disabled:opacity-50"
          >
            {{ isLoading ? '登录中...' : '登录' }}
          </button>
        </div>
        <div class="mt-6 text-center text-sm text-text-secondary">
          还没有账号？
          <router-link to="/register" class="text-accent hover:text-text-primary transition-colors">立即注册</router-link>
        </div>
      </div>
    </div>
  </div>
</template>
