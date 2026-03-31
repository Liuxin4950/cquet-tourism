<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import NavBar from '@/components/layout/NavBar.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useNewsStore } from '@/stores/news'

const router = useRouter()
const store = useNewsStore()
const searchTitle = ref('')
const page = ref(1)
const pageSize = ref(12)

onMounted(() => {
  store.fetchNewsList({ pageNum: page.value, pageSize: pageSize.value })
})

const handleSearch = () => {
  page.value = 1
  store.fetchNewsList({ pageNum: 1, pageSize: pageSize.value, title: searchTitle.value || undefined })
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchNewsList({ pageNum: p, pageSize: pageSize.value, title: searchTitle.value || undefined })
}

const goToDetail = (id: number) => {
  router.push(`/news/${id}`)
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-white pt-[72px]">
    <div class="px-6 lg:px-8 py-12 max-w-[1280px] mx-auto">
      <h1 class="font-heading font-light text-[36px] text-brand mb-8">新闻资讯</h1>

      <!-- 搜索 -->
      <div class="flex gap-3 mb-10">
        <input
          v-model="searchTitle"
          @keyup.enter="handleSearch"
          placeholder="搜索新闻标题..."
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
      <EmptyState v-else-if="store.newsList.length === 0" message="暂无新闻资讯" />
      <div v-else class="space-y-6">
        <article
          v-for="item in store.newsList"
          :key="item.id"
          @click="goToDetail(item.id)"
          class="flex gap-6 cursor-pointer group"
        >
          <div class="w-48 h-32 flex-shrink-0 bg-light rounded overflow-hidden">
            <img
              v-if="item.coverImage"
              :src="item.coverImage"
              :alt="item.title"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
              loading="lazy"
            />
            <div v-else class="w-full h-full bg-light flex items-center justify-center">
              <span class="text-muted text-xs">无封面</span>
            </div>
          </div>
          <div class="flex-1 min-w-0">
            <h2 class="font-heading text-[15px] text-brand mb-2 group-hover:text-accent transition-colors line-clamp-2">
              {{ item.title }}
            </h2>
            <p class="text-xs text-muted mb-2">
              {{ item.publishTime }}
            </p>
            <p class="text-sm text-muted line-clamp-2 leading-relaxed">
              {{ item.content?.replace(/<[^>]+>/g, '').slice(0, 100) }}...
            </p>
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
