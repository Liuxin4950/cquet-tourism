<script setup lang="ts">
import { watch } from 'vue'

const props = defineProps<{
  show: boolean
  title: string
  message: string
  confirmText?: string
  cancelText?: string
}>()

const emit = defineEmits<{
  confirm: []
  cancel: []
}>()

// 弹窗打开时禁止页面滚动
watch(() => props.show, (val) => {
  if (val) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
  }
})
</script>

<template>
  <Teleport to="body">
    <Transition name="modal">
      <div v-if="show" class="modal-overlay" @click="emit('cancel')">
        <div class="modal-content" @click.stop>
          <h3 class="modal-title">{{ title }}</h3>
          <p class="modal-message">{{ message }}</p>
          <div class="modal-actions">
            <button @click="emit('cancel')" class="modal-btn modal-btn-cancel">
              {{ cancelText || '取消' }}
            </button>
            <button @click="emit('confirm')" class="modal-btn modal-btn-confirm">
              {{ confirmText || '确认' }}
            </button>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(4px);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-content {
  background: #fff;
  border-radius: 12px;
  padding: 32px;
  width: 90%;
  max-width: 400px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
}

.modal-title {
  font-family: 'Manrope', sans-serif;
  font-size: 20px;
  font-weight: 600;
  color: #222a2c;
  margin-bottom: 8px;
}

.modal-message {
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
  color: #666;
  margin-bottom: 32px;
  line-height: 1.5;
}

.modal-actions {
  display: flex;
  gap: 12px;
  justify-content: flex-end;
}

.modal-btn {
  font-family: 'Manrope', sans-serif;
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.02em;
  padding: 12px 28px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
}

.modal-btn-cancel {
  background: transparent;
  border: 1px solid #ddd;
  color: #666;
}

.modal-btn-cancel:hover {
  border-color: #999;
  color: #333;
  background: #f5f5f5;
}

.modal-btn-confirm {
  background: #222a2c;
  border: 1px solid #222a2c;
  color: #fff;
}

.modal-btn-confirm:hover {
  background: #333;
  border-color: #333;
}

/* Modal transitions */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content,
.modal-leave-active .modal-content {
  transition: transform 0.3s ease;
}

.modal-enter-from .modal-content,
.modal-leave-to .modal-content {
  transform: scale(0.95);
}
</style>
