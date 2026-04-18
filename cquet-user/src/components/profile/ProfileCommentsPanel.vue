<script setup lang="ts">
import ProfileEmptyState from './ProfileEmptyState.vue'
import type { UserCommentItem } from '@/types/profile'

defineProps<{
  comments: UserCommentItem[]
}>()
</script>

<template>
  <section>
    <div class="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
      <div>
        <h2 class="font-heading text-[22px] font-semibold text-brand">我的评论</h2>
        <p class="mt-2 font-body text-sm text-muted">评论接口待联调，当前保留互动记录展示骨架。</p>
      </div>
      <router-link to="/activities" class="font-body text-sm text-muted underline transition-colors hover:text-brand">
        参与活动
      </router-link>
    </div>

    <ProfileEmptyState
      v-if="comments.length === 0"
      title="暂无评论记录"
      description="参与活动后，可以在活动详情中留下体验感想和互动记录。"
      cta-text="去活动列表"
      to="/activities"
    />

    <div v-else class="space-y-4">
      <article
        v-for="item in comments"
        :key="item.id"
        class="rounded-[20px] border border-border bg-white p-5"
      >
        <div class="mb-4 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          <router-link :to="`/activities/${item.activityId}`" class="font-heading text-base font-semibold text-brand hover:text-accent">
            {{ item.activityName }}
          </router-link>
          <span class="font-body text-xs text-muted">{{ item.createdAt }}</span>
        </div>
        <div class="rounded-[16px] bg-light p-4 font-body text-sm leading-7 text-brand">
          {{ item.content }}
        </div>
        <div class="mt-4 font-body text-xs text-muted">
          {{ item.replyCount }} 条互动回复
        </div>
      </article>
    </div>
  </section>
</template>
