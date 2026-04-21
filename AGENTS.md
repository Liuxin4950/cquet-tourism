# AGENTS.md

本文档为 Codex (Codex.ai/code) 在本项目中工作时提供指导。

## gstack
Use /browse from gstack for all web browsing. Never use mcp__claude-in-chrome__* tools.
Available skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review,
/design-consultation, /review, /ship, /land-and-deploy, /canary, /benchmark, /browse,
/qa, /qa-only, /design-review, /setup-browser-cookies, /setup-deploy, /retro,
/investigate, /document-release, /codex, /cso, /autoplan, /careful, /freeze, /guard,
/unfreeze, /gstack-upgrade.

## 项目概述

本项目为重庆文旅网站管理系统，包含：
- **后端管理**：基于若依框架开发的管理后台
- **用户前端**：独立的现代化旅游网站前端（不在本仓库）
- **AI集成**：计划使用 SpringAI + MCP 实现智能景区推荐

系统展示重庆文旅资源，包括 A 级景区、文化场馆和特色活动，为本地居民和游客提供一站式文旅服务平台。

## 架构

### 后端 (Spring Boot + MyBatis + 若依框架)
- **多模块 Maven 项目**，基于若依框架快速开发
- **cquet-admin**：主应用入口，包含 Spring Boot 启动类
- **cquet-framework**：核心框架组件（安全、配置、Web）- 扩展自若依
- **cquet-system**：系统管理模块（用户、角色、菜单、字典）- 若依基础模块
- **cquet-tourism**：旅游业务逻辑模块（自定义业务领域）
- **cquet-common**：通用工具和共享组件
- **cquet-generator**：代码生成工具（基于若依 RuoYi Velocity 模板）
  - 生成 Controller、Service、Mapper、Entity、Vue 页面全套 CRUD 代码
  - 前端代码生成在 `cquet-ui-demo/src/generator/` 目录下

### 后台管理前端 (Vue 2 + Element UI)
- **cquet-ui-demo**：基于若依的管理界面
- 使用 Element UI 组件库构建统一的管理后台 UI
- Vue Router 做路由管理，Vuex 做状态管理
- axios 处理 HTTP 请求，echarts 做数据可视化

### 用户端前端
- **独立仓库**：现代化旅游网站界面（不在本仓库）

## 开发命令

### 后端 (Maven)
```bash
# 清理并编译
mvn clean compile

# 运行所有测试
mvn test

# 运行单个测试类
mvn test -Dtest=类名

# 运行单个测试方法
mvn test -Dtest=类名#方法名

# 打包应用
mvn clean package

# 运行应用（在 cquet-admin 目录下）
cd cquet-admin
mvn spring-boot:run
```

### 前端 (npm/vue-cli)
```bash
# 安装依赖
cd cquet-ui-demo && npm install

# 启动开发服务器
cd cquet-ui-demo && npm run dev

# 构建生产环境
cd cquet-ui-demo && npm run build:prod

# 构建预发布环境
cd cquet-ui-demo && npm run build:stage

# 运行代码检查
cd cquet-ui-demo && npm run lint
```

## 业务领域

### 核心实体
系统管理三种主要旅游资源类型：

1. **A级景区**：评级旅游景点（A-AAAAA 级）
   - 自然景观或历史遗迹
   - 可能免费或收费
   - 示例：洪崖洞（4A）、大足石刻（5A）

2. **场馆**：文化、体育、教育设施
   - 博物馆、图书馆、体育馆、剧院
   - 室内场馆，有容量限制
   - 示例：重庆图书馆、重庆奥林匹克中心

3. **特色活动**：文化和娱乐活动
   - 非票务销售，是推广本地文化的文化体验
   - 包含演出、Workshop、节日活动、教育活动
   - 示例：川剧变脸、书法课堂、马拉松、传统节庆

### 关键关系
- **场馆 → 活动**：活动在特定场馆举办
- **用户 → 收藏**：用户可以收藏景区、场馆、活动
- **用户 → 活动报名**：用户报名参加活动（需审批）
- **用户 → 活动评论**：用户可以评论活动，支持回复

## 数据库

系统使用 MySQL，关键表：
- `tourism_scenic_spot`：景区信息
- `tourism_venue`：场馆信息和容量
- `tourism_activity`：活动安排和详情
- `tourism_user_collection`：用户收藏（通过 target_type 区分类型）
- `tourism_activity_application`：活动报名申请
- `tourism_activity_comment`：用户评论（支持层级）

## 前端结构

### 关键目录
- `src/views/tourism/`：旅游管理页面
  - `scenicSpot/`：景区 CRUD 操作
  - `venue/`：场馆管理界面
  - `activity/`：活动创建和管理
  - `activityApplication/`：报名审批工作流
- `src/api/`：后端 API 服务层（与后台 Controller 一一对应）
  - `tourism/`：景区、场馆、活动相关的 API 调用
  - `system/`：系统管理相关的 API（若依自带）
- `src/components/`：可复用组件（分页、文件上传等）
- `src/utils/`：工具函数和请求处理

### 配置
- **代理设置**：开发服务器将 API 请求代理到 `localhost:8080`
- **资源优化**：生产构建包含 gzip 压缩
- **代码分割**：Element UI、第三方库和通用组件分别打包

## 开发注意事项

- **若依框架集成**：基于若依强大的管理后台基础
  - 用户管理、基于角色的访问控制、菜单管理
  - 字典管理用于动态配置
  - 代码生成工具快速开发 CRUD
- **图片上传**：使用若依现有文件上传系统处理景区/场馆图片
- **前端样式**：Sass + Element UI 主题定制
- **开发体验**：前端使用 Vue CLI 4.4.6（不是 Vite），后端使用 Spring Boot DevTools 热重载
- **代码质量**：ESLint + Husky 预提交钩子（lint-staged 配置在 package.json 中）
- **Java 版本**：项目使用 Spring Boot 3.3.2，需要 **Java 17+**。根 pom.xml 中 `java.version=1.8` 是遗留错误，实际编译和运行必须使用 JDK 17+
- **Spring Boot 版本不一致**：cquet-admin 中 spring-boot-maven-plugin 使用 2.5.15，但 parent pom 导入的是 3.3.2，存在版本冲突

## 关键文件

- **根目录 pom.xml**：项目父 POM，包含依赖版本
- **cquet-admin**：主应用入口，包含 Spring Boot 启动类
- **cquet-tourism**：旅游业务域，包含实体类、服务(Serivce)、控制器(Controller)
  - `controller/`：旅游业务 REST API（如 ScenicSpotController, VenueController, ActivityController）
  - `domain/`：实体类（MyBatis-Plus 注解的 POJO）
  - `service/`：业务逻辑层
  - `mapper/`：数据访问层（MyBatis-Plus BaseMapper）
  - `docs/`：模块设计文档

## AI 集成路线图

计划集成 SpringAI + MCP 实现智能功能：
- **智能景区推荐**：基于用户偏好的 AI 推荐
- **个性化路线规划**：智能旅行路线建议
- **文化体验推荐**：匹配用户兴趣的活动和场馆推荐
- **多语言支持**：AI 辅助内容翻译

## 重庆文旅特色

本系统专门管理重庆独特的文旅资源：
- **山城特色**：山地城市地理和景区
- **火锅文化**：火锅旅游和美食体验
- **红色旅游**：革命历史遗迹
- **长江三峡**：三峡旅游资源
- **都市夜景**：城市夜景和江轮游
