/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{vue,js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        // Range Developments 风格色板
        brand: '#222a2c',       // 深青灰（主色）
        white: '#FFFFFF',       // 纯白背景
        light: '#f5f4f2',      // 暖白灰背景
        muted: '#648992',       // 灰蓝次要文字
        dark: '#092c38',        // 深色（Footer）
        border: '#dfdfdf',      // 边框色
      },
      fontFamily: {
        heading: ['Montserrat', 'sans-serif'],
        body: ['Manrope', 'sans-serif'],
        // Range 网站衬线标题字体（The Seasons），这里用 Montserrat 近似
        serif: ['Georgia', 'serif'],
      },
      borderRadius: {
        pill: '100vw',
      },
    },
  },
  plugins: [],
}
