// 环境变量中配置后端地址，如 http://localhost:8080
const IMG_BASE = import.meta.env.VITE_IMG_BASE_URL || ''

/**
 * 拼接完整图片URL
 * 传入相对路径 → 自动拼接 IMG_BASE
 * 传入绝对URL（http/https）→ 原样返回
 * 传入空字符串 → 返回空字符串
 */
export function imgUrl(path: string): string {
  if (!path) return ''
  if (/^https?:\/\//i.test(path)) return path  // 已是完整URL
  const base = IMG_BASE.replace(/\/$/, '')       // 去掉尾部斜杠
  return `${base}/${path.replace(/^\/+/, '')}`  // 去掉前导斜杠后拼接
}
