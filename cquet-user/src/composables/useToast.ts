import { ref } from 'vue'

export interface ToastItem {
  id: number
  message: string
  type: 'success' | 'error' | 'info'
}

const toasts = ref<ToastItem[]>([])
let nextId = 0
let lastToastTime = 0
const DEBOUNCE_MS = 2000

export function useToast() {
  const show = (message: string, type: 'success' | 'error' | 'info' = 'info', duration = 3000) => {
    const now = Date.now()
    // 熔断：如果 2 秒内有相同类型的 toast 正在显示，则忽略
    if (now - lastToastTime < DEBOUNCE_MS) {
      const existing = toasts.value.find(t => t.type === type)
      if (existing) return
    }
    lastToastTime = now
    const id = nextId++
    toasts.value.push({ id, message, type })
    setTimeout(() => {
      remove(id)
    }, duration)
  }

  const remove = (id: number) => {
    const index = toasts.value.findIndex(t => t.id === id)
    if (index !== -1) {
      toasts.value.splice(index, 1)
    }
  }

  const success = (message: string) => show(message, 'success')
  const error = (message: string) => show(message, 'error')
  const info = (message: string) => show(message, 'info')

  return { toasts, show, remove, success, error, info }
}
