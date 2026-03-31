<script setup lang="ts">
import { onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import BackToTop from '@/components/ui/BackToTop.vue'
import { useNoticeStore } from '@/stores/notice'

const props = defineProps<{ id: string }>()
const route = useRoute()
const router = useRouter()
const store = useNoticeStore()

onMounted(() => {
  const noticeId = Number(props.id || route.params.id)
  store.fetchNoticeDetail(noticeId)
})

const goBack = () => {
  router.back()
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-white pt-[72px]">
    <LoadingState v-if="store.isLoading" />
    <div v-else-if="store.currentNotice" class="max-w-[900px] mx-auto px-6 lg:px-8 py-12">
      <button
        @click="goBack"
        class="mb-8 text-xs font-heading text-muted hover:text-brand transition-colors tracking-wider"
      >
        ← 返回
      </button>

      <!-- 标题 -->
      <h1 class="font-heading font-light text-[32px] text-brand leading-tight mb-4">
        {{ store.currentNotice.title }}
      </h1>

      <!-- 元信息 -->
      <div class="flex items-center gap-4 text-xs text-muted mb-10 pb-8 border-b border-border">
        <span v-if="store.currentNotice.publishTime">发布时间：{{ store.currentNotice.publishTime }}</span>
      </div>

      <!-- 正文 -->
      <div
        class="text-sm text-brand leading-[1.9]"
        v-html="store.currentNotice.content"
      ></div>
    </div>
    <div v-else class="flex items-center justify-center min-h-[50vh]">
      <p class="text-muted">公告不存在或已被删除</p>
    </div>
    <BackToTop />
  </div>
</template>
