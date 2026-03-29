<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { gsap } from 'gsap'
import SpotCard from '@/components/cards/SpotCard.vue'
import VenueCard from '@/components/cards/VenueCard.vue'
import ActivityCard from '@/components/cards/ActivityCard.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'
import { useVenueStore } from '@/stores/venue'
import { useActivityStore } from '@/stores/activity'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const scenicSpotStore = useScenicSpotStore()
const venueStore = useVenueStore()
const activityStore = useActivityStore()
const authStore = useAuthStore()

const activeTab = ref<'spots' | 'venues' | 'activities'>('spots')

const tabs = [
  { key: 'spots', label: '景区' },
  { key: 'venues', label: '场馆' },
  { key: 'activities', label: '活动' },
] as const

onMounted(async () => {
  await Promise.all([
    scenicSpotStore.fetchSpots({ pageNum: 1, pageSize: 4 }),
    venueStore.fetchVenues({ pageNum: 1, pageSize: 4 }),
    activityStore.fetchActivities({ pageNum: 1, pageSize: 4 }),
  ])

  // GSAP 动画
  gsap.fromTo('.hero-eyebrow', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.3 })
  gsap.fromTo('.hero-title', { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 1, ease: 'power3.out', delay: 0.5 })
  gsap.fromTo('.hero-subtitle', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.7 })
  gsap.fromTo('.hero-actions', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.9 })
  gsap.fromTo('.section-title', { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.6, delay: 0.2 })
})

const goToList = (tab: typeof activeTab.value) => {
  const routeMap = {
    spots: '/spots',
    venues: '/venues',
    activities: '/activities',
  }
  router.push(routeMap[tab])
}
</script>

<template>
  <div class="min-h-screen bg-white">

    <!-- 导航栏：白底 + 深色文字，glassmorphism -->
    <nav class="fixed top-0 left-0 right-0 z-50 h-[4.5vw] bg-white/80 backdrop-blur-md border-b border-[#dfdfdf] flex items-center justify-between px-[5vw]">
      <span class="font-heading text-[1.1vw] font-semibold tracking-[0.15em] text-brand uppercase">山城文旅</span>
      <div class="hidden md:flex items-center gap-[2.5vw]">
        <router-link to="/" class="font-body text-[0.75vw] text-brand border-b border-transparent hover:border-brand transition-all pb-0.5">首页</router-link>
        <router-link to="/spots" class="font-body text-[0.75vw] text-muted border-b border-transparent hover:border-brand hover:text-brand transition-all pb-0.5">景区</router-link>
        <router-link to="/venues" class="font-body text-[0.75vw] text-muted border-b border-transparent hover:border-brand hover:text-brand transition-all pb-0.5">场馆</router-link>
        <router-link to="/activities" class="font-body text-[0.75vw] text-muted border-b border-transparent hover:border-brand hover:text-brand transition-all pb-0.5">活动</router-link>
      </div>
      <div>
        <router-link v-if="!authStore.isAuthenticated()" to="/login" class="btn-pill text-[0.7vw]">
          登录 / 注册
        </router-link>
        <router-link v-else to="/profile" class="font-body text-[0.75vw] text-brand hover:text-muted transition-colors">
          {{ authStore.userInfo?.nickName || authStore.userInfo?.username || '用户中心' }}
        </router-link>
      </div>
    </nav>

    <!-- Hero：全屏背景图 + 深色渐变遮罩 -->
    <section class="relative h-screen max-h-[100svh] overflow-hidden">
      <!-- 全屏背景图 -->
      <img
        src="https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=1920&q=80"
        alt="重庆夜景"
        class="absolute inset-0 w-full h-full object-cover"
      />
      <!-- 渐变遮罩：右侧深色 + 底部渐隐 -->
      <div class="absolute inset-0 bg-gradient-to-br from-white/5 via-white/20 to-[#092c38]/90"></div>
      <div class="absolute bottom-0 left-0 right-0 h-[40vh] bg-gradient-to-t from-white/60 to-transparent"></div>

      <!-- Hero 内容 -->
      <div class="hero-content relative z-10 h-full flex flex-col justify-end pb-[8vw] px-[5vw] max-w-[65%]">
        <p class="hero-eyebrow font-body text-[0.7vw] tracking-[0.25em] text-muted uppercase mb-[1.5vw] opacity-0">
          Chongqing Cultural Tourism
        </p>
        <h1 class="hero-title font-heading font-light text-[6vw] text-brand leading-[1.1] mb-[2vw] opacity-0">
          山城重庆<br>不止火锅
        </h1>
        <p class="hero-subtitle font-body text-[1vw] text-muted leading-[1.8] mb-[3vw] max-w-[38vw] opacity-0">
          探索巴渝文化、立体山水与都市夜景。从洪崖洞到长江三峡，从大足石刻到解放碑，发现不一样的重庆。
        </p>
        <div class="hero-actions flex gap-[1vw] opacity-0">
          <button @click="goToList('spots')" class="btn-pill dark text-[0.75vw]">
            探索景区
          </button>
          <button class="btn-pill text-[0.75vw]">
            了解更多
          </button>
        </div>
      </div>

      <!-- CTA 按钮位置（右下） -->
      <div class="absolute bottom-[8vw] right-[5.5vw] z-10">
        <button @click="goToList('spots')" class="btn-pill white text-[0.75vw]">
          探索景区
        </button>
      </div>
    </section>

    <!-- 精选推荐 -->
    <section class="py-[8vw] px-[5vw]">
      <div class="flex justify-between items-end mb-[4vw]">
        <div>
          <p class="font-body text-[0.7vw] tracking-[0.25em] text-muted uppercase mb-[1vw]">精选推荐</p>
          <h2 class="section-title font-heading font-light text-[3.5vw] text-brand">发现重庆之美</h2>
        </div>
        <div class="flex gap-[0.5vw]">
          <button
            v-for="tab in tabs"
            :key="tab.key"
            @click="activeTab = tab.key"
            class="px-[1.5vw] py-[0.6vw] text-[0.7vw] font-body rounded-pill transition-all"
            :class="activeTab === tab.key
              ? 'bg-brand text-white'
              : 'border border-[#dfdfdf] text-muted hover:border-brand hover:text-brand'"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>

      <!-- 景区卡片 -->
      <LoadingState v-if="scenicSpotStore.isLoading && activeTab === 'spots'" />
      <EmptyState v-else-if="activeTab === 'spots' && scenicSpotStore.spots.length === 0" message="暂无景区数据" />
      <div v-else-if="activeTab === 'spots'" class="grid grid-cols-2 md:grid-cols-4 gap-[1.5vw]">
        <SpotCard v-for="spot in scenicSpotStore.spots" :key="spot.id" :spot="spot" />
      </div>

      <!-- 场馆卡片 -->
      <LoadingState v-else-if="venueStore.isLoading && activeTab === 'venues'" />
      <EmptyState v-else-if="activeTab === 'venues' && venueStore.venues.length === 0" message="暂无场馆数据" />
      <div v-else-if="activeTab === 'venues'" class="grid grid-cols-2 md:grid-cols-4 gap-[1.5vw]">
        <VenueCard v-for="venue in venueStore.venues" :key="venue.id" :venue="venue" />
      </div>

      <!-- 活动卡片 -->
      <LoadingState v-else-if="activityStore.isLoading && activeTab === 'activities'" />
      <EmptyState v-else-if="activeTab === 'activities' && activityStore.activities.length === 0" message="暂无活动数据" />
      <div v-else-if="activeTab === 'activities'" class="grid grid-cols-2 md:grid-cols-4 gap-[1.5vw]">
        <ActivityCard v-for="activity in activityStore.activities" :key="activity.id" :activity="activity" />
      </div>

      <div class="text-center mt-[3vw]">
        <button @click="goToList(activeTab)" class="font-body text-[0.7vw] text-muted underline hover:text-brand transition-colors tracking-wider">
          查看全部 →
        </button>
      </div>
    </section>

    <!-- 关于重庆 -->
    <section class="py-[8vw] px-[5vw] bg-[#f5f4f2]">
      <div class="grid md:grid-cols-2 gap-[6vw] items-center">
        <div>
          <p class="font-body text-[0.7vw] tracking-[0.25em] text-muted uppercase mb-[1.5vw]">关于重庆</p>
          <h2 class="font-heading font-light text-[3vw] text-brand leading-[1.2] mb-[2vw]">
            山水之城<br>美丽之地
          </h2>
          <p class="font-body text-[0.95vw] text-muted leading-[1.9] mb-[3vw]">
            重庆，简称"渝"，中国四大直辖市之一。这里有世界最大城市峡谷——武隆天生三硚，有长江三峡最壮丽的西段，有大足石刻世界文化遗产，也有令无数食客神往的火锅文化。山即是城，城即是山，这座8D魔幻都市每一天都在刷新人们对城市的想象。
          </p>
          <div class="flex gap-[3vw]">
            <div class="border-l-2 border-brand pl-[1.5vw]">
              <div class="font-heading font-light text-[2.5vw] text-brand">294</div>
              <div class="font-body text-[0.75vw] text-muted mt-[0.3vw]">A级景区</div>
            </div>
            <div class="border-l-2 border-brand pl-[1.5vw]">
              <div class="font-heading font-light text-[2.5vw] text-brand">38</div>
              <div class="font-body text-[0.75vw] text-muted mt-[0.3vw]">文化场馆</div>
            </div>
            <div class="border-l-2 border-brand pl-[1.5vw]">
              <div class="font-heading font-light text-[2.5vw] text-brand">126</div>
              <div class="font-body text-[0.75vw] text-muted mt-[0.3vw]">特色活动</div>
            </div>
          </div>
        </div>
        <!-- 右侧图片 -->
        <div class="bg-[#dfdfdf] rounded-[2px] overflow-hidden aspect-[4/3]">
          <img
            src="https://images.unsplash.com/photo-1548013146-72479768bada?w=800&q=80"
            alt="重庆城市"
            class="w-full h-full object-cover"
          />
        </div>
      </div>
    </section>

    <!-- 三栏入口 -->
    <section class="py-[8vw] px-[5vw]">
      <div class="text-center mb-[4vw]">
        <p class="font-body text-[0.7vw] tracking-[0.25em] text-muted uppercase mb-[1vw]">探索资源</p>
        <h2 class="font-heading font-light text-[3vw] text-brand">景区 · 场馆 · 活动</h2>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-[2vw]">
        <!-- A级景区 -->
        <div class="group cursor-pointer" @click="goToList('spots')">
          <div class="aspect-[16/10] bg-[#dfdfdf] rounded-[2px] overflow-hidden mb-[1.5vw]">
            <img
              src="https://images.unsplash.com/photo-1545584429-6642a302c35c?w=600&q=80"
              alt="A级景区"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-[1.3vw] font-light text-brand mb-[0.8vw]">A级景区</h3>
          <p class="font-body text-[0.85vw] text-muted leading-[1.6]">从5A到1A，重庆294个A级景区覆盖自然景观、历史遗迹、主题乐园等多种类型。</p>
          <span class="inline-block mt-[1vw] font-body text-[0.7vw] text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览景区 →</span>
        </div>
        <!-- 文化场馆 -->
        <div class="group cursor-pointer" @click="goToList('venues')">
          <div class="aspect-[16/10] bg-[#dfdfdf] rounded-[2px] overflow-hidden mb-[1.5vw]">
            <img
              src="https://images.unsplash.com/photo-1565803974275-dccd2f933cbb?w=600&q=80"
              alt="文化场馆"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-[1.3vw] font-light text-brand mb-[0.8vw]">文化场馆</h3>
          <p class="font-body text-[0.85vw] text-muted leading-[1.6]">博物馆、图书馆、体育馆、剧院——38个文化体育设施，满足你的不同需求。</p>
          <span class="inline-block mt-[1vw] font-body text-[0.7vw] text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览场馆 →</span>
        </div>
        <!-- 特色活动 -->
        <div class="group cursor-pointer" @click="goToList('activities')">
          <div class="aspect-[16/10] bg-[#dfdfdf] rounded-[2px] overflow-hidden mb-[1.5vw]">
            <img
              src="https://images.unsplash.com/photo-1533174072545-7a4b6ad?w=600&q=80"
              alt="特色活动"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-[1.3vw] font-light text-brand mb-[0.8vw]">特色活动</h3>
          <p class="font-body text-[0.85vw] text-muted leading-[1.6]">川剧变脸、书法课堂、马拉松、文化节——126个特色活动等你参与。</p>
          <span class="inline-block mt-[1vw] font-body text-[0.7vw] text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览活动 →</span>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-[#092c38] py-[6vw] px-[5vw]">
      <div class="grid grid-cols-2 md:grid-cols-4 gap-[5vw] mb-[5vw]">
        <div>
          <div class="font-heading text-[1.1vw] font-semibold text-white tracking-[0.1em] uppercase mb-[1.5vw]">山城文旅</div>
          <p class="font-body text-[0.8vw] text-white/50 leading-[1.7]">探索重庆山水、人文与美食的权威平台。</p>
        </div>
        <div>
          <div class="font-body text-[0.65vw] tracking-[0.2em] text-white/40 uppercase mb-[1.5vw]">快速导航</div>
          <router-link to="/spots" class="block font-body text-[0.8vw] text-white/60 mb-[0.8vw] hover:text-white transition-colors">A级景区</router-link>
          <router-link to="/venues" class="block font-body text-[0.8vw] text-white/60 mb-[0.8vw] hover:text-white transition-colors">文化场馆</router-link>
          <router-link to="/activities" class="block font-body text-[0.8vw] text-white/60 hover:text-white transition-colors">特色活动</router-link>
        </div>
        <div>
          <div class="font-body text-[0.65vw] tracking-[0.2em] text-white/40 uppercase mb-[1.5vw]">关于</div>
          <span class="block font-body text-[0.8vw] text-white/60 mb-[0.8vw]">重庆文旅</span>
          <span class="block font-body text-[0.8vw] text-white/60 mb-[0.8vw]">新闻资讯</span>
          <span class="block font-body text-[0.8vw] text-white/60">联系我们</span>
        </div>
        <div>
          <div class="font-body text-[0.65vw] tracking-[0.2em] text-white/40 uppercase mb-[1.5vw]">登录</div>
          <router-link to="/login" class="block font-body text-[0.8vw] text-white/60 mb-[0.8vw] hover:text-white transition-colors">登录</router-link>
          <router-link to="/register" class="block font-body text-[0.8vw] text-white/60 hover:text-white transition-colors">注册</router-link>
        </div>
      </div>
      <div class="border-t border-white/10 pt-[3vw] flex justify-between font-body text-[0.7vw] text-white/30">
        <span>© 2026 重庆文旅网站管理系统</span>
        <span>渝ICP备XXXXXXXX号</span>
      </div>
    </footer>
  </div>
</template>
