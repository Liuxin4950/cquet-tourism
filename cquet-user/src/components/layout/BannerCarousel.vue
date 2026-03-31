<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import { Autoplay, Navigation, Pagination } from 'swiper/modules'
import type { Swiper as SwiperType } from 'swiper'

import 'swiper/css'
import 'swiper/css/navigation'
import 'swiper/css/pagination'

interface BannerItem {
  image: string
  title?: string
  subtitle?: string
}

defineProps<{
  banners: BannerItem[]
}>()

const currentIndex = ref(0)
const swiperRef = ref<SwiperType | null>(null)

const onSwiper = (swiper: SwiperType) => {
  swiperRef.value = swiper
}

const onSlideChange = (swiper: SwiperType) => {
  currentIndex.value = swiper.activeIndex
}

const goToSlide = (index: number) => {
  swiperRef.value?.slideTo(index)
}

const prev = () => {
  swiperRef.value?.slidePrev()
}

const next = () => {
  swiperRef.value?.slideNext()
}
</script>

<template>
  <div class="banner-carousel">
    <Swiper
      :modules="[Autoplay, Navigation, Pagination]"
      :slides-per-view="1"
      :loop="true"
      :autoplay="{
        delay: 5000,
        disableOnInteraction: false,
      }"
      :navigation="{
        prevEl: '.banner-nav-prev',
        nextEl: '.banner-nav-next',
      }"
      :pagination="{
        el: '.banner-pagination',
        clickable: true,
      }"
      @swiper="onSwiper"
      @slide-change="onSlideChange"
    >
      <SwiperSlide v-for="(banner, index) in banners" :key="index">
        <div class="banner-slide">
          <img :src="banner.image" :alt="banner.title || 'Banner'" class="banner-image" />
          <div class="banner-overlay"></div>
          <div v-if="banner.title || banner.subtitle" class="banner-content">
            <p v-if="banner.subtitle" class="banner-subtitle">{{ banner.subtitle }}</p>
            <h2 v-if="banner.title" class="banner-title">{{ banner.title }}</h2>
          </div>
        </div>
      </SwiperSlide>

      <!-- Navigation Arrows -->
      <button class="banner-nav-prev" aria-label="Previous">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5" />
        </svg>
      </button>
      <button class="banner-nav-next" aria-label="Next">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
          <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
        </svg>
      </button>

      <!-- Pagination Dots -->
      <div class="banner-pagination"></div>
    </Swiper>
  </div>
</template>

<style scoped>
.banner-carousel {
  position: relative;
  width: 100%;
  height: 100%;
}

.banner-slide {
  position: relative;
  width: 100%;
  height: 100%;
}

.banner-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.banner-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 0.3) 0%,
    rgba(0, 0, 0, 0.1) 50%,
    rgba(0, 0, 0, 0.5) 100%
  );
}

.banner-content {
  position: absolute;
  bottom: 15%;
  left: 8.33%;
  z-index: 2;
}

.banner-subtitle {
  font-family: 'Manrope', sans-serif;
  font-size: 12px;
  font-weight: 400;
  letter-spacing: 0.25em;
  text-transform: uppercase;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 12px;
}

.banner-title {
  font-family: 'Montserrat', sans-serif;
  font-size: clamp(36px, 5vw, 72px);
  font-weight: 300;
  line-height: 1.1;
  color: #ffffff;
}

/* Navigation Arrows */
.banner-nav-prev,
.banner-nav-next {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 10;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(4px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  color: #ffffff;
  cursor: pointer;
  transition: all 0.3s ease;
}

.banner-nav-prev {
  left: 24px;
}

.banner-nav-next {
  right: 24px;
}

.banner-nav-prev:hover,
.banner-nav-next:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.4);
}

.banner-nav-prev svg,
.banner-nav-next svg {
  width: 24px;
  height: 24px;
}

/* Pagination Dots */
.banner-pagination {
  position: absolute;
  bottom: 24px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10;
  display: flex;
  gap: 12px;
}

.banner-pagination :deep(.swiper-pagination-bullet) {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: transparent;
  border: 1px solid rgba(255, 255, 255, 0.5);
  opacity: 1;
  cursor: pointer;
  transition: all 0.3s ease;
}

.banner-pagination :deep(.swiper-pagination-bullet-active) {
  background: #ffffff;
  border-color: #ffffff;
}

/* Responsive */
@media (max-width: 768px) {
  .banner-nav-prev,
  .banner-nav-next {
    width: 36px;
    height: 36px;
  }

  .banner-nav-prev {
    left: 12px;
  }

  .banner-nav-next {
    right: 12px;
  }

  .banner-nav-prev svg,
  .banner-nav-next svg {
    width: 18px;
    height: 18px;
  }
}
</style>
