<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import request from '@/api/request'

const router = useRouter()

const username = ref('')
const password = ref('')
const confirmPassword = ref('')
const nickName = ref('')
const phone = ref('')
const errorMsg = ref('')
const isLoading = ref(false)

const handleRegister = async () => {
  errorMsg.value = ''
  if (!username.value || !password.value || !nickName.value || !phone.value) {
    errorMsg.value = '请填写所有必填项'
    return
  }
  if (password.value !== confirmPassword.value) {
    errorMsg.value = '两次密码输入不一致'
    return
  }
  if (!/^1[3-9]\d{9}$/.test(phone.value)) {
    errorMsg.value = '手机号格式不正确'
    return
  }
  isLoading.value = true
  try {
    // 注意：后端可能没有注册接口，这里做兜底处理
    const res: any = await request.post('/register', {
      username: username.value,
      password: password.value,
      nickName: nickName.value,
      phone: phone.value,
    })
    if (res.code === 200 || res.code === 0) {
      router.push('/login')
    } else {
      errorMsg.value = res.msg || '注册失败'
    }
  } catch (e: any) {
    errorMsg.value = '注册接口暂不可用，请联系管理员创建账号'
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
        <p class="text-text-secondary text-sm">加入我们，探索重庆</p>
      </div>
      <div class="bg-primary-dark border border-border-color rounded-lg p-8">
        <h2 class="font-montserrat font-bold text-xl text-text-primary mb-6">注册</h2>
        <div class="space-y-4">
          <input
            v-model="username"
            type="text"
            placeholder="用户名"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
          />
          <input
            v-model="nickName"
            type="text"
            placeholder="昵称"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
          />
          <input
            v-model="phone"
            type="tel"
            placeholder="手机号"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
          />
          <input
            v-model="password"
            type="password"
            placeholder="密码"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
          />
          <input
            v-model="confirmPassword"
            type="password"
            placeholder="确认密码"
            @keyup.enter="handleRegister"
            class="w-full bg-primary-dark border border-border-color text-text-primary px-4 py-3 rounded text-sm focus:border-primary outline-none"
          />
          <p v-if="errorMsg" class="text-red-400 text-xs">{{ errorMsg }}</p>
          <button
            @click="handleRegister"
            :disabled="isLoading"
            class="w-full bg-primary text-text-primary py-3 text-xs font-montserrat tracking-wider rounded hover:bg-primary-light transition-colors disabled:opacity-50"
          >
            {{ isLoading ? '注册中...' : '注册' }}
          </button>
        </div>
        <div class="mt-6 text-center text-sm text-text-secondary">
          已有账号？
          <router-link to="/login" class="text-accent hover:text-text-primary transition-colors">立即登录</router-link>
        </div>
      </div>
    </div>
  </div>
</template>
