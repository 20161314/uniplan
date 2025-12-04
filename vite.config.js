import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // 监听所有网络接口
    port: 5173, // 端口号
    strictPort: false, // 如果端口被占用，尝试下一个可用端口
    allowedHosts: [
      '.trycloudflare.com', // 允许所有 cloudflare 隧道域名
      '.loca.lt', // 允许 localtunnel 域名
      'localhost',
      '127.0.0.1',
    ],
  },
})
