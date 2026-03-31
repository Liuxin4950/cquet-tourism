<script setup lang="ts">
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
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
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <div class="px-6 lg:px-8 py-8 max-w-2xl mx-auto">
      <h1 class="font-montserrat font-bold text-3xl text-brand mb-8">用户中心</h1>

      <div v-if="authStore.isAuthenticated()" class="space-y-6">
        <!-- 用户信息卡片 -->
        <div class="bg-dark border border-border rounded-lg p-6">
          <div class="flex items-center gap-4 mb-6">
            <div class="w-16 h-16 rounded-full bg-brand flex items-center justify-center text-2xl font-montserrat font-bold text-brand">
              {{ (authStore.userInfo?.nickName || authStore.userInfo?.username || 'U').charAt(0).toUpperCase() }}
            </div>
            <div>
              <h2 class="font-montserrat font-bold text-xl text-brand">{{ authStore.userInfo?.nickName || authStore.userInfo?.username }}</h2>
              <p class="text-muted text-sm">{{ authStore.userInfo?.phone || '' }}</p>
            </div>
          </div>
          <button
            @click="handleLogout"
            class="w-full border border-border text-muted py-2 text-sm font-montserrat tracking-wider rounded hover:border-red-500 hover:text-red-400 transition-colors"
          >
            退出登录
          </button>
        </div>

        <!-- 暂无数据提示（后续对接真实 API） -->
        <div class="bg-dark border border-border rounded-lg p-8 text-center">
          <p class="text-muted text-sm mb-2">我的收藏</p>
          <EmptyState message="暂无收藏内容，浏览景区后发现感兴趣的内容吧" />
        </div>
        <div class="bg-dark border border-border rounded-lg p-8 text-center">
          <p class="text-muted text-sm mb-2">我的报名</p>
          <EmptyState message="暂未报名任何活动，快去探索精彩活动吧" />
        </div>
        <div class="bg-dark border border-border rounded-lg p-8 text-center">
          <p class="text-muted text-sm mb-2">我的留言</p>
          <EmptyState message="暂无留言记录，参与活动后可发表感想" />
        </div>
      </div>

      <div v-else class="text-center py-20">
        <p class="text-muted mb-6">请先登录</p>
        <router-link to="/login" class="bg-brand text-brand px-8 py-3 text-xs font-montserrat tracking-wider rounded hover:bg-brand-light transition-colors">
          登录
        </router-link>
      </div>
    </div>
  </div>
</template>
