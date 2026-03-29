import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/HomeView.vue'),
  },
  {
    path: '/spots',
    name: 'SpotList',
    component: () => import('@/views/SpotListView.vue'),
  },
  {
    path: '/spots/:id',
    name: 'SpotDetail',
    component: () => import('@/views/SpotDetailView.vue'),
    props: true,
  },
  {
    path: '/venues',
    name: 'VenueList',
    component: () => import('@/views/VenueListView.vue'),
  },
  {
    path: '/venues/:id',
    name: 'VenueDetail',
    component: () => import('@/views/VenueDetailView.vue'),
    props: true,
  },
  {
    path: '/activities',
    name: 'ActivityList',
    component: () => import('@/views/ActivityListView.vue'),
  },
  {
    path: '/activities/:id',
    name: 'ActivityDetail',
    component: () => import('@/views/ActivityDetailView.vue'),
    props: true,
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/LoginView.vue'),
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/RegisterView.vue'),
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import('@/views/ProfileView.vue'),
    meta: { requiresAuth: true },
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior: () => ({ top: 0 }),
})

// 路由守卫
router.beforeEach((to, _from, next) => {
  const authStore = useAuthStore()

  if (to.meta.requiresAuth && !authStore.isAuthenticated()) {
    next(`/login?redirect=${to.fullPath}`)
  } else if (to.name === 'Login' && authStore.isAuthenticated()) {
    next('/')
  } else {
    next()
  }
})

export default router
