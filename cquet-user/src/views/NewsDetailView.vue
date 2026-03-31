<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import { useNewsStore } from '@/stores/news'

const props = defineProps<{ id: string }>()
const route = useRoute()
const router = useRouter()
const store = useNewsStore()

onMounted(() => {
  const newsId = Number(props.id || route.params.id)
  store.fetchNewsDetail(newsId)
})

const goBack = () => {
  router.back()
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-white pt-[72px]">
    <LoadingState v-if="store.isLoading" />
    <div v-else-if="store.currentNews" class="max-w-[900px] mx-auto px-6 lg:px-8 py-12">
      <button
        @click="goBack"
        class="mb-8 text-xs font-heading text-muted hover:text-brand transition-colors tracking-wider"
      >
        ← 返回
      </button>

      <!-- Banner -->
      <div v-if="store.currentNews.coverImage" class="w-full h-[40vh] rounded-lg overflow-hidden mb-10">
        <img
          :src="store.currentNews.coverImage"
          :alt="store.currentNews.title"
          class="w-full h-full object-cover"
        />
      </div>

      <!-- 标题 -->
      <h1 class="font-heading font-light text-[32px] text-brand leading-tight mb-4">
        {{ store.currentNews.title }}
      </h1>

      <!-- 元信息 -->
      <div class="flex items-center gap-4 text-xs text-muted mb-10 pb-8 border-b border-border">
        <span v-if="store.currentNews.author">作者：{{ store.currentNews.author }}</span>
        <span v-if="store.currentNews.publishTime">发布时间：{{ store.currentNews.publishTime }}</span>
      </div>

      <!-- 正文 -->
      <div
        class="text-sm text-brand leading-[1.9] prose"
        v-html="store.currentNews.content"
      ></div>
    </div>
    <EmptyState v-else message="新闻不存在或已被删除" />
    <BackToTop />
  </div>
</template>
