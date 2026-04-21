<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { RouterLink } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import StateBlock from '@/components/channel/StateBlock.vue'
import PaginationBar from '@/components/channel/PaginationBar.vue'
import { useScenicSpotStore } from '@/stores/scenicSpot'
import { spotListMock } from '@/mocks/spotListMock'
import type { ScenicSpot } from '@/api/scenicSpot'

type SortType = 'recommended' | 'nameAsc' | 'levelDesc'

const store = useScenicSpotStore()
const page = ref(1)
const pageSize = ref(4)
const searchKeyword = ref('')
const selectedLevel = ref('')
const sortType = ref<SortType>('recommended')

const buildQuery = (targetPage = page.value) => {
  const keyword = searchKeyword.value.trim()
  const isAreaKeyword = /市|区|县|镇|街|路/.test(keyword)

  return {
    pageNum: targetPage,
    pageSize: pageSize.value,
    name: keyword && !isAreaKeyword ? keyword : undefined,
    city: keyword && isAreaKeyword ? keyword : undefined,
    level: selectedLevel.value || undefined,
  }
}

onMounted(() => {
  store.fetchSpots(buildQuery())
})

const handleSearch = () => {
  page.value = 1
  store.fetchSpots(buildQuery(1))
}

const handleReset = () => {
  searchKeyword.value = ''
  selectedLevel.value = ''
  sortType.value = 'recommended'
  page.value = 1
  store.fetchSpots(buildQuery(1))
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchSpots(buildQuery(p))
}

const handleRetry = () => {
  store.fetchSpots(buildQuery())
}

const totalPages = computed(() => Math.ceil(store.total / pageSize.value))

const spots = computed<ScenicSpot[]>(() => store.spots as ScenicSpot[])

const displaySpots = computed(() => {
  const keyword = searchKeyword.value.trim()
  const source = keyword && /市|区|县|镇|街|路/.test(keyword)
    ? spots.value.filter(spot => {
      const areaText = `${spot.city || ''}${spot.district || ''}${spot.address || ''}`
      return areaText.includes(keyword)
    })
    : spots.value

  return [...source].sort((a, b) => {
    if (sortType.value === 'nameAsc') {
      return (a.name || '').localeCompare(b.name || '', 'zh-Hans-CN')
    }
    if (sortType.value === 'levelDesc') {
      return levelWeight(b.level) - levelWeight(a.level)
    }
    return 0
  })
})

const levelWeight = (level?: string) => {
  const normalized = normalizeLevel(level)
  const value = Number(normalized.replace('A', ''))
  return Number.isNaN(value) ? 0 : value
}

const normalizeLevel = (level?: string) => {
  if (!level) return '景区'
  const trimmed = level.trim().toUpperCase()
  if (/^\dA$/.test(trimmed)) return trimmed
  const count = (trimmed.match(/A/g) || []).length
  return count > 0 ? `${count}A` : trimmed
}

const cardMock = (spot: ScenicSpot, index: number) => {
  const numericId = Number(spot.id) || index
  return spotListMock.cards[numericId % spotListMock.cards.length]
}

const spotArea = (spot: ScenicSpot) => {
  if (spot.district) return spot.city ? `${spot.city}-${spot.district}` : spot.district
  if (spot.city) return spot.city
  if (spot.address) return spot.address
  return '重庆'
}

const spotDescription = (spot: ScenicSpot) => {
  return spot.description || spotListMock.fallbackDescription
}

const coverImage = (spot: ScenicSpot) => {
  return spot.images?.[0] || ''
}
</script>

<template>
  <main class="min-h-screen bg-white pt-[72px]">
    <NavBar />

    <section class="spot-hero">
      <div class="spot-hero__texture" aria-hidden="true"></div>
      <div class="spot-hero__shade" aria-hidden="true"></div>
      <div class="spot-hero__inner">
        <div>
          <p class="spot-eyebrow">
            <svg class="h-4 w-4 text-emerald-200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
            </svg>
            CHONGQING ATTRACTIONS
          </p>
          <h1>重庆景区</h1>
          <p class="spot-hero__subtitle">探索山城的自然与人文景观</p>
        </div>

        <div class="spot-stats">
          <div>
            <strong>{{ store.total || 0 }}</strong>
            <span>个景区</span>
          </div>
          <i></i>
          <div>
            <strong>{{ displaySpots.length }}</strong>
            <span>当前结果</span>
          </div>
        </div>
      </div>
    </section>

    <section class="mx-auto max-w-[1280px] px-6 pb-16 lg:px-10">
      <section class="spot-toolbar">
        <div class="spot-toolbar__row">
          <form class="spot-search" @submit.prevent="handleSearch">
            <svg class="h-6 w-6 text-muted" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M21 21l-4.35-4.35m1.1-5.4a6.5 6.5 0 11-13 0 6.5 6.5 0 0113 0z" />
            </svg>
            <input
              v-model="searchKeyword"
              type="search"
              placeholder="搜索景区名称或区域..."
            />
          </form>

          <select
            v-model="selectedLevel"
            class="spot-select"
            @change="handleSearch"
          >
            <option v-for="item in spotListMock.typeOptions" :key="item.value" :value="item.value">
              {{ item.label }}
            </option>
          </select>

          <select v-model="sortType" class="spot-select">
            <option v-for="item in spotListMock.sortOptions" :key="item.value" :value="item.value">
              {{ item.label }}
            </option>
          </select>
        </div>

        <p class="spot-toolbar__meta">
          找到 <span>{{ displaySpots.length }}</span> 个结果
          <button type="button" @click="handleSearch">预览状态</button>
          <button v-if="searchKeyword || selectedLevel || sortType !== 'recommended'" type="button" @click="handleReset">清除筛选</button>
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
          title="景区加载失败"
          description="网络异常或数据暂不可用，请稍后重试。"
          action-text="重新加载"
          @action="handleRetry"
        />

        <StateBlock
          v-else-if="displaySpots.length === 0"
          type="empty"
          title="暂时没有符合条件的景区"
          description="你可以调整关键词或等级筛选，重新浏览景区内容。"
          action-text="查看全部景区"
          @action="handleReset"
        />

        <div v-else class="spot-grid">
          <article
            v-for="(spot, index) in displaySpots"
            :key="spot.id"
            class="spot-card"
          >
            <div class="spot-card__image">
              <img
                v-if="coverImage(spot)"
                :src="coverImage(spot)"
                :alt="spot.name"
                loading="lazy"
              />
              <div v-else class="spot-card__placeholder">
                <svg class="h-14 w-14" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                </svg>
              </div>
              <span class="spot-level">{{ normalizeLevel(spot.level) }}</span>
            </div>

            <div class="spot-card__body">
              <div class="spot-card__top">
                <div>
                  <h2>{{ spot.name }}</h2>
                  <p class="spot-card__area">
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M19.5 10.5c0 7.5-7.5 10.5-7.5 10.5S4.5 18 4.5 10.5a7.5 7.5 0 1115 0z" />
                    </svg>
                    {{ spotArea(spot) }}
                    <span>·</span>
                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M9.568 3H5.25A2.25 2.25 0 003 5.25v4.318c0 .597.237 1.169.659 1.591l8.682 8.682a2.25 2.25 0 003.182 0l4.318-4.318a2.25 2.25 0 000-3.182L11.159 3.659A2.25 2.25 0 009.568 3z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6.75 6.75h.008v.008H6.75z" />
                    </svg>
                    {{ cardMock(spot, index).category }}
                  </p>
                </div>
                <span class="spot-rating">
                  <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.801 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.538 1.118l-2.8-2.034a1 1 0 00-1.176 0l-2.8 2.034c-.783.57-1.838-.197-1.538-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81H7.03a1 1 0 00.95-.69l1.07-3.292z" />
                  </svg>
                  {{ cardMock(spot, index).rating }}
                </span>
              </div>

              <p class="spot-card__desc">{{ spotDescription(spot) }}</p>

              <div class="spot-chips">
                <span v-for="chip in cardMock(spot, index).chips" :key="chip">{{ chip }}</span>
              </div>

              <div class="spot-card__footer">
                <div class="spot-card__facts">
                  <span>
                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M12 6v6l4 2m5-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    {{ cardMock(spot, index).duration }}
                  </span>
                  <span>
                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.7" d="M6 12L3.27 3.12 21 12 3.27 20.88 6 12zm0 0h7.5" />
                    </svg>
                    {{ cardMock(spot, index).distance }}
                  </span>
                </div>

                <RouterLink :to="`/spots/${spot.id}`" class="spot-detail-link">
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
.spot-hero {
  position: relative;
  width: 100%;
  overflow: hidden;
  background:
    linear-gradient(116deg, rgba(4, 95, 76, 0.94) 0%, rgba(196, 219, 211, 0.82) 47%, rgba(9, 21, 42, 0.96) 100%),
    var(--dark);
}

.spot-hero__texture {
  position: absolute;
  inset: 0;
  opacity: 0.1;
  background-image:
    linear-gradient(90deg, rgba(255, 255, 255, 0.18) 1px, transparent 1px),
    linear-gradient(180deg, rgba(255, 255, 255, 0.12) 1px, transparent 1px);
  background-size: 88px 88px;
}

.spot-hero__shade {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.08) 0%, rgba(9, 44, 56, 0) 40%, rgba(9, 44, 56, 0.28) 100%);
}

.spot-hero__inner {
  position: relative;
  z-index: 1;
  display: grid;
  min-height: 300px;
  max-width: 1280px;
  margin: 0 auto;
  gap: 36px;
  padding: 62px 24px 56px;
}

.spot-eyebrow {
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

.spot-hero h1 {
  margin-top: 26px;
  color: #ffffff;
  font-family: 'Montserrat', sans-serif;
  font-size: 58px;
  font-weight: 600;
  line-height: 1;
}

.spot-hero__subtitle {
  margin-top: 20px;
  color: rgba(255, 255, 255, 0.7);
  font-family: 'Manrope', sans-serif;
  font-size: 18px;
}

.spot-stats {
  display: flex;
  align-items: center;
  gap: 28px;
  align-self: end;
  justify-self: end;
  color: #ffffff;
}

.spot-stats div {
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.spot-stats strong {
  font-family: 'Montserrat', sans-serif;
  font-size: 42px;
  font-weight: 500;
  line-height: 1;
}

.spot-stats span {
  color: rgba(255, 255, 255, 0.74);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.spot-stats i {
  display: block;
  width: 1px;
  height: 44px;
  background: rgba(255, 255, 255, 0.28);
}

.spot-toolbar {
  margin-top: 40px;
  position: relative;
  z-index: 2;
  border: 1px solid var(--border);
  border-radius: 24px;
  background: #ffffff;
  padding: 24px;
  box-shadow: 0 16px 38px rgba(9, 44, 56, 0.1);
}

.spot-toolbar__row {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 170px 170px;
  gap: 18px;
}

.spot-search {
  display: flex;
  min-height: 54px;
  align-items: center;
  gap: 14px;
  border: 1px solid var(--border);
  border-radius: 16px;
  background: var(--light);
  padding: 0 18px;
}

.spot-search input {
  min-width: 0;
  width: 100%;
  background: transparent;
  color: var(--brand);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  outline: none;
}

.spot-search input::placeholder {
  color: var(--muted);
}

.spot-select {
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

.spot-toolbar__meta {
  margin-top: 18px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.spot-toolbar__meta span {
  color: var(--brand);
}

.spot-toolbar__meta button {
  margin-left: 12px;
  color: var(--accent);
}

.spot-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 24px;
}

.spot-card {
  display: grid;
  grid-template-columns: 36% minmax(0, 1fr);
  overflow: hidden;
  border: 1px solid var(--border);
  border-radius: 20px;
  background: #ffffff;
  min-height: 240px;
  transition: border-color 0.25s ease, box-shadow 0.25s ease, transform 0.25s ease;
}

.spot-card:hover {
  border-color: rgba(16, 86, 112, 0.42);
  box-shadow: 0 14px 34px rgba(9, 44, 56, 0.08);
  transform: translateY(-2px);
}

.spot-card__image {
  position: relative;
  min-height: 100%;
  background: rgba(16, 86, 112, 0.08);
}

.spot-card__image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.spot-card__placeholder {
  display: flex;
  height: 100%;
  min-height: 240px;
  align-items: center;
  justify-content: center;
  color: rgba(100, 137, 146, 0.28);
}

.spot-level {
  position: absolute;
  top: 18px;
  left: 18px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 42px;
  height: 34px;
  border-radius: 13px;
  background: #009766;
  color: #ffffff;
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  font-weight: 600;
}

.spot-card__body {
  display: flex;
  min-width: 0;
  flex-direction: column;
  padding: 28px 28px 22px;
}

.spot-card__top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 18px;
}

.spot-card__top h2 {
  color: var(--brand);
  font-family: 'Montserrat', sans-serif;
  font-size: 23px;
  font-weight: 600;
  line-height: 1.25;
}

.spot-card__area {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 10px;
  margin-top: 12px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
}

.spot-rating {
  display: inline-flex;
  flex: none;
  align-items: center;
  gap: 6px;
  border: 1px solid rgba(244, 158, 11, 0.25);
  border-radius: 12px;
  background: rgba(244, 158, 11, 0.1);
  padding: 8px 12px;
  color: #d97706;
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
  font-weight: 600;
}

.spot-card__desc {
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

.spot-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 9px;
  margin-top: 18px;
}

.spot-chips span {
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

.spot-card__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  margin-top: auto;
  border-top: 1px solid var(--border);
  padding-top: 20px;
}

.spot-card__facts {
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
}

.spot-card__facts span {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: var(--muted);
  font-family: 'Manrope', sans-serif;
  font-size: 15px;
}

.spot-detail-link {
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

.spot-detail-link:hover {
  color: var(--accent);
}

@media (min-width: 1024px) {
  .spot-hero__inner {
    grid-template-columns: minmax(0, 1fr) 360px;
    padding: 68px 40px 66px;
  }
}

@media (max-width: 1023px) {
  .spot-stats {
    justify-self: start;
  }

  .spot-toolbar__row,
  .spot-grid,
  .spot-card {
    grid-template-columns: 1fr;
  }

  .spot-card__image,
  .spot-card__placeholder {
    min-height: 220px;
  }
}

@media (max-width: 767px) {
  .spot-hero h1 {
    font-size: 42px;
  }

  .spot-stats {
    align-items: flex-start;
    flex-direction: column;
    gap: 14px;
  }

  .spot-stats i {
    display: none;
  }

  .spot-toolbar {
    padding: 18px;
  }

  .spot-card__body {
    padding: 24px;
  }
}
</style>
