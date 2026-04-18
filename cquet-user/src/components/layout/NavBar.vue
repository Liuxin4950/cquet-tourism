<script setup lang="ts">
import { ref, computed } from 'vue'
import { RouterLink, useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useToast } from '@/composables/useToast'
import ConfirmModal from '@/components/ui/ConfirmModal.vue'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()
const toast = useToast()

const isMobileMenuOpen = ref(false)
const showLogoutModal = ref(false)

const navLinks = [
  { name: '首页', path: '/' },
  { name: '景区', path: '/spots' },
  { name: '场馆', path: '/venues' },
  { name: '活动', path: '/activities' },
  { name: '资讯', path: '/news' },
  { name: '公告', path: '/notices' },
  { name: '关于', path: '/about' },
]

const isLoggedIn = computed(() => authStore.isAuthenticated())
const isAuthReady = computed(() => authStore.isAuthReady)
const userNickName = computed(() => authStore.userInfo?.nickName || authStore.userInfo?.username || '用户')

const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value
}

const closeMobileMenu = () => {
  isMobileMenuOpen.value = false
}

const confirmLogout = () => {
  showLogoutModal.value = true
}

const handleLogout = () => {
  isMobileMenuOpen.value = false
  authStore.logout()
  showLogoutModal.value = false
  toast.success('已退出登录')
  router.push('/')
}
</script>

<template>
  <header class="nav-header">
    <nav class="nav-container">
      <!-- Logo -->
      <RouterLink to="/" class="nav-logo">
        <img src="/LOGO.png" alt="山城文旅" class="logo-image" />
      </RouterLink>

      <!-- Desktop Navigation -->
      <div class="nav-links-desktop">
        <RouterLink
          v-for="link in navLinks"
          :key="link.path"
          :to="link.path"
          class="nav-link"
          :class="{ 'nav-link-active': route.path === link.path }"
        >
          {{ link.name }}
        </RouterLink>
      </div>

      <!-- CTA Button -->
      <div v-if="isAuthReady" class="nav-actions">
        <template v-if="isLoggedIn">
          <RouterLink
            to="/profile"
            class="nav-profile-link"
            :class="{ 'nav-profile-link-active': route.path === '/profile' }"
          >
            <span class="nav-profile-label">个人中心</span>
            <span class="nav-user-name">{{ userNickName }}</span>
          </RouterLink>
          <button @click="confirmLogout" class="nav-btn nav-btn-logout">
            退出登录
          </button>
        </template>
        <template v-else>
          <RouterLink to="/login" class="nav-btn">
            登录 / 注册
          </RouterLink>
        </template>
      </div>

      <!-- Mobile Menu Button -->
      <button
        class="nav-mobile-toggle"
        @click="toggleMobileMenu"
        :aria-expanded="isMobileMenuOpen"
        aria-label="切换菜单"
      >
        <span class="hamburger-line" :class="{ 'hamburger-open': isMobileMenuOpen }"></span>
        <span class="hamburger-line" :class="{ 'hamburger-open': isMobileMenuOpen }"></span>
        <span class="hamburger-line" :class="{ 'hamburger-open': isMobileMenuOpen }"></span>
      </button>
    </nav>

    <!-- Mobile Menu -->
    <Transition name="mobile-menu">
      <div v-if="isMobileMenuOpen" class="mobile-menu" @click="closeMobileMenu">
        <div class="mobile-menu-content" @click.stop>
          <RouterLink
            v-for="link in navLinks"
            :key="link.path"
            :to="link.path"
            class="mobile-nav-link"
            :class="{ 'mobile-nav-link-active': route.path === link.path }"
            @click="closeMobileMenu"
          >
            {{ link.name }}
          </RouterLink>
          <template v-if="isAuthReady && isLoggedIn">
            <span class="mobile-nav-user">{{ userNickName }}</span>
            <RouterLink
              to="/profile"
              class="mobile-nav-link"
              :class="{ 'mobile-nav-link-active': route.path === '/profile' }"
              @click="closeMobileMenu"
            >
              个人中心
            </RouterLink>
            <button @click="confirmLogout(); closeMobileMenu()" class="mobile-nav-btn">
              退出登录
            </button>
          </template>
          <template v-else-if="isAuthReady">
            <RouterLink to="/login" class="nav-btn mt-6" @click="closeMobileMenu">
              登录 / 注册
            </RouterLink>
          </template>
        </div>
      </div>
    </Transition>

    <!-- 退出登录确认弹窗 -->
    <ConfirmModal
      :show="showLogoutModal"
      title="确认退出登录？"
      message="退出后你仍可浏览公开内容，但无法继续进行报名、收藏与评论操作。"
      confirm-text="确认退出"
      @confirm="handleLogout"
      @cancel="showLogoutModal = false"
    />
  </header>
</template>

<style scoped>
.nav-header {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  z-index: 50;
  backdrop-filter: blur(10px);
  background-color: #0000004d;
  width: 100%;
  inset: 0% auto auto 0%;
}

.nav-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 72px;
  padding: 0 48px;
  max-width: 1440px;
  margin: 0 auto;
}

/* Logo */
.nav-logo {
  text-decoration: none;
  flex-shrink: 0;
}

.logo-image {
  height: 36px;
  width: auto;
  object-fit: contain;
  transition: opacity 0.3s ease;
}

.nav-logo:hover .logo-image {
  opacity: 0.8;
}

/* Desktop Navigation Links */
.nav-links-desktop {
  display: flex;
  align-items: center;
  gap: 40px;
}

.nav-link {
  font-family: 'Montserrat', sans-serif;
  font-size: 12px;
  font-weight: 400;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: #f5f4f2;
  text-decoration: none;
  position: relative;
  padding: 4px 0;
  transition: color 0.3s ease;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 1px;
  background-color: #ffffff;
  transition: width 0.3s ease;
}

.nav-link:hover {
  color: #ffffff;
}

.nav-link:hover::after {
  width: 100%;
}

.nav-link-active {
  color: #ffffff;
}

.nav-link-active::after {
  width: 100%;
}

/* CTA Actions */
.nav-actions {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 12px;
}

.nav-profile-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: 'Manrope', sans-serif;
  font-size: 13px;
  color: #f5f4f2;
  letter-spacing: 0.02em;
  text-decoration: none;
  border-bottom: 1px solid transparent;
  transition: border-color 0.3s ease, color 0.3s ease;
}

.nav-profile-link:hover,
.nav-profile-link-active {
  color: #ffffff;
  border-color: #ffffff;
}

.nav-profile-label {
  font-size: 12px;
  letter-spacing: 0.08em;
}

.nav-user-name {
  max-width: 96px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: inherit;
}

.nav-btn {
  font-family: 'Montserrat', sans-serif;
  font-size: 12px;
  font-weight: 400;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  padding: 10px 20px;
  border: 1px solid #f5f4f2;
  border-radius: 100vw;
  color: #f5f4f2;
  background: transparent;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
}

.nav-btn:hover {
  background-color: #f5f4f2;
  color: #222a2c;
}

.nav-btn-logout {
  border-color: rgba(245, 244, 242, 0.5);
  font-size: 11px;
  padding: 8px 16px;
}

.nav-btn-logout:hover {
  border-color: #f5f4f2;
  background-color: rgba(245, 244, 242, 0.1);
  color: #f5f4f2;
}

/* Mobile Toggle */
.nav-mobile-toggle {
  display: none;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 32px;
  height: 32px;
  gap: 5px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
}

.hamburger-line {
  width: 22px;
  height: 1.5px;
  background-color: #f5f4f2;
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.hamburger-open:nth-child(1) {
  transform: translateY(6.5px) rotate(45deg);
}

.hamburger-open:nth-child(2) {
  opacity: 0;
}

.hamburger-open:nth-child(3) {
  transform: translateY(-6.5px) rotate(-45deg);
}

/* Mobile Menu */
.mobile-menu {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
  z-index: 40;
}

.mobile-menu-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  gap: 24px;
  background-color: #fff;
}

.mobile-nav-link {
  font-family: 'Montserrat', sans-serif;
  font-size: 16px;
  font-weight: 400;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #222a2c;
  text-decoration: none;
  padding: 12px 24px;
  transition: color 0.3s ease;
}

.mobile-nav-link:hover,
.mobile-nav-link-active {
  color: #222a2c;
}

.mobile-nav-user {
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  color: #222a2c;
  padding: 12px 24px;
}

.mobile-nav-btn {
  font-family: 'Montserrat', sans-serif;
  font-size: 12px;
  font-weight: 400;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  padding: 12px 24px;
  border: 1px solid #222a2c;
  border-radius: 100vw;
  color: #222a2c;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
}

.mobile-nav-btn:hover {
  background-color: #222a2c;
  color: #fff;
}

/* Mobile Menu Transitions */
.mobile-menu-enter-active,
.mobile-menu-leave-active {
  transition: opacity 0.3s ease;
}

.mobile-menu-enter-from,
.mobile-menu-leave-to {
  opacity: 0;
}

/* Responsive */
@media (max-width: 1023px) {
  .nav-container {
    padding: 0 24px;
  }

  .nav-links-desktop {
    display: none;
  }

  .nav-actions {
    display: none;
  }

  .nav-mobile-toggle {
    display: flex;
  }
}
</style>
