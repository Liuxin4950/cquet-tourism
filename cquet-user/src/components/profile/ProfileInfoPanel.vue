<script setup lang="ts">
import { computed } from 'vue'
import type { UserProfile } from '@/types/auth'

const props = defineProps<{
  user: UserProfile | null
}>()

const sexLabel = computed(() => {
  if (props.user?.sex === '0') return '女'
  if (props.user?.sex === '1') return '男'
  return '未填写'
})

const statusLabel = computed(() => {
  if (props.user?.status === '1') return '停用'
  if (props.user?.status === '0') return '正常'
  return '正常'
})

const fields = computed(() => [
  { label: '用户昵称', value: props.user?.nickName || '未填写' },
  { label: '登录账号', value: props.user?.username || '未填写' },
  { label: '手机号', value: props.user?.phone || '未填写' },
  { label: '邮箱地址', value: props.user?.email || '未填写' },
  { label: '性别', value: sexLabel.value },
  { label: '账号状态', value: statusLabel.value },
])
</script>

<template>
  <section>
    <div class="mb-5">
      <h2 class="font-heading text-[22px] font-semibold text-brand">我的资料</h2>
      <p class="mt-2 font-body text-sm text-muted">这些信息来自当前登录账号，后续可扩展为可编辑资料。</p>
    </div>

    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
      <div
        v-for="field in fields"
        :key="field.label"
        class="rounded-[18px] border border-border bg-light p-5"
      >
        <p class="font-body text-xs text-muted">{{ field.label }}</p>
        <p class="mt-3 break-words font-body text-base text-brand">{{ field.value }}</p>
      </div>
    </div>
  </section>
</template>
