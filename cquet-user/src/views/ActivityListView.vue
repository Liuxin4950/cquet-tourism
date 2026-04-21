<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import NavBar from '@/components/layout/NavBar.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import ChannelIntro from '@/components/channel/ChannelIntro.vue'
import ChannelPageShell from '@/components/channel/ChannelPageShell.vue'
import PageToolbar from '@/components/channel/PageToolbar.vue'
import PaginationBar from '@/components/channel/PaginationBar.vue'
import StateBlock from '@/components/channel/StateBlock.vue'
import ActivityScheduleCard, { type ScheduleActivity } from '@/components/cards/ActivityScheduleCard.vue'
import { useActivityStore } from '@/stores/activity'

type SortType = 'timeAsc' | 'timeDesc' | 'nameAsc'
interface VenueFilterOption {
  id: number
  name: string
}

const store = useActivityStore()
const page = ref(1)
const pageSize = ref(12)
const searchName = ref('')
const selectedStatus = ref('')
const selectedVenueId = ref('')
const sortType = ref<SortType>('timeAsc')

const buildQuery = (targetPage = page.value) => ({
  pageNum: targetPage,
  pageSize: pageSize.value,
  name: searchName.value.trim() || undefined,
  status: selectedStatus.value || undefined,
  venueId: selectedVenueId.value ? Number(selectedVenueId.value) : undefined,
})

onMounted(() => {
  store.fetchActivities(buildQuery())
})

const handleSearch = () => {
  page.value = 1
  store.fetchActivities(buildQuery(1))
}

const handleReset = () => {
  searchName.value = ''
  selectedStatus.value = ''
  selectedVenueId.value = ''
  sortType.value = 'timeAsc'
  page.value = 1
  store.fetchActivities(buildQuery(1))
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchActivities(buildQuery(p))
}

const handleRetry = () => {
  store.fetchActivities(buildQuery())
}

const totalPages = computed(() => Math.ceil(store.total / pageSize.value))

const activities = computed<ScheduleActivity[]>(() => store.activities as ScheduleActivity[])

const venueOptions = computed<VenueFilterOption[]>(() => {
  const map = new Map<number, string>()
  activities.value.forEach(activity => {
    const rawVenueId = (activity as ScheduleActivity & { venueId?: number }).venueId
    if (rawVenueId && activity.venueName) {
      map.set(rawVenueId, activity.venueName)
    }
  })
  return Array.from(map, ([id, name]) => ({ id, name }))
})

const sortedActivities = computed(() => {
  return [...activities.value].sort((a, b) => {
    if (sortType.value === 'nameAsc') {
      return (a.name || '').localeCompare(b.name || '', 'zh-Hans-CN')
    }

    const aTime = a.startTime ? new Date(a.startTime.replace(/-/g, '/')).getTime() : 0
    const bTime = b.startTime ? new Date(b.startTime.replace(/-/g, '/')).getTime() : 0
    return sortType.value === 'timeDesc' ? bTime - aTime : aTime - bTime
  })
})

const recommendedActivities = computed(() => {
  return sortedActivities.value.slice(0, 3)
})

const showRecommendations = computed(() => recommendedActivities.value.length > 0 && !store.isLoading && !store.error)

const formatActivityDate = (value?: string) => {
  if (!value) return '时间待定'
  return value.slice(0, 16)
}
</script>

<template>
  <NavBar />

  <ChannelPageShell>
    <ChannelIntro
      eyebrow="CHONGQING EVENTS"
      title="特色活动"
      subtitle="发现近期值得参与的文化体验、城市活动与特色演出"
      total-label="活动总数"
      :total-value="store.total"
      filtered-label="当前结果"
      :filtered-value="activities.length"
      note="按时间、场馆与状态快速浏览"
    />

    <div class="mt-10">
      <PageToolbar
        v-model:search="searchName"
        v-model:status="selectedStatus"
        v-model:venue-id="selectedVenueId"
        v-model:sort="sortType"
        :result-count="activities.length"
        :venue-options="venueOptions"
        @submit="handleSearch"
        @reset="handleReset"
      />
    </div>

    <div class="mt-6">
      <StateBlock
        v-if="store.isLoading"
        type="loading"
      />

      <StateBlock
        v-else-if="store.error"
        type="error"
        title="活动加载失败"
        description="网络异常或数据暂不可用，请稍后重试。"
        action-text="重新加载"
        @action="handleRetry"
      />

      <StateBlock
        v-else-if="sortedActivities.length === 0"
        type="empty"
        title="暂时没有符合条件的活动"
        description="你可以调整筛选条件，或先浏览全部活动内容。"
        action-text="查看全部活动"
        secondary-action-text="清除筛选"
        @action="handleReset"
        @secondary="handleReset"
      />

      <div v-else class="space-y-10">
        <section v-if="showRecommendations">
          <div class="mb-5 flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
            <div>
              <h2 class="font-heading text-[26px] font-bold text-brand">近期推荐</h2>
              <p class="mt-2 font-body text-sm text-muted">基于当前活动列表靠前内容展示，便于快速发现值得关注的活动。</p>
            </div>
            <span class="font-body text-sm text-muted">精选活动</span>
          </div>

          <div class="grid gap-5 lg:grid-cols-[1.15fr_0.85fr]">
            <router-link
              :to="`/activities/${recommendedActivities[0].id}`"
              class="group rounded-[20px] border border-border bg-light p-6 transition-colors hover:border-accent md:p-7"
            >
              <div class="mb-8 flex flex-wrap items-center gap-2">
                <span v-if="recommendedActivities[0].type || recommendedActivities[0].category" class="font-body text-sm text-muted">
                  {{ recommendedActivities[0].type || recommendedActivities[0].category }}
                </span>
                <span v-if="recommendedActivities[0].status" class="rounded-full border border-border bg-white px-3 py-1 font-body text-xs text-muted">
                  {{ recommendedActivities[0].status }}
                </span>
              </div>
              <h3 class="font-heading text-[26px] font-semibold leading-tight text-brand">
                {{ recommendedActivities[0].name || '暂无名称' }}
              </h3>
              <p class="mt-4 line-clamp-2 font-body text-base leading-7 text-muted">
                {{ recommendedActivities[0].description || '暂无活动介绍' }}
              </p>
              <div class="mt-7 flex flex-wrap gap-x-5 gap-y-2 font-body text-sm text-muted">
                <span>{{ formatActivityDate(recommendedActivities[0].startTime) }}</span>
                <span v-if="recommendedActivities[0].venueName">{{ recommendedActivities[0].venueName }}</span>
              </div>
            </router-link>

            <div v-if="recommendedActivities.length > 1" class="grid gap-5">
              <router-link
                v-for="item in recommendedActivities.slice(1)"
                :key="item.id"
                :to="`/activities/${item.id}`"
                class="rounded-[20px] border border-border bg-white p-6 transition-colors hover:border-accent"
              >
                <div class="mb-3 flex items-center justify-between gap-3">
                  <span class="font-body text-xs text-muted">{{ formatActivityDate(item.startTime) }}</span>
                  <span v-if="item.status" class="rounded-full bg-light px-3 py-1 font-body text-xs text-muted">{{ item.status }}</span>
                </div>
                <h3 class="font-heading text-[18px] font-semibold text-brand">{{ item.name || '暂无名称' }}</h3>
                <p class="mt-3 line-clamp-2 font-body text-sm leading-6 text-muted">
                  {{ item.description || item.venueName || '暂无活动介绍' }}
                </p>
              </router-link>
            </div>
          </div>
        </section>

        <section>
          <div class="mb-5">
            <h2 class="font-heading text-[24px] font-bold text-brand">全部活动</h2>
            <p class="mt-2 font-body text-sm text-muted">按时间、状态和场馆浏览更多活动。</p>
          </div>

          <div class="space-y-4">
            <ActivityScheduleCard
              v-for="activity in sortedActivities"
              :key="activity.id"
              :activity="activity"
            />
          </div>
        </section>

        <PaginationBar
          :page="page"
          :total-pages="totalPages"
          @change="handlePageChange"
        />
      </div>
    </div>
  </ChannelPageShell>

  <BackToTop />
</template>
