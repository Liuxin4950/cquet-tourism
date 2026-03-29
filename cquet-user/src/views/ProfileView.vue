<script setup lang="ts">
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

onMounted(() => {
  if (authStore.isAuthenticated()) {
    authStore.fetchUserInfo()
  }
})

const handleLogout = () => {
  authStore.logout()
  router.push('/')
}
</script>

<template>
  <div class="min-h-screen bg-primary-dark pt-[72px]">
    <div class="px-[5vw] py-8 max-w-2xl mx-auto">
      <h1 class="font-montserrat font-bold text-3xl text-text-primary mb-8">用户中心</h1>

      <div v-if="authStore.isAuthenticated()" class="space-y-6">
        <!-- 用户信息卡片 -->
        <div class="bg-primary-dark border border-border-color rounded-lg p-6">
          <div class="flex items-center gap-4 mb-6">
            <div class="w-16 h-16 rounded-full bg-primary flex items-center justify-center text-2xl font-montserrat font-bold text-text-primary">
              {{ (authStore.userInfo?.nickName || authStore.userInfo?.username || 'U').charAt(0).toUpperCase() }}
            </div>
            <div>
              <h2 class="font-montserrat font-bold text-xl text-text-primary">{{ authStore.userInfo?.nickName || authStore.userInfo?.username }}</h2>
              <p class="text-text-secondary text-sm">{{ authStore.userInfo?.phone || '' }}</p>
            </div>
          </div>
          <button
            @click="handleLogout"
            class="w-full border border-border-color text-text-secondary py-2 text-sm font-montserrat tracking-wider rounded hover:border-red-500 hover:text-red-400 transition-colors"
          >
            退出登录
          </button>
        </div>

        <!-- 暂无数据提示（后续对接真实 API） -->
        <div class="bg-primary-dark border border-border-color rounded-lg p-8 text-center">
          <p class="text-text-secondary text-sm mb-2">我的收藏</p>
          <p class="text-text-secondary/50 text-xs">（UserCollection 后端接口待确认）</p>
        </div>
        <div class="bg-primary-dark border border-border-color rounded-lg p-8 text-center">
          <p class="text-text-secondary text-sm mb-2">我的报名</p>
          <p class="text-text-secondary/50 text-xs">（ActivityApplication 后端接口已实现，可对接）</p>
        </div>
        <div class="bg-primary-dark border border-border-color rounded-lg p-8 text-center">
          <p class="text-text-secondary text-sm mb-2">我的留言</p>
          <p class="text-text-secondary/50 text-xs">（ActivityComment 后端接口待确认）</p>
        </div>
      </div>

      <div v-else class="text-center py-20">
        <p class="text-text-secondary mb-6">请先登录</p>
        <router-link to="/login" class="bg-primary text-text-primary px-8 py-3 text-xs font-montserrat tracking-wider rounded hover:bg-primary-light transition-colors">
          登录
        </router-link>
      </div>
    </div>
  </div>
</template>
