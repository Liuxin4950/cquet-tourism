/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        // 主色
        brand: '#222a2c',
        // 浅色文字（用于深色背景上）
        light: '#f5f4f2',
        // 次要文字
        muted: '#648992',
        // 深色背景
        dark: '#092c38',
        // 边框
        border: '#dfdfdf',
        // 卡片强调色（特定卡片背景）
        accent: '#105670',
      },
      fontFamily: {
        heading: ['Montserrat', 'sans-serif'],
        body: ['Manrope', 'sans-serif'],
      },
      // 固定字号（不随屏幕缩放）
      fontSize: {
        'nav': '12px',
        'nav-mobile': '14px',
        'hero-title': '72px',
        'hero-sub': '16px',
        'section-title': '36px',
        'section-sub': '12px',
        'card-title': '15px',
        'card-desc': '12px',
        'card-meta': '11px',
        'footer': '13px',
        'footer-small': '11px',
        'btn': '12px',
      },
      // 固定高度
      height: {
        'nav': '72px',
        'nav-mobile': '60px',
      },
      borderRadius: {
        pill: '100vw',
      },
    },
  },
  plugins: [],
}
