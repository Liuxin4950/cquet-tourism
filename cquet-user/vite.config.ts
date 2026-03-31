import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  server: {
    port: 5173,
    // 注意：此 proxy 配置仅在 `npm run dev` 开发模式下生效
    // 生产构建（`npm run build`）输出纯静态文件，API 路由需由
    // 部署环境 Web Server（Nginx/CDN）配置 /tourism → http://backend:8080 的代理转发
    proxy: {
      '/tourism': {
        target: 'http://localhost:8080',
        changeOrigin: true,
      },
    },
  },
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          'vendor': ['vue', 'vue-router', 'pinia'],
          'utils': ['axios', 'dayjs'],
          'swiper': ['swiper'],
        },
      },
    },
  },
})
