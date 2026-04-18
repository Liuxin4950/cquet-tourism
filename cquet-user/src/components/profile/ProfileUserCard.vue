<script setup lang="ts">
import { computed } from 'vue'
import { imgUrl } from '@/utils/imgUrl'
import type { UserProfile } from '@/types/auth'

const props = defineProps<{
  user: UserProfile | null
}>()

const emit = defineEmits<{
  logout: []
}>()

const displayName = computed(() => props.user?.nickName || props.user?.username || '用户')
const accountName = computed(() => props.user?.username || '未填写')
const avatar = computed(() => imgUrl(props.user?.avatar || ''))
const initial = computed(() => displayName.value.charAt(0).toUpperCase())
const statusLabel = computed(() => (props.user?.status === '1' ? '已停用' : '正常使用'))
</script>

<template>
  <aside class="rounded-[24px] bg-gradient-to-br from-brand via-dark to-accent p-6 text-white shadow-sm">
    <div class="flex items-center gap-4">
      <img
        v-if="avatar"
        :src="avatar"
        :alt="displayName"
        class="h-[72px] w-[72px] rounded-full border border-white/30 object-cover"
      />
      <div
        v-else
        class="flex h-[72px] w-[72px] items-center justify-center rounded-full border border-white/30 bg-white/10 font-heading text-2xl font-semibold"
      >
        {{ initial }}
      </div>
      <div class="min-w-0">
        <h2 class="truncate font-heading text-xl font-semibold">{{ displayName }}</h2>
        <p class="mt-1 truncate font-body text-sm text-white/70">@{{ accountName }}</p>
      </div>
    </div>

    <div class="mt-7 space-y-4 font-body text-sm">
      <div>
        <span class="block text-white/45">手机号</span>
        <span class="mt-1 block text-white/85">{{ user?.phone || '未填写' }}</span>
      </div>
      <div>
        <span class="block text-white/45">邮箱</span>
        <span class="mt-1 block break-all text-white/85">{{ user?.email || '未填写' }}</span>
      </div>
      <span class="inline-flex rounded-full border border-white/20 bg-white/10 px-3 py-1 text-xs text-white/85">
        {{ statusLabel }}
      </span>
    </div>

    <div class="mt-8 grid gap-3">
      <button
        type="button"
        disabled
        class="rounded-full border border-white/25 px-4 py-3 font-body text-sm text-white/55"
      >
        编辑资料（暂未开放）
      </button>
      <button
        type="button"
        class="rounded-full border border-white/25 px-4 py-3 font-body text-sm text-white/85 transition-colors hover:border-white/60 hover:bg-white/10"
        @click="emit('logout')"
      >
        退出登录
      </button>
    </div>
  </aside>
</template>
