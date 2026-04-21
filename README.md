# 重庆文旅网站管理系统

重庆文旅网站管理系统是一个面向重庆本地文化旅游资源的综合管理项目，包含若依风格的后台管理端、旅游业务后端模块，以及独立的用户端旅游网站前端。系统用于管理 A 级景区、文化场馆、特色活动、用户收藏、活动报名和评论等核心业务，目标是为游客和本地居民提供一站式文旅服务支撑。

## 项目特点

- 基于 Spring Boot、MyBatis、若依框架构建后台管理能力
- 支持景区、场馆、特色活动等重庆文旅资源管理
- 提供活动报名审批、用户收藏、评论回复等业务流程
- 包含 Vue 2 + Element UI 后台管理前端
- 包含 Vue 3 + Vite 用户端前端
- 预留 Spring AI + MCP 智能推荐、路线规划、多语言等扩展方向

## 技术栈

### 后端

- Java 17+
- Spring Boot 3.3.2
- MyBatis / MyBatis-Plus
- Maven 多模块工程
- MySQL
- 若依框架基础能力

### 后台管理前端

- Vue 2.6
- Vue CLI 4.4
- Element UI
- Vuex
- Vue Router
- axios
- echarts

### 用户端前端

- Vue 3
- Vite 5
- TypeScript
- Pinia
- Vue Router
- Tailwind CSS
- Swiper / GSAP

## 目录结构

```text
cquet-demo/
├── cquet-admin/       # Spring Boot 启动模块和后台通用控制器
├── cquet-common/      # 通用工具、注解、常量和基础对象
├── cquet-framework/   # 安全、Web、配置等框架能力
├── cquet-generator/   # 若依代码生成模块
├── cquet-system/      # 用户、角色、菜单、字典等系统管理模块
├── cquet-tourism/     # 重庆文旅业务模块
├── cquet-ui-demo/     # Vue 2 后台管理前端
├── cquet-user/        # Vue 3 用户端旅游网站前端
├── cquet-doc/         # 项目论文、过程稿和设计文档
├── ER图/              # 数据库 ER 图
├── ruoyi.sql          # 若依基础数据库脚本
├── ruoyi数据库.sql    # 项目数据库补充脚本
└── tourism_database_create.sql # 旅游业务数据库建表脚本
```

## 核心业务

### A 级景区

管理重庆 A 级旅游景点信息，包括景区评级、地址、开放信息、门票、图片和详情介绍等。典型资源包括洪崖洞、大足石刻等自然景观或历史遗迹。

### 场馆

管理博物馆、图书馆、体育馆、剧院等文化体育教育设施，包含场馆容量、开放状态、地址、图片和详情介绍等信息。

### 特色活动

管理川剧变脸、书法课堂、马拉松、传统节庆等文化体验活动，支持活动场馆关联、时间安排、报名审批和活动详情展示。

### 用户互动

支持用户收藏景区、场馆和活动，支持活动报名申请与审批，支持活动评论和回复。

## 后端启动

### 环境要求

- JDK 17 或更高版本
- Maven 3.8+
- MySQL 8+

> 注意：项目需要使用 Java 17+。如果历史文档中出现 Java 8 配置，请以 Java 17+ 为准。

### 初始化数据库

按需导入以下 SQL 文件：

```text
ruoyi.sql
ruoyi数据库.sql
tourism_database_create.sql
```

然后根据本地 MySQL 配置调整后端配置文件中的数据库连接信息。

### 编译与运行

```bash
mvn clean compile
```

```bash
cd cquet-admin
mvn spring-boot:run
```

### 常用后端命令

```bash
# 运行测试
mvn test

# 运行单个测试类
mvn test -Dtest=ClassName

# 打包
mvn clean package
```

## 后台管理前端启动

```bash
cd cquet-ui-demo
npm install
npm run dev
```

常用命令：

```bash
# 生产构建
npm run build:prod

# 预发布构建
npm run build:stage

# 代码检查
npm run lint
```

## 用户端前端启动

```bash
cd cquet-user
npm install
npm run dev
```

常用命令：

```bash
# 类型检查并构建
npm run build

# 本地预览构建结果
npm run preview

# 代码检查并自动修复
npm run lint
```

## API 代理

前端开发环境默认将后端 API 请求代理到本地后端服务，通常为：

```text
http://localhost:8080
```

启动前端页面前，请先确认后端服务和数据库已正常运行。

## 重要说明

- 当前仓库同时包含后台管理前端和用户端前端，开发时请确认进入正确目录执行命令。
- 后端基于若依框架扩展，系统管理、权限、菜单、字典等能力来自若依基础模块。
- 旅游业务代码主要位于 `cquet-tourism`，用户端页面主要位于 `cquet-user`。
- `cquet-admin` 中的 Spring Boot Maven 插件版本可能与父 POM 依赖版本存在历史不一致，实际开发请以父 POM 的 Spring Boot 3.3.2 和 Java 17+ 为准。
- 图片上传复用若依现有文件上传能力。

## 后续规划

- 智能景区推荐
- 个性化旅游路线规划
- 文化体验活动推荐
- 多语言内容辅助生成
- 用户行为数据分析和运营看板

## 许可证

本项目使用 Apache License 2.0，详见 `LICENSE`。
