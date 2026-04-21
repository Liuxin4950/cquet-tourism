<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { RouterLink } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import StateBlock from '@/components/channel/StateBlock.vue'
import PaginationBar from '@/components/channel/PaginationBar.vue'
import { useVenueStore } from '@/stores/venue'
import type { Venue } from '@/api/venue'

type SortType = 'recommended' | 'nameAsc' | 'capacityDesc'

const store = useVenueStore()
const page = ref(1)
const pageSize = ref(4)
const searchKeyword = ref('')
const selectedCategory = ref('')
const sortType = ref<SortType>('recommended')

const buildQuery = (targetPage = page.value) => {
  const keyword = searchKeyword.value.trim()
  const isAreaKeyword = /市|区|县|镇|街|路/.test(keyword)

  return {
    pageNum: targetPage,
    pageSize: pageSize.value,
    name: keyword && !isAreaKeyword ? keyword : undefined,
    city: keyword && isAreaKeyword ? keyword : undefined,
  }
}

onMounted(() => {
  store.fetchVenues(buildQuery())
})

const handleSearch = () => {
  page.value = 1
  store.fetchVenues(buildQuery(1))
}

const handleReset = () => {
  searchKeyword.value = ''
  selectedCategory.value = ''
  sortType.value = 'recommended'
  page.value = 1
  store.fetchVenues(buildQuery(1))
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchVenues(buildQuery(p))
}

const handleRetry = () => {
  store.fetchVenues(buildQuery())
}

const totalPages = computed(() => Math.ceil(store.total / pageSize.value))
const venues = computed<Venue[]>(() => store.venues as Venue[])

const categoryOptions = computed(() => {
  const categories = new Set<string>()
  venues.value.forEach(venue => {
    const category = venue.type || venue.category
    if (category) categories.add(category)
  })
  return [{ label: '全部类型', value: '' }, ...Array.from(categories).map(item => ({ label: item, value: item }))]
})

const displayVenues = computed(() => {
  const keyword = searchKeyword.value.trim()
  const source = keyword && /市|区|县|镇|街|路/.test(keyword)
    ? venues.value.filter(venue => {
      const areaText = `${venue.city || ''}${venue.district || ''}${venue.address || ''}`
      return areaText.includes(keyword)
    })
    : venues.value

  return source
    .filter(venue => !selectedCategory.value || (venue.type || venue.category) === selectedCategory.value)
    .slice()
    .sort((a, b) => {
      if (sortType.value === 'nameAsc') {
        return (a.name || '').localeCompare(b.name || '', 'zh-Hans-CN')
      }
      if (sortType.value === 'capacityDesc') {
        return (Number(b.capacity) || 0) - (Number(a.capacity) || 0)
      }
      return 0
    })
})

const venueArea = (venue: Venue) => {
  if (venue.district) return venue.city ? `${venue.city}-${venue.district}` : venue.district
  if (venue.city) return venue.city
  if (venue.address) return venue.address
  return '重庆'
}

const venueCategory = (venue: Venue) => venue.type || venue.category || '文化场馆'
const venueDescription = (venue: Venue) => venue.description || '暂无场馆介绍'
const coverImage = (venue: Venue) => venue.images?.[0] || ''

const formatTicket = (value?: string | number) => {
  if (value === undefined || value === null || value === '') return '票价待更新'
  const numericValue = Number(value)
  if (!Number.isNaN(numericValue)) return numericValue <= 0 ? '免费开放' : `${numericValue}元起`
  return String(value)
}

const formatCapacity = (value?: number) => {
  if (value === undefined || value === null || Number(value) <= 0) return '容量待更新'
  return `${value} 人`
}

const bookingText = (venue: Venue) => {
  if (venue.bookingRequired === '1') return '需预约'
  if (venue.bookingRequired === '0') return '免预约'
  return '预约待更新'
}
</script>

<template>
  <main class="min-h-screen bg-white pt-[72px]">
    <NavBar />

    <section class="venue-hero">
      <div class="venue-hero__texture" aria-hidden="true"></div>
      <div class="venue-hero__shade" aria-hidden="true"></div>
      <div class="venue-hero__inner">
        <div>
          <p class="venue-eyebrow">
            <svg class="h-4 w-4 text-emerald-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
            </svg>
            CHONGQING VENUES
          </p>
          <h1>重庆场馆</h1>
          <p class="venue-hero__subtitle">浏览城市文化、教育、体育与公共服务空间</p>
        </div>

        <div class="venue-stats">
          <div>
            <strong>{{ store.total || 0 }}</strong>
            <span>个场馆</span>
          </div>
          <i></i>
          <div>
            <strong>{{ displayVenues.length }}</strong>
            <span>当前结果</span>
          </div>
        </div>
      </div>
    </section>

    <section class="mx-auto max-w-[1280px] px-6 pb-16 lg:px-10">
      <section class="venue-toolbar">
        <div class="venue-toolbar__row">
          <form class="venue-search" @submit.prevent="handleSearch">
            <svg class="h-6 w-6 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M21 21l-4.35-4.35m1.1-5.4a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" />
            </svg>
            <input
              v-model="searchKeyword"
              type="search"
              placeholder="搜索场馆名称或区域..."
            />
          </form>

          <select
            v-model="selectedCategory"
            class="venue-select"
          >
            <option v-for="item in categoryOptions" :key="item.value" :value="item.value">
              {{ item.label }}
            </option>
          </select>

          <select v-model="sortType" class="venue-select">
            <option value="recommended">综合推荐</option>
            <option value="nameAsc">名称排序</option>
            <option value="capacityDesc">容量优先</option>
          </select>
        </div>

        <p class="venue-toolbar__meta">
          找到 <span>{{ displayVenues.length }}</span> 个结果
          <button type="button" @click="handleSearch">预览状态</button>
          <button v-if="searchKeyword || selectedCategory || sortType !== 'recommended'" type="button" @click="handleReset">清除筛选</button>
        </p>
      </section>

      <div class="mt-8">
        <StateBlock
          v-if="store.isLoading"
          type="loading"
        />

        <StateBlock
          v-else-if="store.error"
          type="error"
          title="场馆加载失败"
          description="网络异常或数据暂不可用，请稍后重试。"
          action-text="重新加载"
          @action="handleRetry"
        />

        <StateBlock
          v-else-if="displayVenues.length === 0"
          type="empty"
          title="暂时没有符合条件的场馆"
          description="你可以调整关键词或类型筛选，重新浏览场馆内容。"
          action-text="查看全部场馆"
          @action="handleReset"
        />

        <div v-else class="venue-grid">
          <article
            v-for="venue in displayVenues"
            :key="venue.id"
            class="venue-card"
          >
            <div class="venue-card__image">
              <img
                v-if="coverImage(venue)"
                :src="coverImage(venue)"
                :alt="venue.name"
                loading="lazy"
              />
              <div v-else class="venue-card__placeholder">
                <svg class="h-14 w-14" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
                </svg>
              </div>
              <span class="venue-type">{{ venueCategory(venue) }}</span>
            </div>

            <div class="venue-card__body">
              <div class="venue-card__top">
                <div>
                  <h2>{{ venue.name }}</h2>
                  <p class="venue-card__area">
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                    </svg>
                    {{ venueArea(venue) }}
                  </p>
                </div>
                <span class="venue-capacity">{{ formatCapacity(venue.capacity) }}</span>
              </div>

              <p class="venue-card__desc">{{ venueDescription(venue) }}</p>

              <div class="venue-chips">
                <span>{{ venueCategory(venue) }}</span>
                <span>{{ bookingText(venue) }}</span>
                <span>{{ formatTicket(venue.ticketPrice) }}</span>
              </div>

              <div class="venue-card__footer">
                <div class="venue-card__facts">
                  <span>
                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    {{ venue.openingHours || venue.openHours || '开放时间待更新' }}
                  </span>
                  <span>
                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v12m4.5-9.75h-6.75a2.25 2.25 0 000 4.5h4.5a2.25 2.25 0 010 4.5H7.5" />
                    </svg>
                    {{ formatTicket(venue.ticketPrice) }}
                  </span>
                </div>

                <RouterLink :to="`/venues/${venue.id}`" class="venue-detail-link">
                  查看详情
                  <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
                  </svg>
                </RouterLink>
              </div>
            </div>
          </article>
        </div>

        <PaginationBar
          :page="page"
          :total-pages="totalPages"
          show-single-page
          @change="handlePageChange"
        />
      </div>
    </section>

    <BackToTop />
  </main>
</template>

<style scoped>
.venue-hero {
  position: relative;
  width: 100%;
  overflow: hidden;
  background:
    linear-gradient(116deg, rgba(4, 95, 76, 0.94) 0%, rgba(196, 219, 211, 0.82) 47%, rgba(9, 21, 42, 0.96) 100%),
    var(--dark);
}

.venue-hero__texture {
  position: absolute;
  inset: 0;
  opacity: 0.1;
  background-image:
    linear-gradient(90deg, rgba(255, 255, 255, 0.18) 1px, transparent 1px),
    linear-gradient(180deg, rgba(255, 255, 255, 0.12) 1px, transparent 1px);
  background-size: 88px 88px;
}

.venue-hero__shade {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.08) 0%, rgba(9, 44, 56, 0) 40%, rgba(9, 44, 56, 0.28) 100%);
}

.venue-hero__inner {
  position: relative;
  z-index: 1;
  display: grid;
  min-height: 300px;
  max-width: 1280px;
  margin: 0 auto;
  gap: 36px;
  padding: 62px 24px 56px;
}

.venue-eyebrow {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  padding: 10px 18px;
  color: rgba(255, 255, 255, 0.78);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
  letter-spacing: 0.12em;
}

.venue-hero h1 {
  margin-top: 26px;
  color: #ffffff;
  font-family: 'Montserrat', sans-serif;
  font-size: 58px;
  font-weight: 600;
  line-height: 1;
}

.venue-hero__subtitle {
  margin-top: 20px;
  color: rgba(255, 255, 255, 0.7);
  font-family: 'Manrope', sans-serif;
  font-size: 18px;
}

.venue-stats {
  display: flex;
  align-items: center;
  gap: 28px;
  align-self: end;
  justify-self: end;
  color: #ffffff;
}

.venue-stats div {
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.venue-stats strong {
  font-family: 'Montserrat', sans-serif;
  font-size: 42px;
  font-weight: 500;
  line-height: 1;
}

.venue-stats span {
  color: rgba(255, 255, 255, 0.74);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.venue-stats i {
  display: block;
  width: 1px;
  height: 44px;
  background: rgba(255, 255, 255, 0.28);
}

.venue-toolbar {
  margin-top: 40px;
  position: relative;
  z-index: 2;
  border: 1px solid var(--border);
  border-radius: 24px;
  background: #ffffff;
  padding: 24px;
  box-shadow: 0 16px 38px rgba(9, 44, 56, 0.1);
}

.venue-toolbar__row {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 170px 170px;
  gap: 18px;
}

.venue-search {
  display: flex;
  min-height: 54px;
  align-items: center;
  gap: 14px;
  border: 1px solid var(--border);
  border-radius: 16px;
  background: var(--light);
  padding: 0 18px;
}

.venue-search input {
  min-width: 0;
  width: 100%;
  background: transparent;
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  outline: none;
}

.venue-search input::placeholder {
  color: var(--muted);
}

.venue-select {
  min-height: 54px;
  border: 1px solid var(--border);
  border-radius: 16px;
  background: var(--light);
  padding: 0 18px;
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  outline: none;
}

.venue-toolbar__meta {
  margin-top: 18px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.venue-toolbar__meta span {
  color: var(--brand);
}

.venue-toolbar__meta button {
  margin-left: 12px;
  color: var(--accent);
}

.venue-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 24px;
}

.venue-card {
  display: grid;
  grid-template-columns: 36% minmax(0, 1fr);
  overflow: hidden;
  border: 1px solid var(--border);
  border-radius: 20px;
  background: #ffffff;
  min-height: 240px;
  transition: border-color 0.25s ease, box-shadow 0.25s ease, transform 0.25s ease;
}

.venue-card:hover {
  border-color: rgba(16, 86, 112, 0.42);
  box-shadow: 0 14px 34px rgba(9, 44, 56, 0.08);
  transform: translateY(-2px);
}

.venue-card__image {
  position: relative;
  min-height: 100%;
  background: rgba(16, 86, 112, 0.08);
}

.venue-card__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.venue-card__placeholder {
  display: flex;
  height: 100%;
  min-height: 240px;
  align-items: center;
  justify-content: center;
  color: rgba(100, 137, 146, 0.28);
}

.venue-type {
  position: absolute;
  top: 18px;
  left: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  max-width: calc(100% - 36px);
  min-height: 34px;
  border-radius: 13px;
  background: #009766;
  color: #ffffff;
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
  font-weight: 600;
  padding: 0 12px;
}

.venue-card__body {
  display: flex;
  min-width: 0;
  flex-direction: column;
  padding: 28px 28px 22px;
}

.venue-card__top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 18px;
}

.venue-card__top h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 23px;
  font-weight: 600;
  line-height: 1.25;
}

.venue-card__area {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 10px;
  margin-top: 12px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.venue-capacity {
  display: inline-flex;
  flex: none;
  align-items: center;
  border: 1px solid rgba(244, 158, 11, 0.25);
  border-radius: 12px;
  background: rgba(244, 158, 11, 0.1);
  padding: 8px 12px;
  color: #d97706;
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  font-weight: 600;
}

.venue-card__desc {
  margin-top: 18px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  line-height: 1.75;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.venue-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 9px;
  margin-top: 18px;
}

.venue-chips span {
  display: inline-flex;
  align-items: center;
  min-height: 28px;
  border: 1px solid rgba(0, 151, 102, 0.18);
  border-radius: 10px;
  background: rgba(0, 151, 102, 0.08);
  padding: 0 12px;
  color: #007c59;
  font-family: 'Manrope', sans-serif;
  font-size: 13px;
}

.venue-card__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  margin-top: auto;
  border-top: 1px solid var(--border);
  padding-top: 20px;
}

.venue-card__facts {
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
}

.venue-card__facts span {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.venue-detail-link {
  display: inline-flex;
  flex: none;
  align-items: center;
  gap: 10px;
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  text-decoration: none;
  transition: color 0.25s ease;
}

.venue-detail-link:hover {
  color: var(--accent);
}

@media (min-width: 1024px) {
  .venue-hero__inner {
    grid-template-columns: minmax(0, 1fr) 360px;
    padding: 68px 40px 66px;
  }
}

@media (max-width: 1023px) {
  .venue-stats {
    justify-self: start;
  }

  .venue-toolbar__row,
  .venue-grid,
  .venue-card {
    grid-template-columns: 1fr;
  }

  .venue-card__image,
  .venue-card__placeholder {
    min-height: 220px;
  }
}

@media (max-width: 767px) {
  .venue-hero h1 {
    font-size: 42px;
  }

  .venue-stats {
    align-items: flex-start;
    flex-direction: column;
    gap: 14px;
  }

  .venue-stats i {
    display: none;
  }

  .venue-toolbar {
    padding: 18px;
  }

  .venue-card__body {
    padding: 24px;
  }
}
</style>
