<script setup lang="ts">
import { computed, onMounted, ref, watch, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { gsap } from 'gsap'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Navigation } from 'swiper/modules'
import 'swiper/css'
import 'swiper/css/navigation'
import NavBar from '@/components/layout/NavBar.vue'
import SpotCard from '@/components/cards/SpotCard.vue'
import VenueCard from '@/components/cards/VenueCard.vue'
import ActivityCard from '@/components/cards/ActivityCard.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'
import { useVenueStore } from '@/stores/venue'
import { useActivityStore } from '@/stores/activity'
import { useNewsStore } from '@/stores/news'
import { useNoticeStore } from '@/stores/notice'

type TabType = 'all' | 'spot' | 'venue' | 'activity'
const tabs: { key: TabType; label: string }[] = [
  { key: 'all', label: '全部' },
  { key: 'spot', label: '景区' },
  { key: 'venue', label: '场馆' },
  { key: 'activity', label: '活动' },
]
const activeTab = ref<TabType>('all')
const swiperRef = ref<any>(null)

const router = useRouter()
const scenicSpotStore = useScenicSpotStore()
const venueStore = useVenueStore()
const activityStore = useActivityStore()
const newsStore = useNewsStore()
const noticeStore = useNoticeStore()

const isLoading = computed(() =>
  scenicSpotStore.isLoading || venueStore.isLoading || activityStore.isLoading
)

// 任一 store 失败时显示 error state，而非误导性的"暂无内容"
const hasError = computed(() =>
  scenicSpotStore.error || venueStore.error || activityStore.error
)

const hasData = computed(() =>
  scenicSpotStore.spots.length > 0 || venueStore.venues.length > 0 || activityStore.activities.length > 0
)

interface FeaturedItem {
  type: 'spot' | 'venue' | 'activity'
  data: any
}

const featuredList = computed<FeaturedItem[]>(() => {
  const items: FeaturedItem[] = []
  scenicSpotStore.spots.forEach(s => items.push({ type: 'spot', data: s }))
  venueStore.venues.forEach(v => items.push({ type: 'venue', data: v }))
  activityStore.activities.forEach(a => items.push({ type: 'activity', data: a }))
  return items
})

const filteredFeaturedList = computed<FeaturedItem[]>(() => {
  if (activeTab.value === 'all') return featuredList.value
  return featuredList.value.filter(item => item.type === activeTab.value)
})

onMounted(async () => {
  await Promise.all([
    scenicSpotStore.fetchSpots({ pageNum: 1, pageSize: 6 }),
    venueStore.fetchVenues({ pageNum: 1, pageSize: 6 }),
    activityStore.fetchActivities({ pageNum: 1, pageSize: 6 }),
    newsStore.fetchNewsList({ pageNum: 1, pageSize: 3 }),
    noticeStore.fetchNoticeList({ pageNum: 1, pageSize: 3 }),
  ])

  gsap.fromTo('.hero-eyebrow', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.3 })
  gsap.fromTo('.hero-title', { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 1, ease: 'power3.out', delay: 0.5 })
  gsap.fromTo('.hero-subtitle', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.7 })
  gsap.fromTo('.hero-actions', { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.8, delay: 0.9 })
  gsap.fromTo('.section-title', { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.6, delay: 0.2 })
})

// Tab 切换后更新 Swiper
watch(activeTab, async () => {
  await nextTick()
  swiperRef.value?.swiper?.update()
})

// 重试失败的 store，而非全部重新加载
const handleRetry = () => {
  if (scenicSpotStore.error) {
    scenicSpotStore.fetchSpots({ pageNum: 1, pageSize: 6 })
  }
  if (venueStore.error) {
    venueStore.fetchVenues({ pageNum: 1, pageSize: 6 })
  }
  if (activityStore.error) {
    activityStore.fetchActivities({ pageNum: 1, pageSize: 6 })
  }
}

const goToList = (type: 'spots' | 'venues' | 'activities') => {
  router.push(`/${type}`)
}

const goToDetail = (item: FeaturedItem) => {
  const routeMap = {
    spot: `/spots/${item.data.id}`,
    venue: `/venues/${item.data.id}`,
    activity: `/activities/${item.data.id}`,
  }
  router.push(routeMap[item.type])
}

const scrollToAbout = () => {
  document.getElementById('about-section')?.scrollIntoView({ behavior: 'smooth' })
}

const countSpots = computed(() => scenicSpotStore.total)
const countVenues = computed(() => venueStore.total)
const countActivities = computed(() => activityStore.total)
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-white">

    <!-- Hero：全屏 -->
    <section class="relative h-screen overflow-hidden">
      <img
        src="https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?w=1920&q=80"
        alt="重庆夜景"
        class="absolute inset-0 w-full h-full object-cover"
      />
      <div class="absolute inset-0 bg-gradient-to-br from-white/5 via-white/20 to-[#092c38]/90"></div>
      <div class="absolute bottom-0 left-0 right-0 h-[40vh] bg-gradient-to-t from-white/60 to-transparent"></div>

      <!-- Hero 内容 -->
      <div class="hero-content relative z-10 h-full flex flex-col justify-end pb-24 px-20 max-w-[900px]">
        <p class="hero-eyebrow font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-6 opacity-0">Chongqing Cultural Tourism</p>
        <h1 class="hero-title font-heading font-light text-hero-title text-brand leading-[1.1] mb-8 opacity-0">山城重庆<br>不止火锅</h1>
        <p class="hero-subtitle font-body text-hero-sub text-muted leading-[1.8] mb-12 max-w-[520px] opacity-0">
          探索巴渝文化、立体山水与都市夜景。从洪崖洞到长江三峡，从大足石刻到解放碑，发现不一样的重庆。
        </p>
        <div class="hero-actions flex gap-4 opacity-0">
          <button @click="goToList('spots')" class="btn-pill dark text-btn px-8 py-3">探索景区</button>
          <button @click="scrollToAbout" class="btn-pill text-btn px-8 py-3">了解更多</button>
        </div>
      </div>
    </section>

    <!-- 精选推荐：Swiper 轮播 -->
    <section class="py-24 px-20">
      <div class="flex justify-between items-end mb-12">
        <div>
          <p class="font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-4">精选推荐</p>
          <h2 class="section-title font-heading font-light text-section-title text-brand">发现重庆之美</h2>
        </div>
        <!-- Tab 筛选 -->
        <div class="flex gap-1 bg-light rounded p-1">
          <button
            v-for="tab in tabs"
            :key="tab.key"
            @click="activeTab = tab.key"
            class="px-4 py-1.5 text-xs font-body rounded transition-all tracking-wide"
            :class="activeTab === tab.key
              ? 'bg-brand text-white shadow-sm'
              : 'text-muted hover:text-brand'"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>

      <!-- 加载状态 -->
      <LoadingState v-if="isLoading" />

      <!-- 错误状态 -->
      <ErrorState v-else-if="hasError" message="加载失败，请检查网络连接" @retry="handleRetry" />

      <!-- 空状态 -->
      <EmptyState v-else-if="!hasData" message="暂无推荐内容" />

      <!-- 轮播 -->
      <div v-else-if="filteredFeaturedList.length > 0">
        <Swiper
          ref="swiperRef"
          :modules="[Navigation]"
          :slides-per-view="4"
          :space-between="32"
          :navigation="{
            prevEl: '.featured-prev',
            nextEl: '.featured-next',
          }"
          :breakpoints="{
            320: { slidesPerView: 1 },
            640: { slidesPerView: 2 },
            1024: { slidesPerView: 3 },
            1280: { slidesPerView: 4 },
          }"
          class="!pb-12"
        >
          <SwiperSlide
            v-for="item in filteredFeaturedList"
            :key="`${item.type}-${item.data.id}`"
          >
            <div @click="goToDetail(item)" class="cursor-pointer">
              <SpotCard v-if="item.type === 'spot'" :spot="item.data" />
              <VenueCard v-else-if="item.type === 'venue'" :venue="item.data" />
              <ActivityCard v-else-if="item.type === 'activity'" :activity="item.data" />
            </div>
          </SwiperSlide>
        </Swiper>

        <!-- 导航按钮 -->
        <div class="flex justify-end gap-4 mt-4">
          <button class="featured-prev w-10 h-10 rounded-full border border-border flex items-center justify-center text-muted hover:border-brand hover:text-brand transition-colors disabled:opacity-30" :disabled="filteredFeaturedList.length <= 4">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15.75 19.5L8.25 12l7.5-7.5" />
            </svg>
          </button>
          <button class="featured-next w-10 h-10 rounded-full border border-border flex items-center justify-center text-muted hover:border-brand hover:text-brand transition-colors disabled:opacity-30" :disabled="filteredFeaturedList.length <= 4">
            <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Tab 空状态 -->
      <EmptyState v-else :message="`暂无${tabs.find(t => t.key === activeTab)?.label}推荐`" />

      <!-- 查看全部 -->
      <div class="text-center mt-12">
        <button @click="goToList('spots')" class="font-body text-nav text-muted underline hover:text-brand transition-colors tracking-wider">
          查看全部 →
        </button>
      </div>
    </section>

    <!-- 关于重庆 -->
    <section id="about-section" class="py-24 px-20 bg-light">
      <div class="grid lg:grid-cols-2 gap-24 items-center">
        <div>
          <p class="font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-6">关于重庆</p>
          <h2 class="font-heading font-light text-section-title text-brand leading-[1.2] mb-8">山水之城<br>美丽之地</h2>
          <p class="font-body text-hero-sub text-muted leading-[1.9] mb-12">
            重庆，简称"渝"，中国四大直辖市之一。这里有世界最大城市峡谷——武隆天生三硚，有长江三峡最壮丽的西段，有大足石刻世界文化遗产，也有令无数食客神往的火锅文化。山即是城，城即是山，这座8D魔幻都市每一天都在刷新人们对城市的想象。
          </p>
          <div class="flex gap-12">
            <div class="border-l-2 border-brand pl-6">
              <div class="font-heading font-light text-[40px] text-brand leading-none">{{ countSpots }}</div>
              <div class="font-body text-nav text-muted mt-1">A级景区</div>
            </div>
            <div class="border-l-2 border-brand pl-6">
              <div class="font-heading font-light text-[40px] text-brand leading-none">{{ countVenues }}</div>
              <div class="font-body text-nav text-muted mt-1">文化场馆</div>
            </div>
            <div class="border-l-2 border-brand pl-6">
              <div class="font-heading font-light text-[40px] text-brand leading-none">{{ countActivities }}</div>
              <div class="font-body text-nav text-muted mt-1">特色活动</div>
            </div>
          </div>
        </div>
        <div class="bg-border rounded overflow-hidden aspect-[4/3]">
          <img
            src="https://images.unsplash.com/photo-1548013146-72479768bada?w=800&q=80"
            alt="重庆城市"
            class="w-full h-full object-cover"
          />
        </div>
      </div>
    </section>

    <!-- 三栏入口 -->
    <section class="py-24 px-20">
      <div class="text-center mb-16">
        <p class="font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-4">探索资源</p>
        <h2 class="font-heading font-light text-section-title text-brand">景区 · 场馆 · 活动</h2>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <!-- A级景区 -->
        <div class="group cursor-pointer" @click="goToList('spots')">
          <div class="aspect-[16/10] bg-border rounded overflow-hidden mb-6">
            <img
              src="https://images.unsplash.com/photo-1537531383496-f4749b8032cf?w=600&q=80"
              alt="A级景区"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-card-title font-light text-brand mb-3">A级景区</h3>
          <p class="font-body text-card-desc text-muted leading-[1.6]">从5A到1A，重庆{{ scenicSpotStore.total || '—' }}个A级景区覆盖自然景观、历史遗迹、主题乐园等多种类型。</p>
          <span class="inline-block mt-4 font-body text-nav text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览景区 →</span>
        </div>
        <!-- 文化场馆 -->
        <div class="group cursor-pointer" @click="goToList('venues')">
          <div class="aspect-[16/10] bg-border rounded overflow-hidden mb-6">
            <img
              src="https://images.unsplash.com/photo-1518998053901-5348d3961a04?w=600&q=80"
              alt="文化场馆"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-card-title font-light text-brand mb-3">文化场馆</h3>
          <p class="font-body text-card-desc text-muted leading-[1.6]">博物馆、图书馆、体育馆、剧院——{{ venueStore.total || '—' }}个文化体育设施，满足你的不同需求。</p>
          <span class="inline-block mt-4 font-body text-nav text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览场馆 →</span>
        </div>
        <!-- 特色活动 -->
        <div class="group cursor-pointer" @click="goToList('activities')">
          <div class="aspect-[16/10] bg-border rounded overflow-hidden mb-6">
            <img
              src="https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80"
              alt="特色活动"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
            />
          </div>
          <h3 class="font-heading text-card-title font-light text-brand mb-3">特色活动</h3>
          <p class="font-body text-card-desc text-muted leading-[1.6]">川剧变脸、书法课堂、马拉松、文化节——{{ activityStore.total || '—' }}个特色活动等你参与。</p>
          <span class="inline-block mt-4 font-body text-nav text-brand border-b border-brand pb-0.5 group-hover:text-muted group-hover:border-muted transition-all">浏览活动 →</span>
        </div>
      </div>
    </section>

    <!-- 最新资讯 + 最新公告 -->
    <section class="py-24 px-20 bg-light">
      <div class="grid lg:grid-cols-2 gap-16">
        <!-- 最新资讯 -->
        <div>
          <div class="flex justify-between items-end mb-8">
            <div>
              <p class="font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-2">资讯</p>
              <h2 class="font-heading font-light text-section-title text-brand">最新资讯</h2>
            </div>
            <router-link to="/news" class="font-body text-nav text-muted hover:text-brand transition-colors tracking-wider">
              查看全部 →
            </router-link>
          </div>
          <div v-if="newsStore.newsList.length > 0" class="space-y-4">
            <article
              v-for="item in newsStore.newsList"
              :key="item.id"
              @click="router.push(`/news/${item.id}`)"
              class="border-l-2 border-border pl-4 cursor-pointer group hover:border-accent transition-colors"
            >
              <h3 class="font-heading text-[13px] text-brand group-hover:text-accent transition-colors line-clamp-2 leading-snug">
                {{ item.title }}
              </h3>
              <p class="text-xs text-muted mt-1">{{ item.publishTime }}</p>
            </article>
          </div>
          <EmptyState v-else-if="newsStore.isLoading === false" message="暂无资讯" />
        </div>
        <!-- 最新公告 -->
        <div>
          <div class="flex justify-between items-end mb-8">
            <div>
              <p class="font-body text-section-sub tracking-[0.25em] text-muted uppercase mb-2">公告</p>
              <h2 class="font-heading font-light text-section-title text-brand">最新公告</h2>
            </div>
            <router-link to="/notices" class="font-body text-nav text-muted hover:text-brand transition-colors tracking-wider">
              查看全部 →
            </router-link>
          </div>
          <div v-if="noticeStore.noticeList.length > 0" class="space-y-4">
            <article
              v-for="item in noticeStore.noticeList"
              :key="item.id"
              @click="router.push(`/notices/${item.id}`)"
              class="border-l-2 border-border pl-4 cursor-pointer group hover:border-accent transition-colors"
            >
              <h3 class="font-heading text-[13px] text-brand group-hover:text-accent transition-colors line-clamp-1 leading-snug">
                {{ item.title }}
              </h3>
              <p class="text-xs text-muted mt-1">{{ item.publishTime }}</p>
            </article>
          </div>
          <EmptyState v-else-if="noticeStore.isLoading === false" message="暂无公告" />
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark py-16 px-20">
      <div class="grid grid-cols-2 md:grid-cols-4 gap-12 mb-16">
        <div>
          <div class="font-heading text-base font-semibold text-white tracking-[0.1em] uppercase mb-6">山城文旅</div>
          <p class="font-body text-footer text-white/50 leading-[1.7]">探索重庆山水、人文与美食的权威平台。</p>
        </div>
        <div>
          <div class="font-body text-footer-small tracking-[0.2em] text-white/40 uppercase mb-6">快速导航</div>
          <router-link to="/spots" class="block font-body text-footer text-white/60 mb-3 hover:text-white transition-colors">A级景区</router-link>
          <router-link to="/venues" class="block font-body text-footer text-white/60 mb-3 hover:text-white transition-colors">文化场馆</router-link>
          <router-link to="/activities" class="block font-body text-footer text-white/60 hover:text-white transition-colors">特色活动</router-link>
        </div>
        <div>
          <div class="font-body text-footer-small tracking-[0.2em] text-white/40 uppercase mb-6">关于</div>
          <span class="block font-body text-footer text-white/60 mb-3">重庆文旅</span>
          <span class="block font-body text-footer text-white/60 mb-3">新闻资讯</span>
          <span class="block font-body text-footer text-white/60">联系我们</span>
        </div>
        <div>
          <div class="font-body text-footer-small tracking-[0.2em] text-white/40 uppercase mb-6">登录</div>
          <router-link to="/login" class="block font-body text-footer text-white/60 mb-3 hover:text-white transition-colors">登录</router-link>
          <router-link to="/register" class="block font-body text-footer text-white/60 hover:text-white transition-colors">注册</router-link>
        </div>
      </div>
      <div class="border-t border-white/10 pt-8 flex justify-between font-body text-footer-small text-white/30">
        <span>© 2026 重庆文旅网站管理系统</span>
        <span>渝ICP备XXXXXXXX号</span>
      </div>
    </footer>
  </div>
</template>
