<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { RouterLink, useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useActivityStore } from '@/stores/activity'
import { getVenue, type Venue } from '@/api/venue'
import { activityDetailMock } from '@/mocks/activityDetailMock'

interface DetailActivity {
  id: number
  name: string
  category?: string
  type?: string
  venueId?: number
  venueName?: string
  startTime?: string
  endTime?: string
  description?: string
  status?: string
  auditStatus?: string
  auditReason?: string
  currentParticipants?: number
  maxParticipants?: number
}

const props = defineProps<{ id: string }>()
const store = useActivityStore()
const route = useRoute()

const isCollected = ref(false)
const shareCopied = ref(false)
const activityVenue = ref<Venue | null>(null)

const activityId = computed(() => Number(props.id || route.params.id))
const activity = computed(() => {
  const raw = store.currentActivity as (DetailActivity & { data?: DetailActivity }) | null
  const data = raw?.data?.id ? raw.data : raw
  return data?.id && data?.name ? data : null
})

const parseDate = (value?: string) => {
  if (!value) return null
  const date = new Date(value.replace(/-/g, '/').replace('T', ' '))
  return Number.isNaN(date.getTime()) ? null : date
}

const formatDate = (value?: string) => {
  const date = parseDate(value)
  if (!date) return ''
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

const formatTimeRange = (start?: string, end?: string) => {
  if (!start) return ''
  const startText = start.slice(11, 16) || start
  const endText = end?.slice(11, 16)
  return endText ? `${startText} - ${endText}` : startText
}

const activityTitle = computed(() => activity.value?.name || '')
const activityCategory = computed(() => activity.value?.category || activity.value?.type || '')
const activityLocation = computed(() => activityVenue.value?.name || '')
const activityAddress = computed(() => activityVenue.value?.address || activityDetailMock.sideAddress.address)
const activityDescription = computed(() => activity.value?.description?.trim() || '')
const activitySummary = computed(() => {
  if (!activityDescription.value) return ''
  return activityDescription.value.length > 58
    ? `${activityDescription.value.slice(0, 58)}...`
    : activityDescription.value
})

const activityScale = computed(() => {
  if (typeof activity.value?.maxParticipants === 'number') return `${activity.value.maxParticipants}人`
  return activityDetailMock.scaleText
})

const bannerTags = computed(() => {
  const tags = [activityCategory.value, ...activityDetailMock.bannerTags]
  return Array.from(new Set(tags.filter(Boolean))).slice(0, 6)
})

const introductionParagraphs = computed(() => {
  if (!activityDescription.value) return []
  return activityDescription.value
    .split(/\n+/)
    .map(paragraph => paragraph.trim())
    .filter(Boolean)
})

const venueDetailPath = computed(() => {
  return activity.value?.venueId ? `/venues/${activity.value.venueId}` : '/venues'
})

const venueInfo = computed(() => ({
  ...activityDetailMock.venue,
  name: activityLocation.value || activityDetailMock.venue.name,
  address: activityAddress.value,
}))

onMounted(() => {
  loadActivity()
})

const handleRetry = () => {
  loadActivity()
}

const loadActivity = async () => {
  activityVenue.value = null
  await store.fetchActivityDetail(activityId.value)
  if (!activity.value?.venueId) return

  try {
    const res: any = await getVenue(activity.value.venueId)
    const venueData = res.data?.id ? res.data : res.data?.data || res.data || res
    activityVenue.value = venueData?.id ? venueData : null
  } catch {
    activityVenue.value = null
  }
}

const toggleCollection = () => {
  isCollected.value = !isCollected.value
}

const shareActivity = async () => {
  shareCopied.value = false
  const url = window.location.href
  try {
    if (navigator.share) {
      await navigator.share({ title: activityTitle.value, url })
      return
    }
    if (navigator.clipboard) {
      await navigator.clipboard.writeText(url)
      shareCopied.value = true
      window.setTimeout(() => {
        shareCopied.value = false
      }, 1600)
    }
  } catch {
    shareCopied.value = false
  }
}

const openNavigation = () => {
  const keyword = encodeURIComponent(activityAddress.value)
  window.open(`https://uri.amap.com/search?keyword=${keyword}`, '_blank')
}
</script>

<template>
  <NavBar />

  <main class="min-h-screen bg-white pt-[72px]">
    <LoadingState v-if="store.isLoading" :isLoading="store.isLoading" />
    <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
    <EmptyState v-else-if="!activity" message="未找到该活动" />

    <template v-else>
      <section class="activity-banner">
        <div class="activity-banner__texture" aria-hidden="true"></div>
        <div class="activity-banner__shade" aria-hidden="true"></div>

        <div class="activity-banner__inner">
          <RouterLink to="/activities" class="back-link">
            <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
            </svg>
            返回活动列表
          </RouterLink>

          <div class="mt-16 flex flex-wrap gap-3 lg:mt-20">
            <span
              v-for="tag in bannerTags"
              :key="tag"
              class="inline-flex items-center rounded-full border border-white/16 bg-white/10 px-4 py-2 font-body text-sm text-white/76 backdrop-blur-sm"
            >
              {{ tag }}
            </span>
          </div>

          <h1 class="mt-8 max-w-[780px] font-heading text-[44px] font-semibold leading-tight text-white md:text-[64px]">
            {{ activityTitle }}
          </h1>
          <p v-if="activitySummary" class="mt-5 max-w-[760px] font-body text-[17px] leading-8 text-white/72 md:text-[20px]">
            {{ activitySummary }}
          </p>

          <div class="mt-10 grid gap-4 md:grid-cols-2 xl:grid-cols-4">
            <div class="banner-info-card">
              <svg class="h-7 w-7 text-white/54" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M6.75 3v2.25m10.5-2.25v2.25M4.5 9h15M5.25 5.25h13.5A1.5 1.5 0 0120.25 6.75v11.5a1.5 1.5 0 01-1.5 1.5H5.25a1.5 1.5 0 01-1.5-1.5V6.75a1.5 1.5 0 011.5-1.5z" />
              </svg>
              <div>
                <p>活动日期</p>
                <strong>{{ formatDate(activity.startTime) }}</strong>
              </div>
            </div>
            <div class="banner-info-card">
              <svg class="h-7 w-7 text-white/54" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <div>
                <p>活动时间</p>
                <strong>{{ formatTimeRange(activity.startTime, activity.endTime) }}</strong>
              </div>
            </div>
            <div class="banner-info-card">
              <svg class="h-7 w-7 text-white/54" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              <div>
                <p>活动地点</p>
                <strong>{{ activityLocation }}</strong>
              </div>
            </div>
            <div class="banner-info-card">
              <svg class="h-7 w-7 text-white/54" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M18 18.72a8.94 8.94 0 00-12 0M15 10.5a3 3 0 11-6 0 3 3 0 016 0zm6 1.5a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <div>
                <p>活动规模</p>
                <strong>{{ activityScale }}</strong>
              </div>
            </div>
          </div>

          <div class="mt-9 flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
            <div class="flex flex-wrap gap-3">
              <button type="button" class="banner-action banner-action--primary" @click="toggleCollection">
                <svg class="h-5 w-5" :fill="isCollected ? 'currentColor' : 'none'" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M17.25 3.75H6.75A1.5 1.5 0 005.25 5.25v15l6.75-3.75 6.75 3.75v-15a1.5 1.5 0 00-1.5-1.5z" />
                </svg>
                {{ isCollected ? '已收藏' : '收藏活动' }}
              </button>
              <button type="button" class="banner-action" @click="shareActivity">
                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M7.5 12l9-5.25M7.5 12l9 5.25M7.5 12a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm13.5-6.75a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm0 13.5a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z" />
                </svg>
                {{ shareCopied ? '链接已复制' : '分享活动' }}
              </button>
            </div>
            <p class="font-body text-base text-white/82">
              票价：
              <span class="ml-3 font-heading text-[22px] font-semibold text-white">{{ activityDetailMock.priceText }}</span>
            </p>
          </div>
        </div>
      </section>

      <section class="mx-auto grid max-w-[1280px] gap-12 px-6 py-16 lg:grid-cols-[minmax(0,1fr)_360px] lg:px-10 lg:py-20">
        <div class="min-w-0 space-y-14">
          <section class="content-section">
            <h2>活动介绍</h2>
            <div v-if="introductionParagraphs.length" class="mt-7 space-y-5">
              <p v-for="paragraph in introductionParagraphs" :key="paragraph" class="content-paragraph">
                {{ paragraph }}
              </p>
            </div>
          </section>

          <section class="content-section">
            <div class="mb-7 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
              <h2>活动场馆</h2>
              <RouterLink :to="venueDetailPath" class="venue-detail-link">
                查看场馆详情
                <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                </svg>
              </RouterLink>
            </div>

            <article class="venue-card">
              <div class="venue-card__hero">
                <div class="venue-card__icon">
                  <svg class="h-9 w-9 text-accent" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                  </svg>
                </div>
                <div>
                  <h3>{{ venueInfo.name }}</h3>
                  <p>{{ venueInfo.description }}</p>
                </div>
              </div>

              <div class="venue-card__grid">
                <div class="venue-meta">
                  <svg class="h-5 w-5 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                  </svg>
                  <div>
                    <span>场馆地址</span>
                    <strong>{{ venueInfo.address }}</strong>
                  </div>
                </div>
                <div class="venue-meta">
                  <svg class="h-5 w-5 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.37a1.5 1.5 0 00-1.02-1.42l-4.18-1.39a1.5 1.5 0 00-1.64.47l-1.02 1.24a11.25 11.25 0 01-5.92-5.92l1.24-1.02a1.5 1.5 0 00.47-1.64L8.29 4.27a1.5 1.5 0 00-1.42-1.02H5.5A2.25 2.25 0 003.25 5.5v1.25z" />
                  </svg>
                  <div>
                    <span>联系电话</span>
                    <strong>{{ venueInfo.phone }}</strong>
                  </div>
                </div>
                <div class="venue-meta">
                  <svg class="h-5 w-5 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
                  </svg>
                  <div>
                    <span>交通指引</span>
                    <strong>{{ venueInfo.traffic }}</strong>
                  </div>
                </div>
                <div class="venue-meta">
                  <svg class="h-5 w-5 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M12 21a9 9 0 100-18 9 9 0 000 18zm0 0c2.25-2.25 3.375-5.25 3.375-9S14.25 5.25 12 3m0 18c-2.25-2.25-3.375-5.25-3.375-9S9.75 5.25 12 3m-8.25 9h16.5" />
                  </svg>
                  <div>
                    <span>官方网站</span>
                    <a :href="venueInfo.websiteUrl" target="_blank" rel="noreferrer">{{ venueInfo.websiteText }}</a>
                  </div>
                </div>
              </div>

              <div class="venue-facilities">
                <p>场馆设施</p>
                <div>
                  <span v-for="item in venueInfo.facilities" :key="item">{{ item }}</span>
                </div>
              </div>

              <div class="venue-map">
                <svg class="h-11 w-11 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                </svg>
                <span>{{ venueInfo.mapLabel }}</span>
              </div>
            </article>
          </section>
        </div>

        <aside class="lg:sticky lg:top-[96px] lg:self-start">
          <div class="floating-info-card">
            <h2>基本信息</h2>
            <div class="mt-7">
              <div class="flex items-start gap-3">
                <svg class="mt-1 h-5 w-5 flex-none text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.6" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                </svg>
                <div>
                  <p class="font-body text-sm text-muted">地址</p>
                  <p class="mt-2 font-body text-base leading-7 text-brand">{{ activityAddress }}</p>
                </div>
              </div>
            </div>

            <div class="map-placeholder mt-6">
              <svg class="h-11 w-11 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              <span>{{ activityDetailMock.sideAddress.mapLabel }}</span>
            </div>

            <button type="button" class="navigation-button" @click="openNavigation">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
              </svg>
              打开导航
            </button>
          </div>
        </aside>
      </section>
    </template>
  </main>
</template>

<style scoped>
.activity-banner {
  position: relative;
  width: 100%;
  overflow: hidden;
  background:
    linear-gradient(116deg, rgba(9, 44, 56, 0.96) 0%, rgba(100, 137, 146, 0.72) 52%, rgba(34, 42, 44, 0.98) 100%),
    var(--dark);
}

.activity-banner__texture {
  position: absolute;
  inset: 0;
  opacity: 0.1;
  background-image:
    linear-gradient(90deg, rgba(255, 255, 255, 0.16) 1px, transparent 1px),
    linear-gradient(180deg, rgba(255, 255, 255, 0.12) 1px, transparent 1px);
  background-size: 88px 88px;
}

.activity-banner__shade {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(245, 244, 242, 0.08) 0%, rgba(9, 44, 56, 0) 34%, rgba(9, 44, 56, 0.34) 100%);
}

.activity-banner__inner {
  position: relative;
  z-index: 1;
  max-width: 1280px;
  margin: 0 auto;
  padding: 28px 24px 72px;
}

.back-link {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  color: rgba(255, 255, 255, 0.72);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  text-decoration: none;
  transition: color 0.25s ease;
}

.back-link:hover {
  color: #ffffff;
}

.banner-info-card {
  display: flex;
  align-items: center;
  gap: 18px;
  min-height: 92px;
  padding: 20px 22px;
  border: 1px solid rgba(255, 255, 255, 0.14);
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(10px);
}

.banner-info-card p {
  margin-bottom: 8px;
  color: rgba(255, 255, 255, 0.56);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.banner-info-card strong {
  color: #ffffff;
  font-family: 'Montserrat', sans-serif;
  font-size: 19px;
  font-weight: 600;
  line-height: 1.3;
}

.banner-action {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  min-height: 52px;
  padding: 0 28px;
  border: 1px solid rgba(255, 255, 255, 0.18);
  border-radius: 16px;
  color: rgba(255, 255, 255, 0.78);
  background: rgba(255, 255, 255, 0.06);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  transition: all 0.25s ease;
}

.banner-action:hover {
  border-color: rgba(255, 255, 255, 0.38);
  color: #ffffff;
}

.banner-action--primary {
  border-color: #ffffff;
  color: var(--brand);
  background: #ffffff;
  box-shadow: 0 18px 36px rgba(9, 44, 56, 0.18);
}

.banner-action--primary:hover {
  color: var(--brand);
  background: var(--light);
}

.content-section h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 30px;
  font-weight: 600;
  line-height: 1.2;
}

.content-paragraph {
  max-width: 780px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 17px;
  line-height: 2;
}

.venue-detail-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--accent);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  text-decoration: none;
  transition: color 0.25s ease;
}

.venue-detail-link:hover {
  color: var(--brand);
}

.venue-card {
  border: 1px solid var(--border);
  border-radius: 24px;
  background: #ffffff;
  padding: 30px;
  box-shadow: 0 14px 36px rgba(9, 44, 56, 0.06);
}

.venue-card__hero {
  display: grid;
  grid-template-columns: 72px minmax(0, 1fr);
  gap: 24px;
  padding-bottom: 28px;
  border-bottom: 1px solid var(--border);
}

.venue-card__icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 72px;
  height: 72px;
  border: 1px solid rgba(16, 86, 112, 0.12);
  border-radius: 20px;
  background: rgba(16, 86, 112, 0.08);
}

.venue-card__hero h3 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 26px;
  font-weight: 600;
  line-height: 1.25;
}

.venue-card__hero p {
  margin-top: 12px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  line-height: 1.85;
}

.venue-card__grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 24px 44px;
  margin-top: 28px;
}

.venue-meta {
  display: grid;
  grid-template-columns: 24px minmax(0, 1fr);
  gap: 16px;
}

.venue-meta span,
.venue-facilities p {
  display: block;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-meta strong,
.venue-meta a {
  display: block;
  margin-top: 8px;
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 17px;
  font-weight: 600;
  line-height: 1.6;
  text-decoration: none;
}

.venue-meta a {
  color: var(--accent);
}

.venue-facilities {
  margin-top: 28px;
}

.venue-facilities div {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 14px;
}

.venue-facilities span {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-height: 38px;
  padding: 0 18px;
  border: 1px solid var(--border);
  border-radius: 14px;
  color: var(--brand);
  background: var(--light);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.venue-map,
.map-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  border: 1px solid var(--border);
  border-radius: 20px;
  background: var(--light);
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.venue-map {
  min-height: 220px;
  margin-top: 36px;
}

.floating-info-card {
  border: 1px solid rgba(223, 223, 223, 0.92);
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.96);
  padding: 28px;
  box-shadow: 0 22px 60px rgba(9, 44, 56, 0.12);
}

.floating-info-card h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 26px;
  font-weight: 600;
}

.map-placeholder {
  min-height: 180px;
}

.navigation-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  width: 100%;
  min-height: 54px;
  margin-top: 24px;
  border-radius: 16px;
  color: #ffffff;
  background: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  transition: background-color 0.25s ease;
}

.navigation-button:hover {
  background: var(--dark);
}

@media (min-width: 1024px) {
  .activity-banner__inner {
    padding: 32px 40px 76px;
  }
}

@media (max-width: 767px) {
  .activity-banner__inner {
    padding-bottom: 52px;
  }

  .banner-info-card {
    min-height: 84px;
    border-radius: 18px;
  }

  .content-section h2 {
    font-size: 26px;
  }

  .venue-card {
    padding: 24px;
  }

  .venue-card__hero,
  .venue-card__grid {
    grid-template-columns: 1fr;
  }

  .floating-info-card {
    padding: 24px;
  }
}
</style>
