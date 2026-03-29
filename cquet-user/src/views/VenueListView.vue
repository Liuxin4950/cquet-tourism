<script setup lang="ts">
import { ref, onMounted } from 'vue'
import VenueCard from '@/components/cards/VenueCard.vue'
import LoadingState from '@/components/ui/LoadingState.vue'
import EmptyState from '@/components/ui/EmptyState.vue'
import { useVenueStore } from '@/stores/venue'

const store = useVenueStore()
const searchName = ref('')
const page = ref(1)
const pageSize = ref(12)

onMounted(() => {
  store.fetchVenues({ pageNum: page.value, pageSize: pageSize.value })
})

const handleSearch = () => {
  store.fetchVenues({ pageNum: 1, pageSize: pageSize.value, name: searchName.value || undefined })
}

const handlePageChange = (p: number) => {
  page.value = p
  store.fetchVenues({ pageNum: p, pageSize: pageSize.value, name: searchName.value || undefined })
}
</script>

<template>
  <div class="min-h-screen bg-primary-dark pt-[72px]">
    <div class="px-[5vw] py-8">
      <h1 class="font-montserrat font-bold text-3xl text-text-primary mb-8">文化场馆</h1>
      <div class="flex gap-3 mb-8">
        <input
          v-model="searchName"
          @keyup.enter="handleSearch"
          placeholder="搜索场馆名称..."
          class="bg-primary-dark border border-border-color text-text-primary px-4 py-2 rounded text-sm flex-1 focus:border-primary outline-none"
        />
        <button @click="handleSearch" class="bg-primary text-text-primary px-6 py-2 text-xs font-montserrat tracking-wider rounded hover:bg-primary-light transition-colors">
          搜索
        </button>
      </div>

      <LoadingState :isLoading="store.isLoading" />
      <EmptyState v-else-if="store.venues.length === 0" message="暂无场馆数据" />
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5">
        <VenueCard v-for="venue in store.venues" :key="venue.id" :venue="venue" />
      </div>

      <div v-if="store.total > pageSize" class="flex justify-center gap-2 mt-10">
        <button
          v-for="p in Math.ceil(store.total / pageSize)"
          :key="p"
          @click="handlePageChange(p)"
          class="w-10 h-10 rounded text-sm font-montserrat transition-colors"
          :class="p === page ? 'bg-primary text-text-primary' : 'border border-border-color text-text-secondary hover:border-primary'"
        >
          {{ p }}
        </button>
      </div>
    </div>
  </div>
</template>
