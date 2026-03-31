# CLAUDE.md

本文档为 Claude Code 在 `cquet-user/` 用户端前端项目工作时提供指导。

## 项目文档

所有项目文档集中在 `docs/` 目录下：

| 文档 | 内容 |
|------|------|
| `docs/需求文档.md` | 项目背景、目标用户、功能范围、视觉风格、成功标准 |
| `docs/架构文档.md` | 技术栈、项目结构、页面结构、路由设计、API对接、开发计划 |
| `docs/接口规范文档.md` | API对接规范，此文档包含整个后端所有接口 |

> **重要**：开始开发新功能前，先阅读上述文档。新功能开发完成后，按 `docs/开发日志/` 目录下的格式记录。

## 技术栈

Vue 3 + Vite + TypeScript + Tailwind CSS + Pinia + Vue Router + Axios + GSAP + Swiper

## 关键约定

- **样式规范**：参考 Range Developments 网站风格。颜色/字体/布局见 `docs/需求文档.md`。
- **HTTP 请求**：封装在 `src/api/request.ts`，不复用若依的 request.js。
- **Token 处理**：`src/stores/auth.ts` 管理，Axios 拦截器自动注入 `Authorization: Bearer` header。
- **组件目录**：`src/components/layout/`（布局）、`src/components/ui/`（通用UI）。
- **路由守卫**：登录页和用户中心页需登录验证，见 `src/router/index.ts`。
- **GSAP 动画**：仅 4 个简单动画，见 `docs/架构文档.md` 第7节。

## 开发命令

```bash
# 安装依赖
npm install

# 开发服务器（代理到 localhost:8080 后端）
npm run dev

# 构建生产环境
npm run build
```

## 路由

| 路径 | 页面 | 权限 |
|------|------|------|
| `/` | HomeView | 公开 |
| `/spots` | SpotListView | 公开 |
| `/spots/:id` | SpotDetailView | 公开 |
| `/venues` | VenueListView | 公开 |
| `/venues/:id` | VenueDetailView | 公开 |
| `/activities` | ActivityListView | 公开 |
| `/activities/:id` | ActivityDetailView | 公开 |
| `/news` | NewsListView | 公开 |
| `/news/:id` | NewsDetailView | 公开 |
| `/notices` | NoticeListView | 公开 |
| `/notices/:id` | NoticeDetailView | 公开 |
| `/login` | LoginView | 公开 |
| `/register` | RegisterView | 公开 |
| `/profile` | ProfileView | 需登录 |
| `/about` | AboutView | 公开 |

## 后端接口

后端在 `cquet-tourism/` 模块（若依框架），`localhost:8080`。
- Vite dev 模式通过 proxy 代理 `/tourism/**` 到后端。
- 所有旅游接口有 `@PreAuthorize` 权限限制，需带 token 访问。
- 注册接口 `/register` 后端不存在，需新增。

## gstack

使用 `/browse` 进行所有网页浏览。Never use mcp__claude-in-chrome__* tools.
Available skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review,
/design-consultation, /review, /ship, /land-and-deploy, /canary, /benchmark, /browse,
/qa, /qa-only, /design-review, /setup-browser-cookies, /setup-deploy, /retro,
/investigate, /document-release, /codex, /cso, /autoplan, /careful, /freeze, /guard,
/unfreeze, /gstack-upgrade.
