<script setup lang="ts">
import { RouterView } from 'vue-router'
import BackToTop from '@/components/ui/BackToTop.vue'
import Toast from '@/components/ui/Toast.vue'
import { useToast } from '@/composables/useToast'

const { toasts, remove } = useToast()
</script>

<template>
  <RouterView />
  <BackToTop />
  <!-- Toast 提示 -->
  <div class="toast-wrapper">
    <Toast
      v-for="toast in toasts"
      :key="toast.id"
      :message="toast.message"
      :type="toast.type"
      @close="remove(toast.id)"
    />
  </div>
</template>
