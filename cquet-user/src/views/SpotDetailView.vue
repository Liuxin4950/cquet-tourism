<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { RouterLink, useRoute } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import StateBlock from '@/components/channel/StateBlock.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'
import { spotDetailMock } from '@/mocks/spotDetailMock'
import type { ScenicSpot, ScenicSpotVenue } from '@/api/scenicSpot'

const props = defineProps<{ id: string }>()
const store = useScenicSpotStore()
const route = useRoute()

const currentId = computed(() => Number(props.id || route.params.id))

const loadSpot = () => {
  if (!Number.isFinite(currentId.value)) return
  store.fetchSpotDetail(currentId.value)
  store.fetchSpotImages(currentId.value)
}

onMounted(loadSpot)

const spot = computed<ScenicSpot | null>(() => store.currentSpot as ScenicSpot | null)

const imageList = computed(() => {
  const images = [...(spot.value?.images || []), ...store.spotImages]
  return Array.from(new Set(images.filter(Boolean)))
})

const heroStyle = computed(() => {
  const image = imageList.value[0]
  return image
    ? { backgroundImage: `linear-gradient(115deg, rgba(0, 83, 66, 0.86), rgba(9, 21, 42, 0.92)), url("${image}")` }
    : {}
})

const spotName = computed(() => spot.value?.name || '景区详情')
const spotCity = computed(() => spot.value?.city || spot.value?.district || '重庆')
const spotAddress = computed(() => spot.value?.address || '地址待更新')
const openTime = computed(() => spot.value?.openTime || spot.value?.openHours || spot.value?.openingHours || '开放时间待更新')
const levelText = computed(() => formatLevel(spot.value?.level))
const ticketText = computed(() => formatTicket(spot.value?.ticketPrice))
const description = computed(() => spot.value?.description || '')
const summary = computed(() => {
  if (!description.value) return '暂无景区简介'
  return description.value.length > 72 ? `${description.value.slice(0, 72)}...` : description.value
})

const relatedVenues = computed<ScenicSpotVenue[]>(() => {
  return Array.isArray(spot.value?.venues) ? spot.value?.venues || [] : []
})

const heroTags = computed(() => {
  const tags = [levelText.value, ...spotDetailMock.heroTags]
  return Array.from(new Set(tags.filter(Boolean))).slice(0, 5)
})

const heroStats = computed(() => [
  { label: '景区等级', value: levelText.value, icon: 'tag' },
  { label: '开放时间', value: openTime.value, icon: 'clock' },
  { label: '门票价格', value: ticketText.value, icon: 'ticket' },
  { label: '游览时长', value: spotDetailMock.visitDuration, icon: 'time' },
])

const basicInfo = computed(() => [
  { label: '地址', value: spotAddress.value },
  { label: '开放时间', value: openTime.value },
  { label: '门票价格', value: ticketText.value },
  { label: '景区等级', value: levelText.value },
  { label: '所在城市', value: spotCity.value },
])

function formatLevel(level?: string) {
  if (!level) return '暂无等级'
  const trimmed = level.trim().toUpperCase()
  if (/^\dA$/.test(trimmed)) return `${trimmed.replace('A', '')}A级景区`
  const count = (trimmed.match(/A/g) || []).length
  return count > 0 ? `${count}A级景区` : level
}

function formatTicket(price?: string | number) {
  if (price === undefined || price === null || price === '') return '票价待更新'
  const numericPrice = Number(price)
  if (!Number.isNaN(numericPrice)) {
    return numericPrice <= 0 ? '免费开放' : `${numericPrice}元起`
  }
  return String(price)
}

function venueImage(venue: ScenicSpotVenue) {
  return venue.images?.[0] || ''
}

function venueFacilities(venue: ScenicSpotVenue) {
  if (!venue.facilities) return []
  return Array.isArray(venue.facilities)
    ? venue.facilities
    : venue.facilities.split(/[,，]/).map(item => item.trim()).filter(Boolean)
}
</script>

<template>
  <NavBar />

  <main class="spot-detail min-h-screen bg-white pt-[72px]">
    <section class="spot-backbar">
      <div class="spot-container">
        <RouterLink to="/spots" class="spot-backlink">
          <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
          </svg>
          返回景区列表
        </RouterLink>
      </div>
    </section>

    <StateBlock
      v-if="store.isLoading"
      class="spot-container py-12"
      type="loading"
    />

    <StateBlock
      v-else-if="store.error"
      class="spot-container py-12"
      type="error"
      title="景区加载失败"
      description="网络异常或数据暂不可用，请稍后重试。"
      action-text="重新加载"
      @action="loadSpot"
    />

    <StateBlock
      v-else-if="!spot"
      class="spot-container py-12"
      type="empty"
      title="未找到该景区"
      description="该景区可能已下架，或当前链接暂不可用。"
      action-text="返回景区列表"
      @action="$router.push('/spots')"
    />

    <template v-else>
      <section class="spot-hero-detail" :style="heroStyle">
        <div class="spot-hero-detail__pattern" aria-hidden="true"></div>
        <div class="spot-container spot-hero-detail__inner">
          <div class="spot-tags">
            <span v-for="tag in heroTags" :key="tag">{{ tag }}</span>
          </div>

          <h1>{{ spotName }}</h1>

          <div class="spot-hero-detail__meta">
            <span>
              <svg class="h-5 w-5 text-amber-400" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.801 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.538 1.118l-2.8-2.034a1 1 0 00-1.176 0l-2.8 2.034c-.783.57-1.838-.197-1.538-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81H7.03a1 1 0 00.95-.69l1.07-3.292z" />
              </svg>
              {{ spotDetailMock.rating }}
            </span>
            <span>{{ spotDetailMock.reviewCount }}</span>
            <span>
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              {{ spotCity }}
            </span>
          </div>

          <p class="spot-hero-detail__summary">{{ summary }}</p>

          <div class="spot-hero-facts">
            <article v-for="item in heroStats" :key="item.label">
              <span class="spot-hero-facts__icon">
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

          <div class="spot-hero-actions">
            <button type="button" class="is-primary">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0111.186 0z" />
              </svg>
              {{ spotDetailMock.actions.favorite }}
            </button>
            <button type="button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.697.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z" />
              </svg>
              {{ spotDetailMock.actions.share }}
            </button>
            <button type="button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
              </svg>
              {{ spotDetailMock.actions.navigation }}
            </button>
          </div>
        </div>
      </section>

      <section class="spot-container spot-content">
        <div class="spot-main">
          <section class="spot-section">
            <h2>景区介绍</h2>
            <p class="spot-intro">{{ description || '暂无景区介绍' }}</p>
          </section>

          <section class="spot-section">
            <h2>游览亮点</h2>
            <div class="spot-highlight-list">
              <article v-for="(item, index) in spotDetailMock.highlights" :key="item">
                <span>{{ index + 1 }}</span>
                <p>{{ item }}</p>
              </article>
            </div>
          </section>

          <section class="spot-section">
            <h2>交通指引</h2>
            <div class="spot-transport-list">
              <article v-for="item in spotDetailMock.transport" :key="item.title">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
                </svg>
                <div>
                  <h3>{{ item.title }}</h3>
                  <p>{{ item.description }}</p>
                </div>
              </article>
            </div>
          </section>

          <section v-if="relatedVenues.length > 0" class="spot-section">
            <div class="spot-section__head">
              <h2>景区内场馆</h2>
              <span>{{ relatedVenues.length }} 个相关场馆</span>
            </div>
            <div class="spot-venue-grid">
              <article v-for="venue in relatedVenues" :key="venue.id" class="spot-venue-card">
                <div class="spot-venue-card__image">
                  <img v-if="venueImage(venue)" :src="venueImage(venue)" :alt="venue.name || '场馆图片'" loading="lazy" />
                  <svg v-else class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
                  </svg>
                </div>
                <div class="spot-venue-card__body">
                  <h3>{{ venue.name || `场馆 #${venue.id}` }}</h3>
                  <p v-if="venue.address">{{ venue.address }}</p>
                  <p v-if="venue.description" class="spot-venue-card__desc">{{ venue.description }}</p>
                  <div v-if="venue.capacity || venueFacilities(venue).length" class="spot-venue-card__meta">
                    <span v-if="venue.capacity">容量 {{ venue.capacity }}</span>
                    <span v-for="facility in venueFacilities(venue).slice(0, 2)" :key="facility">{{ facility }}</span>
                  </div>
                </div>
              </article>
            </div>
          </section>

          <section class="spot-section">
            <h2>游览须知</h2>
            <ul class="spot-notice-list">
              <li v-for="item in spotDetailMock.notices" :key="item">{{ item }}</li>
            </ul>
          </section>

          <section class="spot-section">
            <div class="spot-section__head">
              <h2>周边景区</h2>
              <button type="button">
                查看更多
                <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                </svg>
              </button>
            </div>
            <div class="spot-nearby-grid">
              <article v-for="item in spotDetailMock.nearbySpots" :key="item.name">
                <h3>{{ item.name }}</h3>
                <p>
                  <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
                  </svg>
                  {{ item.distance }}
                </p>
                <p>
                  <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  {{ item.duration }}
                </p>
              </article>
            </div>
          </section>
        </div>

        <aside class="spot-sidebar">
          <section class="spot-info-card">
            <h2>基本信息</h2>
            <div class="spot-info-list">
              <article v-for="item in basicInfo" :key="item.label">
                <span>{{ item.label }}</span>
                <strong>{{ item.value }}</strong>
              </article>
            </div>
            <div class="spot-map-placeholder">
              <svg class="h-12 w-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
              <span>{{ spotDetailMock.map.title }}</span>
            </div>
            <button type="button" class="spot-map-button">
              <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
              </svg>
              {{ spotDetailMock.map.navigationText }}
            </button>
          </section>
        </aside>
      </section>
    </template>

    <BackToTop />
  </main>
</template>

<style scoped>
.spot-detail {
  color: var(--brand);
}

.spot-container {
  width: min(100%, 1280px);
  margin: 0 auto;
  padding-inline: 24px;
}

.spot-backbar {
  border-bottom: 1px solid rgba(223, 223, 223, 0.82);
  background: #f8f8f7;
}

.spot-backlink {
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

.spot-backlink:hover {
  color: var(--brand);
}

.spot-hero-detail {
  position: relative;
  overflow: hidden;
  background:
    linear-gradient(115deg, rgba(0, 83, 66, 0.9) 0%, rgba(186, 211, 203, 0.84) 52%, rgba(8, 18, 36, 0.98) 100%),
    var(--dark);
  background-position: center;
  background-size: cover;
}

.spot-hero-detail__pattern {
  position: absolute;
  inset: 0;
  opacity: 0.08;
  background-image:
    radial-gradient(circle at 0 0, transparent 0 35px, #ffffff 36px, transparent 37px),
    radial-gradient(circle at 56px 56px, transparent 0 35px, #ffffff 36px, transparent 37px);
  background-size: 112px 112px;
}

.spot-hero-detail__inner {
  position: relative;
  z-index: 1;
  padding-block: 66px 70px;
}

.spot-tags {
  display: flex;
  max-width: 760px;
  flex-wrap: wrap;
  gap: 14px;
}

.spot-tags span {
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

.spot-tags span:first-child {
  border-color: transparent;
  background: #009766;
  color: #ffffff;
}

.spot-hero-detail h1 {
  max-width: 940px;
  margin-top: 32px;
  color: #ffffff;
  font-family: 'Montserrat', sans-serif;
  font-size: 62px;
  font-weight: 600;
  line-height: 1.08;
}

.spot-hero-detail__meta {
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
  margin-top: 24px;
  color: rgba(255, 255, 255, 0.74);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
}

.spot-hero-detail__meta span {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.spot-hero-detail__summary {
  max-width: 760px;
  margin-top: 26px;
  color: rgba(255, 255, 255, 0.7);
  font-family: 'Manrope', sans-serif;
  font-size: 20px;
  line-height: 1.7;
}

.spot-hero-facts {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
  max-width: 1080px;
  margin-top: 44px;
}

.spot-hero-facts article {
  display: flex;
  min-height: 86px;
  align-items: center;
  gap: 18px;
  border: 1px solid rgba(255, 255, 255, 0.14);
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.08);
  padding: 18px;
}

.spot-hero-facts__icon {
  display: inline-flex;
  color: #54e5b5;
}

.spot-hero-facts p {
  color: rgba(255, 255, 255, 0.54);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.spot-hero-facts strong {
  display: block;
  margin-top: 7px;
  color: #ffffff;
  font-family: 'Manrope', sans-serif;
  font-size: 20px;
  font-weight: 700;
}

.spot-hero-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 40px;
}

.spot-hero-actions button,
.spot-map-button {
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

.spot-hero-actions button:hover,
.spot-map-button:hover {
  transform: translateY(-1px);
}

.spot-hero-actions .is-primary {
  border-color: #ffffff;
  background: #ffffff;
  color: var(--brand);
}

.spot-content {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 360px;
  gap: 42px;
  padding-block: 70px;
}

.spot-main {
  min-width: 0;
}

.spot-section {
  border-bottom: 1px solid var(--border);
  padding-bottom: 48px;
  margin-bottom: 48px;
}

.spot-section:last-child {
  border-bottom: 0;
  margin-bottom: 0;
}

.spot-section h2,
.spot-info-card h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 32px;
  font-weight: 500;
  line-height: 1.25;
}

.spot-intro {
  margin-top: 34px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 18px;
  line-height: 2;
  white-space: pre-line;
}

.spot-highlight-list {
  display: grid;
  gap: 16px;
  margin-top: 34px;
}

.spot-highlight-list article {
  display: flex;
  min-height: 66px;
  align-items: center;
  gap: 18px;
  border: 1px solid var(--border);
  border-radius: 18px;
  background: #fafafa;
  padding: 15px 22px;
}

.spot-highlight-list span {
  display: inline-flex;
  flex: none;
  width: 34px;
  height: 34px;
  align-items: center;
  justify-content: center;
  border-radius: 999px;
  background: rgba(0, 151, 102, 0.1);
  color: #00855e;
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  font-weight: 700;
}

.spot-highlight-list p,
.spot-transport-list p,
.spot-notice-list,
.spot-nearby-grid p,
.spot-info-list strong,
.spot-venue-card p {
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 16px;
  line-height: 1.7;
}

.spot-transport-list {
  display: grid;
  gap: 18px;
  margin-top: 34px;
}

.spot-transport-list article {
  display: grid;
  grid-template-columns: 28px minmax(0, 1fr);
  gap: 18px;
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 22px;
}

.spot-transport-list svg,
.spot-nearby-grid svg {
  color: #707083;
}

.spot-transport-list h3,
.spot-nearby-grid h3,
.spot-venue-card h3 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 18px;
  font-weight: 600;
}

.spot-section__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
}

.spot-section__head span,
.spot-section__head button {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.spot-venue-grid {
  display: grid;
  gap: 18px;
  margin-top: 34px;
}

.spot-venue-card {
  display: grid;
  grid-template-columns: 168px minmax(0, 1fr);
  overflow: hidden;
  border: 1px solid var(--border);
  border-radius: 18px;
  background: #ffffff;
}

.spot-venue-card__image {
  display: flex;
  min-height: 150px;
  align-items: center;
  justify-content: center;
  background: rgba(16, 86, 112, 0.08);
  color: rgba(100, 137, 146, 0.38);
}

.spot-venue-card__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.spot-venue-card__body {
  padding: 24px;
}

.spot-venue-card__desc {
  display: -webkit-box;
  margin-top: 10px;
  overflow: hidden;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
}

.spot-venue-card__meta {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 16px;
}

.spot-venue-card__meta span {
  border: 1px solid rgba(0, 151, 102, 0.18);
  border-radius: 999px;
  background: rgba(0, 151, 102, 0.08);
  padding: 4px 10px;
  color: #007c59;
  font-family: 'Manrope', sans-serif;
  font-size: 13px;
}

.spot-notice-list {
  display: grid;
  gap: 18px;
  margin-top: 34px;
  padding-left: 18px;
}

.spot-notice-list li {
  padding-left: 6px;
}

.spot-nearby-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
  margin-top: 34px;
}

.spot-nearby-grid article {
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 24px;
}

.spot-nearby-grid p {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 12px;
}

.spot-sidebar {
  align-self: start;
  position: sticky;
  top: 100px;
}

.spot-info-card {
  border: 1px solid var(--border);
  border-radius: 22px;
  background: #ffffff;
  padding: 28px;
  box-shadow: 0 18px 42px rgba(9, 44, 56, 0.06);
}

.spot-info-list {
  display: grid;
  gap: 18px;
  margin-top: 26px;
  border-bottom: 1px solid var(--border);
  padding-bottom: 24px;
}

.spot-info-list article {
  display: grid;
  gap: 6px;
}

.spot-info-list span {
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.spot-info-list strong {
  color: var(--brand);
  font-weight: 500;
}

.spot-map-placeholder {
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

.spot-map-button {
  width: 100%;
  margin-top: 18px;
  border-color: var(--brand);
  background: #02000f;
  color: #ffffff;
}

@media (max-width: 1120px) {
  .spot-hero-facts,
  .spot-content,
  .spot-nearby-grid {
    grid-template-columns: 1fr 1fr;
  }

  .spot-sidebar {
    position: static;
  }
}

@media (max-width: 767px) {
  .spot-container {
    padding-inline: 18px;
  }

  .spot-backlink {
    min-height: 68px;
  }

  .spot-hero-detail__inner {
    padding-block: 42px 46px;
  }

  .spot-hero-detail h1 {
    font-size: 42px;
  }

  .spot-hero-detail__summary {
    font-size: 17px;
  }

  .spot-hero-facts,
  .spot-content,
  .spot-nearby-grid,
  .spot-venue-card {
    grid-template-columns: 1fr;
  }

  .spot-section h2,
  .spot-info-card h2 {
    font-size: 28px;
  }

  .spot-content {
    padding-block: 44px;
  }
}
</style>
