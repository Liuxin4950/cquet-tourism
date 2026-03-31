<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useNoticeStore } from '@/stores/notice'

const router = useRouter()
const store = useNoticeStore()
const searchTitle = ref('')
const page = ref(1)
const pageSize = ref(12)

onMounted(() => {
  store.fetchNoticeList({ pageNum: page.value, pageSize: pageSize.value })
})

const handleSearch = () => {
  page.value = 1
  store.fetchNoticeList({ pageNum: 1, pageSize: pageSize.value, title: searchTitle.value || undefined })
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchNoticeList({ pageNum: p, pageSize: pageSize.value, title: searchTitle.value || undefined })
}

const goToDetail = (id: number) => {
  router.push(`/notices/${id}`)
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-white pt-[72px]">
    <div class="px-6 lg:px-8 py-12 max-w-[1280px] mx-auto">
      <h1 class="font-heading font-light text-[36px] text-brand mb-8">通知公告</h1>

      <!-- 搜索 -->
      <div class="flex gap-3 mb-10">
        <input
          v-model="searchTitle"
          @keyup.enter="handleSearch"
          placeholder="搜索公告标题..."
          class="flex-1 border border-border rounded px-4 py-3 text-sm focus:border-accent outline-none transition-colors"
        />
        <button
          @click="handleSearch"
          class="bg-brand text-white px-6 py-3 text-xs font-heading tracking-wider rounded hover:bg-dark transition-colors"
        >
          搜索
        </button>
      </div>

      <LoadingState v-if="store.isLoading" />
      <EmptyState v-else-if="store.noticeList.length === 0" message="暂无公告" />
      <div v-else class="space-y-4">
        <article
          v-for="item in store.noticeList"
          :key="item.id"
          @click="goToDetail(item.id)"
          class="border border-border rounded p-6 cursor-pointer group hover:border-accent hover:shadow-md transition-all"
        >
          <div class="flex items-start justify-between gap-4">
            <div class="flex-1 min-w-0">
              <h2 class="font-heading text-[15px] text-brand mb-2 group-hover:text-accent transition-colors line-clamp-1">
                {{ item.title }}
              </h2>
              <p class="text-sm text-muted line-clamp-2 leading-relaxed">
                {{ item.content?.replace(/<[^>]+>/g, '').slice(0, 120) }}...
              </p>
            </div>
            <span class="text-xs text-muted whitespace-nowrap flex-shrink-0 mt-1">
              {{ item.publishTime }}
            </span>
          </div>
        </article>
      </div>

      <!-- 分页 -->
      <div v-if="store.total > pageSize" class="flex justify-center gap-2 mt-10">
        <button
          v-for="p in Math.ceil(store.total / pageSize)"
          :key="p"
          @click="handlePageChange(p)"
          class="w-10 h-10 rounded text-sm font-heading transition-colors"
          :class="p === page ? 'bg-brand text-white' : 'border border-border text-muted hover:border-accent'"
        >
          {{ p }}
        </button>
      </div>
    </div>
  </div>
</template>
