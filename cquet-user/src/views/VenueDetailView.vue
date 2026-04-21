<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { RouterLink, useRoute, useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import StateBlock from '@/components/channel/StateBlock.vue'
import { useVenueStore } from '@/stores/venue'
import type { Venue } from '@/api/venue'

const props = defineProps<{ id: string }>()
const store = useVenueStore()
const route = useRoute()
const router = useRouter()

const currentId = computed(() => Number(props.id || route.params.id))

const loadVenue = () => {
  if (!Number.isFinite(currentId.value)) return
  store.fetchVenueDetail(currentId.value)
  store.fetchVenueImages(currentId.value)
}

onMounted(loadVenue)

const venue = computed<Venue | null>(() => store.currentVenue as Venue | null)

const imageList = computed(() => {
  const images = [...(venue.value?.images || []), ...store.venueImages]
  return Array.from(new Set(images.filter(Boolean)))
})

const heroStyle = computed(() => {
  const image = imageList.value[0]
  return image
    ? { backgroundImage: `linear-gradient(115deg, rgba(0, 83, 66, 0.86), rgba(9, 21, 42, 0.92)), url("${image}")` }
    : {}
})

const venueName = computed(() => venue.value?.name || '场馆详情')
const venueCategory = computed(() => venue.value?.type || venue.value?.category || '文化场馆')
const venueCity = computed(() => venue.value?.city || venue.value?.district || '重庆')
const venueAddress = computed(() => venue.value?.address || '地址待更新')
const openTime = computed(() => venue.value?.openingHours || venue.value?.openHours || '开放时间待更新')
const ticketText = computed(() => formatTicket(venue.value?.ticketPrice ?? venue.value?.ticketInfo))
const capacityText = computed(() => formatCapacity(venue.value?.capacity))
const bookingText = computed(() => {
  if (venue.value?.bookingRequired === '1') return '需预约'
  if (venue.value?.bookingRequired === '0') return '免预约'
  return '预约信息待更新'
})
const description = computed(() => venue.value?.description || '')
const summary = computed(() => {
  if (!description.value) return '暂无场馆简介'
  return description.value.length > 72 ? `${description.value.slice(0, 72)}...` : description.value
})

const heroTags = computed(() => {
  const tags = [venueCategory.value, venueCity.value, bookingText.value]
  return Array.from(new Set(tags.filter(Boolean))).slice(0, 5)
})

const heroStats = computed(() => [
  { label: '场馆类型', value: venueCategory.value, icon: 'tag' },
  { label: '开放时间', value: openTime.value, icon: 'clock' },
  { label: '门票价格', value: ticketText.value, icon: 'ticket' },
  { label: '场馆容量', value: capacityText.value, icon: 'capacity' },
])

const basicInfo = computed(() => [
  { label: '地址', value: venueAddress.value },
  { label: '开放时间', value: openTime.value },
  { label: '门票价格', value: ticketText.value },
  { label: '场馆类型', value: venueCategory.value },
  { label: '所在城市', value: venueCity.value },
  { label: '场馆容量', value: capacityText.value },
  { label: '预约状态', value: bookingText.value },
])

const detailCards = computed(() => [
  { label: '场馆类型', value: venueCategory.value },
  { label: '场馆容量', value: capacityText.value },
  { label: '开放时间', value: openTime.value },
  { label: '预约状态', value: bookingText.value },
  { label: '门票价格', value: ticketText.value },
])

const contactItems = computed(() => [
  { label: '联系电话', value: venue.value?.contactPhone || '' },
  { label: '官方网站', value: venue.value?.website || '' },
].filter(item => item.value))

const facilities = computed(() => {
  const raw = venue.value?.facilities
  if (!raw) return []
  return Array.isArray(raw)
    ? raw
    : raw.split(/[,，]/).map(item => item.trim()).filter(Boolean)
})

function formatTicket(value?: string | number) {
  if (value === undefined || value === null || value === '') return '票价待更新'
  const numericValue = Number(value)
  if (!Number.isNaN(numericValue)) return numericValue <= 0 ? '免费开放' : `${numericValue}元起`
  return String(value)
}

function formatCapacity(value?: number) {
  if (value === undefined || value === null || Number(value) <= 0) return '容量待更新'
  return `${value} 人`
}
</script>

<template>
  <NavBar />

  <main class="venue-detail min-h-screen bg-white pt-[72px]">
    <section class="venue-backbar">
      <div class="venue-container">
        <RouterLink to="/venues" class="venue-backlink">
          <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
          </svg>
          返回场馆列表
        </RouterLink>
      </div>
    </section>

    <StateBlock
      v-if="store.isLoading"
      class="venue-container py-12"
      type="loading"
    />

    <StateBlock
      v-else-if="store.error"
      class="venue-container py-12"
      type="error"
      title="场馆加载失败"
      description="网络异常或数据暂不可用，请稍后重试。"
      action-text="重新加载"
      @action="loadVenue"
    />

    <StateBlock
      v-else-if="!venue"
      class="venue-container py-12"
      type="empty"
      title="未找到该场馆"
      description="该场馆可能已下架，或当前链接暂不可用。"
      action-text="返回场馆列表"
      @action="router.push('/venues')"
    />

    <template v-else>
      <section class="venue-hero-detail" :style="heroStyle">
        <div class="venue-hero-detail__pattern" aria-hidden="true"></div>
        <div class="venue-container venue-hero-detail__inner">
          <div class="venue-tags">
            <span v-for="tag in heroTags" :key="tag">{{ tag }}</span>
          </div>

          <h1>{{ venueName }}</h1>

          <div class="venue-hero-detail__meta">
            <span>
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
              </svg>
              {{ venueCategory }}
            </span>
            <span>
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              {{ venueCity }}
            </span>
          </div>

          <p class="venue-hero-detail__summary">{{ summary }}</p>

          <div class="venue-hero-facts">
            <article v-for="item in heroStats" :key="item.label">
              <span class="venue-hero-facts__icon">
                <svg v-if="item.icon === 'tag'" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.169.659 1.591l8.682 8.682a2.25 2.25 0 003.182 0l4.318-4.318a2.25 2.25 0 000-3.182L11.159 3.659A2.25 2.25 0 009.568 3z" />
                </svg>
                <svg v-else-if="item.icon === 'ticket'" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v12m4.5-9.75h-6.75a2.25 2.25 0 000 4.5h4.5a2.25 2.25 0 010 4.5H7.5" />
                </svg>
                <svg v-else class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </span>
              <div>
                <p>{{ item.label }}</p>
                <strong>{{ item.value }}</strong>
              </div>
            </article>
          </div>

          <div class="venue-hero-actions">
            <button type="button" class="is-primary">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0z" />
              </svg>
              收藏场馆
            </button>
            <button type="button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.697.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z" />
              </svg>
              分享给朋友
            </button>
            <button type="button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
              </svg>
              查看导航
            </button>
          </div>
        </div>
      </section>

      <section class="venue-container venue-content">
        <div class="venue-main">
          <section class="venue-section">
            <h2>场馆介绍</h2>
            <p class="venue-intro">{{ description || '暂无场馆介绍' }}</p>
          </section>

          <section class="venue-section">
            <h2>场馆信息</h2>
            <div class="venue-info-grid">
              <article v-for="item in detailCards" :key="item.label">
                <span>{{ item.label }}</span>
                <strong>{{ item.value }}</strong>
              </article>
            </div>
          </section>

          <section v-if="facilities.length > 0" class="venue-section">
            <h2>服务设施</h2>
            <div class="venue-chip-list">
              <span v-for="item in facilities" :key="item">{{ item }}</span>
            </div>
          </section>

          <section v-if="contactItems.length > 0" class="venue-section">
            <h2>联系方式</h2>
            <div class="venue-contact-list">
              <article v-for="item in contactItems" :key="item.label">
                <span>{{ item.label }}</span>
                <strong>{{ item.value }}</strong>
              </article>
            </div>
          </section>
        </div>

        <aside class="venue-sidebar">
          <section class="venue-info-card">
            <h2>基本信息</h2>
            <div class="venue-basic-list">
              <article v-for="item in basicInfo" :key="item.label">
                <span>{{ item.label }}</span>
                <strong>{{ item.value }}</strong>
              </article>
            </div>
            <div class="venue-map-placeholder">
              <svg class="h-12 w-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              <span>地图视图</span>
            </div>
            <button type="button" class="venue-map-button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
              </svg>
              打开导航
            </button>
          </section>
        </aside>
      </section>
    </template>

    <BackToTop />
  </main>
</template>

<style scoped>
.venue-detail {
  color: var(--brand);
}

.venue-container {
  width: min(100%, 1280px);
  margin: 0 auto;
  padding-inline: 24px;
}

.venue-backbar {
  border-bottom: 1px solid rgba(223, 223, 223, 0.82);
  background: #f8f8f7;
}

.venue-backlink {
  display: inline-flex;
  min-height: 86px;
  align-items: center;
  gap: 12px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  text-decoration: none;
  transition: color 0.25s ease;
}

.venue-backlink:hover {
  color: var(--brand);
}

.venue-hero-detail {
  position: relative;
  overflow: hidden;
  background:
    linear-gradient(115deg, rgba(0, 83, 66, 0.9) 0%, rgba(186, 211, 203, 0.84) 52%, rgba(8, 18, 36, 0.98) 100%),
    var(--dark);
  background-position: center;
  background-size: cover;
}

.venue-hero-detail__pattern {
  position: absolute;
  inset: 0;
  opacity: 0.08;
  background-image:
    radial-gradient(circle at 0 0, transparent 0 35px, #ffffff 36px, transparent 37px),
    radial-gradient(circle at 56px 56px, transparent 0 35px, #ffffff 36px, transparent 37px);
  background-size: 112px 112px;
}

.venue-hero-detail__inner {
  position: relative;
  z-index: 1;
  padding-block: 66px 70px;
}

.venue-tags {
  display: flex;
  max-width: 760px;
  flex-wrap: wrap;
  gap: 14px;
}

.venue-tags span {
  display: inline-flex;
  min-height: 36px;
  align-items: center;
  border: 1px solid rgba(255, 255, 255, 0.16);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  padding: 0 18px;
  color: rgba(255, 255, 255, 0.82);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-tags span:first-child {
  border-color: transparent;
  background: #009766;
  color: #ffffff;
}

.venue-hero-detail h1 {
  max-width: 940px;
  margin-top: 32px;
  color: #ffffff;
  font-family: 'Montserrat', sans-serif;
  font-size: 62px;
  font-weight: 600;
  line-height: 1.08;
}

.venue-hero-detail__meta {
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
  margin-top: 24px;
  color: rgba(255, 255, 255, 0.74);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
}

.venue-hero-detail__meta span {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.venue-hero-detail__summary {
  max-width: 760px;
  margin-top: 26px;
  color: rgba(255, 255, 255, 0.7);
  font-family: 'Manrope', sans-serif;
  font-size: 20px;
  line-height: 1.7;
}

.venue-hero-facts {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
  max-width: 1080px;
  margin-top: 44px;
}

.venue-hero-facts article {
  display: flex;
  min-height: 86px;
  align-items: center;
  gap: 18px;
  border: 1px solid rgba(255, 255, 255, 0.14);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.08);
  padding: 18px;
}

.venue-hero-facts__icon {
  display: inline-flex;
  color: #54e5b5;
}

.venue-hero-facts p {
  color: rgba(255, 255, 255, 0.54);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-hero-facts strong {
  display: block;
  margin-top: 7px;
  color: #ffffff;
  font-family: 'Manrope', sans-serif;
  font-size: 20px;
  font-weight: 700;
}

.venue-hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 40px;
}

.venue-hero-actions button,
.venue-map-button {
  display: inline-flex;
  min-height: 48px;
  align-items: center;
  justify-content: center;
  gap: 12px;
  border: 1px solid rgba(255, 255, 255, 0.18);
  border-radius: 16px;
  padding: 0 28px;
  color: #ffffff;
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  transition: transform 0.25s ease, border-color 0.25s ease, background 0.25s ease;
}

.venue-hero-actions button:hover,
.venue-map-button:hover {
  transform: translateY(-1px);
}

.venue-hero-actions .is-primary {
  border-color: #ffffff;
  background: #ffffff;
  color: var(--brand);
}

.venue-content {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 360px;
  gap: 42px;
  padding-block: 70px;
}

.venue-main {
  min-width: 0;
}

.venue-section {
  border-bottom: 1px solid var(--border);
  padding-bottom: 48px;
  margin-bottom: 48px;
}

.venue-section:last-child {
  border-bottom: 0;
  margin-bottom: 0;
}

.venue-section h2,
.venue-info-card h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 32px;
  font-weight: 500;
  line-height: 1.25;
}

.venue-intro {
  margin-top: 34px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 18px;
  line-height: 2;
  white-space: pre-line;
}

.venue-info-grid,
.venue-contact-list {
  display: grid;
  gap: 16px;
  margin-top: 34px;
}

.venue-info-grid article,
.venue-contact-list article {
  display: grid;
  gap: 8px;
  border: 1px solid var(--border);
  border-radius: 18px;
  background: #fafafa;
  padding: 20px 22px;
}

.venue-info-grid span,
.venue-contact-list span,
.venue-basic-list span {
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-info-grid strong,
.venue-contact-list strong,
.venue-basic-list strong {
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  font-weight: 500;
  line-height: 1.7;
}

.venue-chip-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 34px;
}

.venue-chip-list span {
  display: inline-flex;
  min-height: 34px;
  align-items: center;
  border: 1px solid rgba(0, 151, 102, 0.18);
  border-radius: 999px;
  background: rgba(0, 151, 102, 0.08);
  padding: 0 14px;
  color: #007c59;
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-sidebar {
  align-self: start;
  position: sticky;
  top: 100px;
}

.venue-info-card {
  border: 1px solid var(--border);
  border-radius: 22px;
  background: #ffffff;
  padding: 28px;
  box-shadow: 0 18px 42px rgba(9, 44, 56, 0.06);
}

.venue-basic-list {
  display: grid;
  gap: 18px;
  margin-top: 26px;
  border-bottom: 1px solid var(--border);
  padding-bottom: 24px;
}

.venue-basic-list article {
  display: grid;
  gap: 6px;
}

.venue-map-placeholder {
  display: flex;
  min-height: 220px;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-top: 24px;
  border: 1px solid var(--border);
  border-radius: 18px;
  background: #f4f4f5;
  color: #707083;
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
}

.venue-map-button {
  width: 100%;
  margin-top: 18px;
  border-color: var(--brand);
  background: #02000f;
  color: #ffffff;
}

@media (max-width: 1120px) {
  .venue-hero-facts,
  .venue-content {
    grid-template-columns: 1fr 1fr;
  }

  .venue-sidebar {
    position: static;
  }
}

@media (max-width: 767px) {
  .venue-container {
    padding-inline: 18px;
  }

  .venue-backlink {
    min-height: 68px;
  }

  .venue-hero-detail__inner {
    padding-block: 42px 46px;
  }

  .venue-hero-detail h1 {
    font-size: 42px;
  }

  .venue-hero-detail__summary {
    font-size: 17px;
  }

  .venue-hero-facts,
  .venue-content {
    grid-template-columns: 1fr;
  }

  .venue-section h2,
  .venue-info-card h2 {
    font-size: 28px;
  }

  .venue-content {
    padding-block: 44px;
  }
}
</style>
