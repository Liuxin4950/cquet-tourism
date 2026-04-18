<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import ConfirmModal from '@/components/ui/ConfirmModal.vue'
import ProfileApplicationsPanel from '@/components/profile/ProfileApplicationsPanel.vue'
import ProfileCollectionsPanel from '@/components/profile/ProfileCollectionsPanel.vue'
import ProfileCommentsPanel from '@/components/profile/ProfileCommentsPanel.vue'
import ProfileInfoPanel from '@/components/profile/ProfileInfoPanel.vue'
import ProfileSkeleton from '@/components/profile/ProfileSkeleton.vue'
import ProfileTabs from '@/components/profile/ProfileTabs.vue'
import ProfileUserCard from '@/components/profile/ProfileUserCard.vue'
import { mockApplications, mockCollections, mockComments } from '@/components/profile/profileMock'
import { useToast } from '@/composables/useToast'
import { useAuthStore } from '@/stores/auth'
import type { ProfileTab, ProfileTabItem } from '@/types/profile'

const router = useRouter()
const route = useRoute()
const toast = useToast()
const authStore = useAuthStore()

const isLoading = ref(!authStore.userInfo)
const applicationsLoading = ref(false)
const applicationsError = ref(false)
const showLogoutModal = ref(false)

const tabItems: ProfileTabItem[] = [
  { key: 'info', label: '我的资料' },
  { key: 'applications', label: '我的报名' },
  { key: 'collections', label: '我的收藏' },
  { key: 'comments', label: '我的评论' },
]

const isProfileTab = (value: unknown): value is ProfileTab => {
  return typeof value === 'string' && tabItems.some(item => item.key === value)
}

const activeTab = computed<ProfileTab>(() => {
  return isProfileTab(route.query.tab) ? route.query.tab : 'info'
})

onMounted(async () => {
  if (!authStore.isAuthenticated()) {
    isLoading.value = false
    return
  }

  try {
    await authStore.fetchUserInfo()
  } finally {
    isLoading.value = false
  }
})

const handleTabChange = (tab: ProfileTab) => {
  router.replace({
    query: {
      ...route.query,
      tab,
    },
  })
}

const handleLogout = () => {
  authStore.logout()
  showLogoutModal.value = false
  toast.success('已退出登录')
  router.push('/')
}
</script>

<template>
  <NavBar />
  <main class="min-h-screen bg-light pt-[72px]">
    <div class="mx-auto max-w-[1280px] px-6 py-10 lg:px-10 lg:py-12">
      <header class="mb-6">
        <h1 class="font-heading text-[28px] font-bold text-brand">个人中心</h1>
        <p class="mt-3 font-body text-sm leading-6 text-muted md:text-base">
          管理你的个人资料、活动报名与互动记录
        </p>
      </header>

      <ProfileSkeleton v-if="isLoading" />

      <div v-else-if="authStore.isAuthenticated()" class="grid grid-cols-1 gap-6 lg:grid-cols-[320px_minmax(0,1fr)]">
        <ProfileUserCard :user="authStore.userInfo" @logout="showLogoutModal = true" />

        <section class="rounded-[24px] border border-border bg-white p-5 shadow-sm md:p-6">
          <ProfileTabs :items="tabItems" :active="activeTab" @change="handleTabChange" />

          <div class="mt-8">
            <ProfileInfoPanel v-if="activeTab === 'info'" :user="authStore.userInfo" />
            <ProfileApplicationsPanel
              v-else-if="activeTab === 'applications'"
              :applications="mockApplications"
              :loading="applicationsLoading"
              :error="applicationsError"
            />
            <ProfileCollectionsPanel
              v-else-if="activeTab === 'collections'"
              :collections="mockCollections"
            />
            <ProfileCommentsPanel
              v-else-if="activeTab === 'comments'"
              :comments="mockComments"
            />
          </div>
        </section>
      </div>

      <div v-else class="rounded-[24px] border border-border bg-white p-10 text-center">
        <p class="font-body text-sm text-muted">请先登录后查看个人中心。</p>
        <router-link to="/login" class="btn-pill dark mt-6">
          去登录
        </router-link>
      </div>
    </div>
  </main>

  <ConfirmModal
    :show="showLogoutModal"
    title="确认退出登录？"
    message="退出后你仍可浏览公开内容，但无法继续进行报名、收藏与评论操作。"
    confirm-text="确认退出"
    @confirm="handleLogout"
    @cancel="showLogoutModal = false"
  />
</template>
