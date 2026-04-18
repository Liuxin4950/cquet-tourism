<script setup lang="ts">
import ProfileEmptyState from './ProfileEmptyState.vue'
import { imgUrl } from '@/utils/imgUrl'
import type { UserCollectionItem } from '@/types/profile'

defineProps<{
  collections: UserCollectionItem[]
}>()

const typeLabel: Record<UserCollectionItem['type'], string> = {
  spot: '景区',
  venue: '场馆',
  activity: '活动',
}

const detailPath = (item: UserCollectionItem) => {
  const prefixMap: Record<UserCollectionItem['type'], string> = {
    spot: 'spots',
    venue: 'venues',
    activity: 'activities',
  }
  return `/${prefixMap[item.type]}/${item.targetId}`
}
</script>

<template>
  <section>
    <div class="mb-5 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
      <div>
        <h2 class="font-heading text-[22px] font-semibold text-brand">我的收藏</h2>
        <p class="mt-2 font-body text-sm text-muted">收藏接口待联调，当前保留完整内容卡片骨架。</p>
      </div>
      <router-link to="/spots" class="font-body text-sm text-muted underline transition-colors hover:text-brand">
        去发现内容
      </router-link>
    </div>

    <ProfileEmptyState
      v-if="collections.length === 0"
      title="暂无收藏内容"
      description="浏览景区、场馆和活动时，可以把感兴趣的内容加入收藏。"
      cta-text="去浏览景区"
      to="/spots"
    />

    <div v-else class="grid grid-cols-1 gap-4 md:grid-cols-2">
      <article
        v-for="item in collections"
        :key="item.id"
        class="overflow-hidden rounded-[20px] border border-border bg-white"
      >
        <div class="aspect-[16/9] bg-light">
          <img
            v-if="item.image"
            :src="imgUrl(item.image)"
            :alt="item.title"
            class="h-full w-full object-cover"
          />
        </div>
        <div class="p-5">
          <div class="mb-3 flex items-center justify-between gap-3">
            <span class="rounded-full bg-light px-3 py-1 font-body text-xs text-muted">{{ typeLabel[item.type] }}</span>
            <span class="font-body text-xs text-muted">{{ item.collectedAt }}</span>
          </div>
          <h3 class="font-heading text-lg font-semibold text-brand">{{ item.title }}</h3>
          <p class="mt-2 line-clamp-2 font-body text-sm leading-6 text-muted">{{ item.description }}</p>
          <div class="mt-5 flex items-center justify-between gap-3">
            <router-link :to="detailPath(item)" class="font-body text-sm text-brand underline">
              查看详情
            </router-link>
            <button
              type="button"
              disabled
              class="rounded-full border border-border px-4 py-2 font-body text-xs text-muted"
            >
              取消收藏
            </button>
          </div>
        </div>
      </article>
    </div>
  </section>
</template>
