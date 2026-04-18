<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'

const props = defineProps<{
  isTyping: boolean
  showPassword: boolean
  passwordLength: number
}>()

// 鼠标位置
const mouseX = ref(0)
const mouseY = ref(0)

// 移动端检测
const isMobile = ref(false)

// 眨眼状态
const isPurpleBlinking = ref(false)
const isBlackBlinking = ref(false)

// 角色 refs
const purpleRef = ref<HTMLElement | null>(null)
const blackRef = ref<HTMLElement | null>(null)
const orangeRef = ref<HTMLElement | null>(null)
const yellowRef = ref<HTMLElement | null>(null)

// 紫色角色偷看状态
const isPurplePeeking = ref(false)

// 紫色角色偷看定时器
let peekTimer: ReturnType<typeof setTimeout> | null = null

// 鼠标移动处理
const handleMouseMove = (e: MouseEvent) => {
  if (isMobile.value) return
  mouseX.value = e.clientX
  mouseY.value = e.clientY
}

// 计算角色位置
const calcPos = (refEl: HTMLElement | null) => {
  if (!refEl) return { faceX: 0, faceY: 0, bodySkew: 0 }

  const rect = refEl.getBoundingClientRect()
  const centerX = rect.left + rect.width / 2
  const centerY = rect.top + rect.height / 3

  const deltaX = mouseX.value - centerX
  const deltaY = mouseY.value - centerY

  const faceX = Math.max(-8, Math.min(8, deltaX / 25))
  const faceY = Math.max(-5, Math.min(5, deltaY / 35))
  const bodySkew = Math.max(-6, Math.min(6, -deltaX / 120))

  return { faceX, faceY, bodySkew }
}

// 位置数据 - purplePos 和 blackPos 等在模板中直接使用（Vue 3 auto-unwrap）
const purplePos = computed(() => calcPos(purpleRef.value))
const blackPos = computed(() => calcPos(blackRef.value))
const orangePos = computed(() => calcPos(orangeRef.value))
const yellowPos = computed(() => calcPos(yellowRef.value))

// 密码状态
const isHidingPassword = computed(() => props.passwordLength > 0 && !props.showPassword)

// 眨眼调度
const schedulePurpleBlink = () => {
  const delay = Math.random() * 4000 + 3000
  setTimeout(() => {
    isPurpleBlinking.value = true
    setTimeout(() => {
      isPurpleBlinking.value = false
      schedulePurpleBlink()
    }, 150)
  }, delay)
}

const scheduleBlackBlink = () => {
  const delay = Math.random() * 4000 + 3000
  setTimeout(() => {
    isBlackBlinking.value = true
    setTimeout(() => {
      isBlackBlinking.value = false
      scheduleBlackBlink()
    }, 150)
  }, delay)
}

// 紫色角色偷看调度
const schedulePeek = () => {
  if (props.passwordLength > 0 && props.showPassword) {
    const delay = Math.random() * 3000 + 2000
    peekTimer = setTimeout(() => {
      isPurplePeeking.value = true
      setTimeout(() => {
        isPurplePeeking.value = false
        schedulePeek()
      }, 800)
    }, delay)
  }
}

// 生命周期
onMounted(() => {
  isMobile.value = /Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
  if (!isMobile.value) {
    window.addEventListener('mousemove', handleMouseMove)
  }
  schedulePurpleBlink()
  scheduleBlackBlink()
})

onUnmounted(() => {
  if (!isMobile.value) {
    window.removeEventListener('mousemove', handleMouseMove)
  }
  if (peekTimer) {
    clearTimeout(peekTimer)
  }
})

watch(() => props.showPassword, (newVal) => {
  if (newVal) {
    schedulePeek()
  } else {
    isPurplePeeking.value = false
    if (peekTimer) {
      clearTimeout(peekTimer)
      peekTimer = null
    }
  }
})

// === 紫色角色 transform 计算 ===
const purpleTransform = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return 'skewX(0deg)'
  if (props.isTyping || isHidingPassword.value) return `skewX(${(purplePos.value.bodySkew - 12)}deg) translateX(40px)`
  return `skewX(${purplePos.value.bodySkew}deg)`
})

const purpleEyeLeft = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return { left: '20px', top: '35px' }
  if (props.isTyping) return { left: '55px', top: '65px' }
  return { left: `${45 + purplePos.value.faceX}px`, top: `${40 + purplePos.value.faceY}px` }
})

const purpleEyeRight = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return { left: '20px', top: '35px' }
  if (props.isTyping) return { left: '55px', top: '65px' }
  return { left: `${45 + purplePos.value.faceX}px`, top: `${40 + purplePos.value.faceY}px` }
})

const purplePupilOffset = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) {
    return { x: isPurplePeeking.value ? 4 : -4, y: isPurplePeeking.value ? 5 : -4 }
  }
  if (props.isTyping) return { x: 3, y: 4 }
  return { x: purplePos.value.faceX, y: purplePos.value.faceY }
})

// === 黑色角色 transform 计算 ===
const blackTransform = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return 'skewX(0deg)'
  if (props.isTyping) return `skewX(${(blackPos.value.bodySkew * 1.5 + 10)}deg) translateX(20px)`
  if (props.isTyping || isHidingPassword.value) return `skewX(${(blackPos.value.bodySkew * 1.5)}deg)`
  return `skewX(${blackPos.value.bodySkew}deg)`
})

const blackEyeLeft = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return { left: '10px', top: '28px' }
  if (props.isTyping) return { left: '32px', top: '12px' }
  return { left: `${26 + blackPos.value.faceX}px`, top: `${32 + blackPos.value.faceY}px` }
})

const blackPupilOffset = computed(() => {
  if (props.passwordLength > 0 && props.showPassword) return { x: -4, y: -4 }
  if (props.isTyping) return { x: 0, y: -4 }
  return { x: blackPos.value.faceX, y: blackPos.value.faceY }
})
</script>

<template>
  <div class="relative" style="width: 550px; height: 400px;">
    <!-- 紫色角色 -->
    <div
      ref="purpleRef"
      class="absolute bottom-0 transition-all duration-700 ease-in-out"
      :style="{
        left: '70px',
        width: '180px',
        height: (props.isTyping || isHidingPassword) ? '440px' : '400px',
        backgroundColor: '#6C3FF5',
        borderRadius: '10px 10px 0 0',
        zIndex: 1,
        transform: purpleTransform,
        transformOrigin: 'bottom center',
      }"
    >
      <div
        class="absolute flex gap-8 transition-all duration-700 ease-in-out"
        :style="{
          left: purpleEyeLeft.left,
          top: purpleEyeLeft.top,
        }"
      >
        <div
          class="rounded-full flex items-center justify-center overflow-hidden transition-all duration-150"
          :style="{
            width: '22px',
            height: isPurpleBlinking ? '2px' : '22px',
            backgroundColor: 'white',
          }"
        >
          <div
            v-if="!isPurpleBlinking"
            class="rounded-full"
            :style="{
              width: '7px',
              height: '7px',
              backgroundColor: '#2D2D2D',
              transform: `translate(${purplePupilOffset.x}px, ${purplePupilOffset.y}px)`,
              transition: 'transform 0.1s ease-out',
            }"
          />
        </div>
        <div
          class="rounded-full flex items-center justify-center overflow-hidden transition-all duration-150"
          :style="{
            width: '22px',
            height: isPurpleBlinking ? '2px' : '22px',
            backgroundColor: 'white',
          }"
        >
          <div
            v-if="!isPurpleBlinking"
            class="rounded-full"
            :style="{
              width: '7px',
              height: '7px',
              backgroundColor: '#2D2D2D',
              transform: `translate(${purplePupilOffset.x}px, ${purplePupilOffset.y}px)`,
              transition: 'transform 0.1s ease-out',
            }"
          />
        </div>
      </div>
    </div>

    <!-- 黑色角色 -->
    <div
      ref="blackRef"
      class="absolute bottom-0 transition-all duration-700 ease-in-out"
      :style="{
        left: '240px',
        width: '120px',
        height: '310px',
        backgroundColor: '#2D2D2D',
        borderRadius: '8px 8px 0 0',
        zIndex: 2,
        transform: blackTransform,
        transformOrigin: 'bottom center',
      }"
    >
      <div
        class="absolute flex gap-6 transition-all duration-700 ease-in-out"
        :style="{
          left: blackEyeLeft.left,
          top: blackEyeLeft.top,
        }"
      >
        <div
          class="rounded-full flex items-center justify-center overflow-hidden transition-all duration-150"
          :style="{
            width: '20px',
            height: isBlackBlinking ? '2px' : '20px',
            backgroundColor: 'white',
          }"
        >
          <div
            v-if="!isBlackBlinking"
            class="rounded-full"
            :style="{
              width: '6px',
              height: '6px',
              backgroundColor: '#2D2D2D',
              transform: `translate(${blackPupilOffset.x}px, ${blackPupilOffset.y}px)`,
              transition: 'transform 0.1s ease-out',
            }"
          />
        </div>
        <div
          class="rounded-full flex items-center justify-center overflow-hidden transition-all duration-150"
          :style="{
            width: '20px',
            height: isBlackBlinking ? '2px' : '20px',
            backgroundColor: 'white',
          }"
        >
          <div
            v-if="!isBlackBlinking"
            class="rounded-full"
            :style="{
              width: '6px',
              height: '6px',
              backgroundColor: '#2D2D2D',
              transform: `translate(${blackPupilOffset.x}px, ${blackPupilOffset.y}px)`,
              transition: 'transform 0.1s ease-out',
            }"
          />
        </div>
      </div>
    </div>

    <!-- 橙色半圆角色 -->
    <div
      ref="orangeRef"
      class="absolute bottom-0 transition-all duration-700 ease-in-out"
      :style="{
        left: '0px',
        width: '240px',
        height: '200px',
        zIndex: 3,
        backgroundColor: '#FF9B6B',
        borderRadius: '120px 120px 0 0',
        transform: (props.passwordLength > 0 && props.showPassword) ? 'skewX(0deg)' : `skewX(${orangePos.bodySkew}deg)`,
        transformOrigin: 'bottom center',
      }"
    >
      <div
        class="absolute flex gap-8 transition-all duration-200 ease-out"
        :style="{
          left: (props.passwordLength > 0 && props.showPassword) ? '50px' : `${82 + orangePos.faceX}px`,
          top: (props.passwordLength > 0 && props.showPassword) ? '85px' : `${90 + orangePos.faceY}px`,
        }"
      >
        <div
          class="rounded-full"
          :style="{
            width: '12px',
            height: '12px',
            backgroundColor: '#2D2D2D',
            transform: `translate(${(props.passwordLength > 0 && props.showPassword) ? -5 : 0}px, ${(props.passwordLength > 0 && props.showPassword) ? -4 : 0}px)`,
            transition: 'transform 0.1s ease-out',
          }"
        />
        <div
          class="rounded-full"
          :style="{
            width: '12px',
            height: '12px',
            backgroundColor: '#2D2D2D',
            transform: `translate(${(props.passwordLength > 0 && props.showPassword) ? -5 : 0}px, ${(props.passwordLength > 0 && props.showPassword) ? -4 : 0}px)`,
            transition: 'transform 0.1s ease-out',
          }"
        />
      </div>
    </div>

    <!-- 黄色角色 -->
    <div
      ref="yellowRef"
      class="absolute bottom-0 transition-all duration-700 ease-in-out"
      :style="{
        left: '310px',
        width: '140px',
        height: '230px',
        backgroundColor: '#E8D754',
        borderRadius: '70px 70px 0 0',
        zIndex: 4,
        transform: (props.passwordLength > 0 && props.showPassword) ? 'skewX(0deg)' : `skewX(${yellowPos.bodySkew}deg)`,
        transformOrigin: 'bottom center',
      }"
    >
      <div
        class="absolute flex gap-6 transition-all duration-200 ease-out"
        :style="{
          left: (props.passwordLength > 0 && props.showPassword) ? '20px' : `${52 + yellowPos.faceX}px`,
          top: (props.passwordLength > 0 && props.showPassword) ? '35px' : `${40 + yellowPos.faceY}px`,
        }"
      >
        <div
          class="rounded-full"
          :style="{
            width: '12px',
            height: '12px',
            backgroundColor: '#2D2D2D',
            transform: `translate(${(props.passwordLength > 0 && props.showPassword) ? -5 : 0}px, ${(props.passwordLength > 0 && props.showPassword) ? -4 : 0}px)`,
            transition: 'transform 0.1s ease-out',
          }"
        />
        <div
          class="rounded-full"
          :style="{
            width: '12px',
            height: '12px',
            backgroundColor: '#2D2D2D',
            transform: `translate(${(props.passwordLength > 0 && props.showPassword) ? -5 : 0}px, ${(props.passwordLength > 0 && props.showPassword) ? -4 : 0}px)`,
            transition: 'transform 0.1s ease-out',
          }"
        />
      </div>
      <div
        class="absolute w-20 h-[4px] bg-[#2D2D2D] rounded-full transition-all duration-200 ease-out"
        :style="{
          left: (props.passwordLength > 0 && props.showPassword) ? '10px' : `${40 + yellowPos.faceX}px`,
          top: (props.passwordLength > 0 && props.showPassword) ? '88px' : `${88 + yellowPos.faceY}px`,
        }"
      />
    </div>
  </div>
</template>
