<script setup lang="ts">
import type { ProfileTab, ProfileTabItem } from '@/types/profile'

defineProps<{
  items: ProfileTabItem[]
  active: ProfileTab
}>()

const emit = defineEmits<{
  change: [tab: ProfileTab]
}>()
</script>

<template>
  <div class="overflow-x-auto pb-1">
    <div class="flex min-w-max gap-2 rounded-full bg-light p-1">
      <button
        v-for="item in items"
        :key="item.key"
        type="button"
        class="rounded-full px-5 py-2.5 font-body text-sm transition-colors"
        :class="active === item.key ? 'bg-brand text-white shadow-sm' : 'text-muted hover:text-brand'"
        @click="emit('change', item.key)"
      >
        {{ item.label }}
      </button>
    </div>
  </div>
</template>
