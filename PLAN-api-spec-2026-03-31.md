# 计划：重庆文旅项目完整接口规范文档

## 1. 任务背景

当前项目缺乏一份完整的接口规范文档（API Specification）。现有代码中只有分散在 Controller 注释中的接口说明，以及 design doc 中不完整的 API contract（仅有旅游业务 API，缺少系统管理 API）。

需求：生成一份覆盖全项目的完整接口规范文档，供前端开发和后端联调使用。

## 2. 文档结构规划

```
接口规范文档.md
├── 1. 概述
│   ├── 1.1 项目介绍
│   ├── 1.2 文档目的
│   ├── 1.3 技术栈
│   └── 1.4 基础路径与版本约定
├── 2. 接口规范
│   ├── 2.1 认证模块
│   ├── 2.2 A级景区模块
│   ├── 2.3 场馆模块
│   ├── 2.4 特色活动模块
│   ├── 2.5 活动审批模块
│   ├── 2.6 图片管理模块
│   ├── 2.7 系统管理模块（用户/角色/菜单）
│   └── 2.8 通用接口
├── 3. 通用约定
│   ├── 3.1 认证方式
│   ├── 3.2 请求格式
│   ├── 3.3 响应格式（Result / TableDataInfo）
│   ├── 3.4 状态码约定
│   ├── 3.5 分页参数约定
│   ├── 3.6 权限标识说明
│   └── 3.7 错误处理规范
├── 4. 数据模型
│   ├── 4.1 景区（TourismScenicSpot）
│   ├── 4.2 场馆（TourismVenue）
│   ├── 4.3 活动（TourismActivity）
│   ├── 4.4 活动审批（TourismActivityApproval）
│   ├── 4.5 图片（TourismImage）
│   └── 4.6 系统用户（SysUser）
└── 5. 接口索引
```

## 3. 已有代码基础（可直接复用）

| 模块 | 已有代码位置 | 说明 |
|------|------------|------|
| 景区 CRUD | `TourismScenicSpotController.java` | 完整，注释详细 |
| 场馆 CRUD | `tourismVenueController.java` | 完整 |
| 活动 CRUD | `TourismActivityController.java` | 完整，含审核 |
| 活动审批 | `TourismActivityApprovalController.java` | 完整 |
| 图片管理 | `TourismImageController.java` | 完整 |
| 登录 | `SysLoginController.java` | 完整（若依） |
| 注册 | `SysRegisterController.java` | 完整（若依） |
| 响应封装 | `Result.java` | 完整定义 |
| 分页封装 | `TableDataInfo.java` | 完整定义 |
| 登录请求体 | `LoginBody.java` | `username`, `password`, `code`, `uuid` |
| 注册请求体 | `RegisterBody.java` | 继承 LoginBody |
| 实体类 | `cquet-tourism/domain/*.java` | 6个业务实体 |

## 4. 具体实现内容

### 4.1 认证模块 APIs

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 登录 | POST | `/login` | 公开 | body: `{username, password, code, uuid}`，返回 token |
| 注册 | POST | `/register` | 公开 | body: 同 LoginBody，需系统开启注册 |
| 获取用户信息 | GET | `/getInfo` | 需认证 | 返回 user/roles/permissions |
| 获取路由 | GET | `/getRouters` | 需认证 | 返回菜单树 |

### 4.2 A级景区模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/scenic-spot/list` | `tourism:scenicSpot:list` | 分页+条件查询 |
| 详情 | GET | `/tourism/scenic-spot/{id}` | `tourism:scenicSpot:query` | 返回 ScenicSpotDetailVo |
| 新增 | POST | `/tourism/scenic-spot` | `tourism:scenicSpot:add` | body: TourismScenicSpot |
| 修改 | PUT | `/tourism/scenic-spot` | `tourism:scenicSpot:edit` | body: TourismScenicSpot |
| 删除 | DELETE | `/tourism/scenic-spot/{ids}` | `tourism:scenicSpot:remove` | 批量删除 |
| 图片列表 | GET | `/tourism/scenic-spot/{id}/images` | `tourism:scenicSpot:image:list` | 景区关联图片 |
| 设置图片 | PUT | `/tourism/scenic-spot/{id}/images` | `tourism:scenicSpot:image:edit` | 覆盖式设置 |

### 4.3 场馆模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/venue/list` | `tourism:venue:list` | name/address/city 模糊查询 |
| 详情 | GET | `/tourism/venue/{id}` | `tourism:venue:query` | 返回 VenueDetailVo |
| 新增 | POST | `/tourism/venue` | `tourism:venue:add` | body: TourismVenue |
| 修改 | PUT | `/tourism/venue` | `tourism:venue:edit` | body: TourismVenue |
| 删除 | DELETE | `/tourism/venue/{ids}` | `tourism:venue:remove` | 批量删除 |
| 活动列表 | GET | `/tourism/venue/{id}/activities` | `tourism:venueActivity:list` | 场馆下的活动 |
| 图片列表 | GET | `/tourism/venue/{id}/images` | `tourism:venue:image:list` | 场馆关联图片 |
| 设置图片 | PUT | `/tourism/venue/{id}/images` | `tourism:venue:image:edit` | 覆盖式设置 |

### 4.4 特色活动模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/activity/list` | `tourism:activity:list` | name/venueId/auditStatus 筛选 |
| 详情 | GET | `/tourism/activity/{id}` | `tourism:activity:query` | 返回 TourismActivityVo（含审核状态） |
| 新增 | POST | `/tourism/activity` | `tourism:activity:add` | body: TourismActivity |
| 修改 | PUT | `/tourism/activity` | `tourism:activity:edit` | body: TourismActivity |
| 删除 | DELETE | `/tourism/activity/{ids}` | `tourism:activity:remove` | 批量删除 |
| 状态更新 | PUT | `/tourism/activity/{id}/status/{status}` | `tourism:activity:edit` | 暂停/启动 |
| 审核通过 | POST | `/tourism/activity/{id}/approve` | `tourism:activity:approve` | 可传 opinion |
| 审核拒绝 | POST | `/tourism/activity/{id}/reject` | `tourism:activity:reject` | 必须传 reason |

### 4.5 活动审批模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 待审列表 | GET | `/tourism/activity-approval/list` | `tourism:activityApplication:list` | 含审批状态筛选 |
| 审批历史 | GET | `/tourism/activity-approval/{activityId}/history` | `tourism:activityApplication:history` | 活动审批记录 |
| 审批通过 | POST | `/tourism/activity-approval/{id}/pass` | `tourism:activityApplication:approve` | 可传 opinion |
| 审批拒绝 | POST | `/tourism/activity-approval/{id}/reject` | `tourism:activityApplication:reject` | 必须传 reason |

### 4.6 图片管理模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 新增 | POST | `/tourism/images` | `tourism:image:add` | body: TourismImage |
| 批量新增 | POST | `/tourism/images/batch` | `tourism:image:add` | body: URL 列表 |
| 列表 | GET | `/tourism/images/list` | `tourism:image:list` | 分页 |
| 详情 | GET | `/tourism/images/{id}` | `tourism:image:query` | 单条记录 |
| 删除 | DELETE | `/tourism/images/{ids}` | `tourism:image:remove` | 批量删除 |

### 4.7 设备设施模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/facilities/list` | `tourism:facilities:list` | facilitiesName 模糊查询 |
| 详情 | GET | `/tourism/facilities/{id}` | `tourism:facilities:query` | 单条记录 |
| 新增 | POST | `/tourism/facilities` | `tourism:facilities:add` | body: TourismFacilities |
| 修改 | PUT | `/tourism/facilities` | `tourism:facilities:edit` | body: TourismFacilities |
| 删除 | DELETE | `/tourism/facilities/{ids}` | `tourism:facilities:remove` | 批量删除 |

### 4.8 新闻模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/news/list` | `tourism:news:list` | 标题+时间范围查询 |
| 详情 | GET | `/tourism/news/{id}` | `tourism:news:query` | 单条记录 |
| 新增 | POST | `/tourism/news` | `tourism:news:add` | body: TourismNews |
| 修改 | PUT | `/tourism/news` | `tourism:news:edit` | body: TourismNews |
| 删除 | DELETE | `/tourism/news/{ids}` | `tourism:news:remove` | 批量删除 |

### 4.9 通知公告模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 列表 | GET | `/tourism/notice/list` | `tourism:notice:list` | 标题+时间范围查询 |
| 详情 | GET | `/tourism/notice/{id}` | `tourism:notice:query` | 单条记录 |
| 新增 | POST | `/tourism/notice` | `tourism:notice:add` | body: TourismNotice |
| 修改 | PUT | `/tourism/notice` | `tourism:notice:edit` | body: TourismNotice |
| 删除 | DELETE | `/tourism/notice/{ids}` | `tourism:notice:remove` | 批量删除 |

### 4.10 数据大屏模块

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 统计数据 | GET | `/tourism/dashboard/statistics` | `tourism:dashboard:statistics` | 总览数据 |
| 区县分布 | GET | `/tourism/dashboard/district-distribution` | `tourism:dashboard:district` | 各区县分布 |
| 热度排行 | GET | `/tourism/dashboard/hotspot-ranking` | `tourism:dashboard:hotspot` | 热度排名 |
| 活动趋势 | GET | `/tourism/dashboard/activity-trend` | `tourism:dashboard:trend` | 活动时间趋势 |
| 地图分布 | GET | `/tourism/dashboard/map-distribution` | `tourism:dashboard:map` | 地图打点数据 |

### 4.11 通用文件接口

| 接口 | 方法 | 路径 | 权限 | 说明 |
|------|------|------|------|------|
| 单文件上传 | POST | `/common/upload` | 公开 | 返回 url/fileName/newFileName |
| 多文件上传 | POST | `/common/uploads` | 公开 | 返回 urls/fileNames（逗号分隔） |
| 文件下载 | GET | `/common/download` | 公开 | fileName + delete 参数 |
| 资源下载 | GET | `/common/download/resource` | 公开 | resource 路径参数 |

### 4.7 通用响应格式

**Result（单条操作/详情）**：
```json
{
  "code": 200,
  "msg": "success",
  "state": true,
  "data": { ... },
  "time": 1743400000000
}
```

**TableDataInfo（列表分页）**：
```json
{
  "total": 100,
  "rows": [ ... ],
  "code": 200,
  "msg": "查询成功"
}
```

**状态码约定**：
| code | 含义 |
|------|------|
| 200 | 成功 |
| 301 | 警告（业务校验失败，如"景区不存在"） |
| 500 | 错误（系统异常） |

### 4.8 权限标识说明

| 前缀 | 模块 |
|------|------|
| `tourism:scenicSpot:*` | 景区管理 |
| `tourism:venue:*` | 场馆管理 |
| `tourism:venueActivity:*` | 场馆-活动关联 |
| `tourism:activity:*` | 活动管理 |
| `tourism:activityApplication:*` | 活动报名/审批 |
| `tourism:image:*` | 图片管理 |

## 5. 技术方案

- **文档格式**：Markdown（.md）
- **输出路径**：`cquet-doc/接口规范文档.md`
- **信息源**：从 Controller 源码和 domain 实体类提取，确保与代码一致
- **生成方式**：手动整理（非代码生成），基于代码审查结果

## 6. 风险点

1. **权限问题**：所有旅游业务接口均有 `@PreAuthorize` 限制，用户端需在若依安全配置中放行或携带 token
2. **注册功能**：依赖 `sys.account.registerUser` 配置项是否为 `true`
3. **后端还未实现的接口**：收藏（UserCollection）、评论（ActivityComment）在 design doc 中提到但代码中未见

## 7. 交付物

- `cquet-doc/接口规范文档.md` — 完整接口规范

## 8. 后续建议（NOT in scope）

- [ ] 补充收藏/评论 API（需先确认后端是否已实现）
- [ ] 提供 OpenAPI/Swagger 导出（当前已有 `@Tag/@Operation` 注解，可直接访问 `/swagger-ui.html`）
- [ ] 前后端联调测试记录

---

## What Already Exists

| 资源 | 路径 | 说明 |
|------|------|------|
| 景区 CRUD | `TourismScenicSpotController.java` | 已有完整接口和注释 |
| 场馆 CRUD | `tourismVenueController.java` | 已有完整接口 |
| 活动 CRUD | `TourismActivityController.java` | 已有含审核流程 |
| 活动审批 | `TourismActivityApprovalController.java` | 独立审批控制器 |
| 图片管理 | `TourismImageController.java` | 已有完整 CRUD |
| 登录注册 | `SysLoginController/SysRegisterController` | 若依标准实现 |
| 响应封装 | `Result.java` | 完整定义 |
| 分页封装 | `TableDataInfo.java` | 完整定义 |
| 设计文档 API 部分 | `24034-master-design-20260328-205113.md` | 有不完整的 API contract |

## NOT in Scope

| 功能 | 原因 |
|------|------|
| 收藏 API（UserCollection） | 后端代码中未找到对应 Controller |
| 评论 API（ActivityComment） | 后端代码中未找到对应 Controller |
| Swagger/OpenAPI 导出 | 已有 `@Tag/@Operation` 注解，可直接用 `/swagger-ui.html` |
| 用户端免权限接口改造 | 需修改若依安全配置，属于运维配置而非文档范畴 |

## ASCII Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                      API 调用流程                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  客户端                                                          │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐                 │
│  │ 用户端    │    │ 管理端    │    │ Swagger  │                 │
│  │ Vue3 前端 │    │ Vue2+Element│   │ /swagger-ui │
│  └────┬─────┘    └────┬─────┘    └────┬─────┘                 │
│       │                │                │                        │
│       └────────────────┼────────────────┘                        │
│                        │                                         │
│                        ▼                                         │
│              ┌─────────────────────┐                            │
│              │   Spring Security    │                            │
│              │   @PreAuthorize     │                            │
│              │   权限校验           │                            │
│              └──────────┬──────────┘                            │
│                         │                                        │
│                         ▼                                        │
│              ┌─────────────────────┐                            │
│              │    Controller        │                            │
│              │  @Tag @Operation    │                            │
│              │  Swagger 文档注解    │                            │
│              └──────────┬──────────┘                            │
│                         │                                        │
│                         ▼                                        │
│              ┌─────────────────────┐                            │
│              │     Service          │                            │
│              │   业务逻辑层         │                            │
│              └──────────┬──────────┘                            │
│                         │                                        │
│                         ▼                                        │
│              ┌─────────────────────┐                            │
│              │     Mapper           │                            │
│              │   MyBatis-Plus       │                            │
│              └──────────┬──────────┘                            │
│                         │                                        │
│                         ▼                                        │
│              ┌─────────────────────┐                            │
│              │      MySQL           │                            │
│              └─────────────────────┘                            │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Test Coverage

由于本次任务是生成文档而非代码，测试覆盖为 N/A。文档内容直接从源码提取，确保与代码一致。

---

## GSTACK REVIEW REPORT

| Review | Trigger | Why | Runs | Status | Findings |
|--------|---------|-----|------|--------|----------|
| CEO Review | `/plan-ceo-review` | Scope & strategy | 0 | — | — |
| Codex Review | `/codex review` | Independent 2nd opinion | 0 | OFFERED | 可运行 /codex 获取第二意见 |
| Eng Review | `/plan-eng-review` | Architecture & tests (required) | 1 | ✅ PASS | 文档任务，0 issues |
| Design Review | `/plan-design-review` | UI/UX gaps | 0 | — | — |

**VERDICT:** API 规范文档已生成完毕。**计划状态：完成，无需进一步 review。**
