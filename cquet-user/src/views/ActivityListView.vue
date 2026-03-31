<script setup lang="ts">
import { ref, onMounted } from 'vue'
import NavBar from '@/components/layout/NavBar.vue'
import ActivityCard from '@/components/cards/ActivityCard.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import ErrorState from '@/components/ui/ErrorState.vue'
import { useActivityStore } from '@/stores/activity'

const store = useActivityStore()
const searchName = ref('')
const page = ref(1)
const pageSize = ref(12)

onMounted(() => {
  store.fetchActivities({ pageNum: page.value, pageSize: pageSize.value })
})

const handleSearch = () => {
  store.fetchActivities({ pageNum: 1, pageSize: pageSize.value, name: searchName.value || undefined })
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchActivities({ pageNum: p, pageSize: pageSize.value, name: searchName.value || undefined })
}

const handleRetry = () => {
  store.fetchActivities({ pageNum: page.value, pageSize: pageSize.value, name: searchName.value || undefined })
}
</script>

<template>
  <NavBar />
  <div class="min-h-screen bg-dark pt-[72px]">
    <div class="px-6 lg:px-8 py-8">
      <h1 class="font-montserrat font-bold text-3xl text-brand mb-8">特色活动</h1>
      <div class="flex gap-3 mb-8">
        <input
          v-model="searchName"
          @keyup.enter="handleSearch"
          placeholder="搜索活动名称..."
          class="bg-dark border border-border text-brand px-4 py-2 rounded text-sm flex-1 focus:border-brand outline-none"
        />
        <button @click="handleSearch" class="bg-brand text-white px-6 py-2 text-xs font-montserrat tracking-wider rounded hover:bg-brand-light transition-colors">
          搜索
        </button>
      </div>

      <LoadingState :isLoading="store.isLoading" />
      <ErrorState v-else-if="store.error" message="加载失败，请检查网络连接" @retry="handleRetry" />
      <EmptyState v-else-if="store.activities.length === 0" message="暂无活动数据" />
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        <ActivityCard v-for="activity in store.activities" :key="activity.id" :activity="activity" />
      </div>

      <div v-if="store.total > pageSize" class="flex justify-center gap-2 mt-10">
        <button
          v-for="p in Math.ceil(store.total / pageSize)"
          :key="p"
          @click="handlePageChange(p)"
          class="w-10 h-10 rounded text-sm font-montserrat transition-colors"
          :class="p === page ? 'bg-brand text-white' : 'border border-border text-muted hover:border-brand'"
        >
          {{ p }}
        </button>
      </div>
    </div>
  </div>
</template>
