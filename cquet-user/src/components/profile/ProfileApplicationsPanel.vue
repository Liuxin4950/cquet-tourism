<script setup lang="ts">
import ProfileEmptyState from './ProfileEmptyState.vue'
import { imgUrl } from '@/utils/imgUrl'
import type { ActivityApplication, ApplicationStatus } from '@/types/profile'

defineProps<{
  applications: ActivityApplication[]
  loading: boolean
  error: boolean
}>()

const statusText: Record<ApplicationStatus, string> = {
  pending: '待审批',
  approved: '已通过',
  rejected: '已拒绝',
}

const statusClass: Record<ApplicationStatus, string> = {
  pending: 'bg-yellow-100 text-yellow-700',
  approved: 'bg-green-100 text-green-700',
  rejected: 'bg-red-100 text-red-700',
}

const formatDate = (value: string) => value ? value.slice(0, 16) : '时间待定'
const coverUrl = (value: string) => imgUrl(value)
</script>

<template>
  <section>
    <div class="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
      <div>
        <h2 class="font-heading text-[22px] font-semibold text-brand">我的报名</h2>
        <p class="mt-2 font-body text-sm text-muted">查看活动报名记录与审批状态。</p>
      </div>
      <router-link to="/activities" class="font-body text-sm text-muted underline transition-colors hover:text-brand">
        浏览活动
      </router-link>
    </div>

    <div v-if="loading" class="space-y-4">
      <div v-for="item in 3" :key="item" class="animate-pulse rounded-[20px] border border-border p-4">
        <div class="flex gap-4">
          <div class="h-24 w-32 rounded-[16px] bg-light"></div>
          <div class="flex-1 space-y-3">
            <div class="h-4 w-1/3 rounded bg-light"></div>
            <div class="h-3 w-2/3 rounded bg-light"></div>
            <div class="h-3 w-1/2 rounded bg-light"></div>
          </div>
        </div>
      </div>
    </div>

    <div v-else-if="error" class="rounded-[20px] border border-border bg-light p-8 text-center">
      <p class="font-body text-sm text-muted">报名记录暂时加载失败，请稍后重试。</p>
    </div>

    <ProfileEmptyState
      v-else-if="applications.length === 0"
      title="暂无报名记录"
      description="还没有报名任何活动。去看看近期活动，找到适合自己的文化体验。"
      cta-text="去活动列表"
      to="/activities"
    />

    <div v-else class="space-y-4">
      <article
        v-for="item in applications"
        :key="item.id"
        class="rounded-[20px] border border-border bg-white p-4 transition-colors hover:border-accent"
      >
        <div class="grid gap-4 md:grid-cols-[160px_minmax(0,1fr)_120px] md:items-center">
          <div class="aspect-[16/10] overflow-hidden rounded-[16px] bg-light">
            <img
              v-if="coverUrl(item.coverImage)"
              :src="coverUrl(item.coverImage)"
              :alt="item.activityName"
              class="h-full w-full object-cover"
            />
          </div>
          <div class="min-w-0">
            <div class="mb-3 flex flex-wrap items-center gap-2">
              <span class="rounded-full bg-light px-3 py-1 font-body text-xs text-muted">{{ item.category || '活动' }}</span>
              <span class="rounded-full px-3 py-1 font-body text-xs" :class="statusClass[item.status]">
                {{ statusText[item.status] }}
              </span>
            </div>
            <h3 class="font-heading text-lg font-semibold text-brand">{{ item.activityName }}</h3>
            <p class="mt-2 font-body text-sm text-muted">{{ item.venueName || '地点待定' }}</p>
            <p class="mt-2 font-body text-xs text-muted">
              {{ formatDate(item.startTime) }} - {{ formatDate(item.endTime) }}
            </p>
          </div>
          <div class="flex md:justify-end">
            <router-link
              :to="`/activities/${item.activityId}`"
              class="btn-pill"
            >
              查看详情
            </router-link>
          </div>
        </div>
      </article>
    </div>
  </section>
</template>
