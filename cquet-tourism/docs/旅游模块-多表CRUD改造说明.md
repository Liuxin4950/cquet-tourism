# 旅游模块多表 CRUD 改造说明

本文档说明景区与场馆在“图片、设备等原子化表结构”改造后的多表查询与 CRUD 设计与实现，涵盖数据模型、服务层事务逻辑、控制器权限、接口示例与性能策略，便于快速对接与维护。

## 目标
- 将原先 `imagesUrl`/`devices` 等聚合字段改为原子化表结构，通过关联表维护关系。
- 后台管理端支持景区与场馆的新增、修改、删除与详情查询；列表分页只查主表，详情返回完整关联。
- 遵循若依权限与审计规范（操作日志、权限字符串、逻辑删除）。

## 表与关系
- 主表
  - `tourism_scenic_spot`：景区主数据
  - `tourism_venue`：场馆主数据
- 子表
  - `tourism_image`：图片资源
  - `tourism_facilities`：设备/设施字典
- 关联表
  - `tourism_scenic_spot_image`：景区-图片 多对多
  - `tourism_venue_image`：场馆-图片 多对多
  - `tourism_venue_facilities`：场馆-设施 多对多

> 说明：关联/字典表通常不含公共审计字段，实体不应继承公共基类，否则会产生列不匹配的 SQL。

## 领域模型
- 主实体（请求扩展字段，仅用于接收参数，不入库）
  - 景区：`TourismScenicSpot#imageIds`
    - 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/TourismScenicSpot.java:80`
  - 场馆：`TourismVenue#imageIds`、`TourismVenue#facilitiesIds`
    - 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/TourismVenue.java:98`
- 详情 VO（接口返回完整关联）
  - 景区：`ScenicSpotDetailVo`（含 `images`）
    - 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/vo/ScenicSpotDetailVo.java:1`
  - 场馆：`VenueDetailVo`（含 `images`、`facilities`）
    - 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/vo/VenueDetailVo.java:1`
- 关联/字典实体（不继承审计基类，避免列不匹配）
  - `TourismScenicSpotImage`、`TourismVenueImage`、`TourismVenueFacilities`、`TourismImage`、`TourismFacilities`
    - 路径：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/*.java`

## 数据访问层（Mapper）
- 新增基础 Mapper（BaseMapper）
  - `TourismImageMapper`
  - `TourismScenicSpotImageMapper`
  - `TourismVenueImageMapper`
  - `TourismFacilitiesMapper`
  - `TourismVenueFacilitiesMapper`
- 路径：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/mapper/*.java`

## 服务层逻辑
### 景区 Service 实现
- 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/service/impl/TourismScenicSpotServiceImpl.java`
- 列表（仅主表分页查询，过滤未删除）
  - 位置：`36-58`
- 新增（事务）
  - 插入主表 → 批量插入 `tourism_scenic_spot_image` 关联
  - 位置：`61-82`
- 修改（事务）
  - 更新主表 → 清空旧关联 → 重建关联
  - 位置：`85-114`
- 删除（事务）
  - 先清理关联 → 逻辑删除主表
  - 位置：`116-129`
- 详情（聚合图片）
  - 主表查询 → 通过关联表批量查图片 → 组装 `ScenicSpotDetailVo`
  - 位置：`141-178`

### 场馆 Service 实现
- 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/service/impl/TourismVenueServiceImpl.java`
- 列表（仅主表分页查询，过滤未删除）
  - 位置：`49-58`
- 新增（事务）
  - 插入主表 → 批量插入 `tourism_venue_image`、`tourism_venue_facilities`
  - 位置：`61-89`
- 修改（事务）
  - 更新主表 → 清空旧图片与设施关联 → 重建关联
  - 位置：`92-126`
- 删除（事务）
  - 清理图片与设施关联 → 逻辑删除主表
  - 位置：`177-190`
- 详情（聚合图片与设备）
  - 主表查询 → 批量查图片与设备 → 组装 `VenueDetailVo`
  - 位置：`128-175`

## 控制器与权限
### 景区 Controller
- 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/controller/TourismScenicSpotController.java`
- 接口与权限
  - 列表 GET `/tourism/scenic-spot/list` → `tourism:scenic-spot:list`（`31-40`）
  - 详情 GET `/{id}` → `tourism:scenic-spot:query`，返回 `ScenicSpotDetailVo`（`42-51`）
  - 新增 POST → `tourism:scenic-spot:add`，日志 INSERT（`53-66`）
  - 修改 PUT → `tourism:scenic-spot:edit`，日志 UPDATE（`68-81`）
  - 删除 DELETE `/{ids}` → `tourism:scenic-spot:remove`，日志 DELETE（`83-93`）

### 场馆 Controller
- 文件：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/controller/tourismVenueController.java`
- 接口与权限
  - 列表 GET `/tourism/venue/list` → `tourism:venue:list`（`32-41`）
  - 详情 GET `/{id}` → `tourism:venue:query`，返回 `VenueDetailVo`（`43-52`）
  - 新增 POST → `tourism:venue:add`，日志 INSERT（`54-63`）
  - 修改 PUT → `tourism:venue:edit`，日志 UPDATE（`65-74`）
  - 删除 DELETE `/{ids}` → `tourism:venue:remove`，日志 DELETE（`76-82`）

## 请求与响应示例
### 场馆新增
```json
{
  "name": "XX场馆",
  "category": "博物馆",
  "coverImage": "http://xx/cover.jpg",
  "ticketPrice": 50,
  "address": "XX市XX区XX路",
  "city": "XX市",
  "district": "XX区",
  "openingHours": "09:00-17:30",
  "contactPhone": "13800138000",
  "website": "https://example.com",
  "description": "……",
  "longitude": 121.48,
  "latitude": 31.23,
  "capacity": 5000,
  "bookingRequired": "0",
  "status": "0",
  "imageIds": [10, 11],
  "facilitiesIds": [1001, 1002]
}
```

### 场馆详情响应（节选）
```json
{
  "id": 1,
  "name": "XX场馆",
  "images": [{ "id": 10, "url": "..." }],
  "facilities": [{ "id": 1001, "facilitiesName": "停车场" }]
}
```

### 景区新增（与场馆类似）
- 关键点：提交 `imageIds` 用于建立 `tourism_scenic_spot_image` 关联
- 详情返回 `images` 数组

## 分页与多表策略
- 列表接口仅查主表并分页，确保性能与响应体可控；完整子项在详情接口返回。
- 如需“列表携带首图/计数”的轻量富集：建议新增列表 VO，在服务层用“本页 ID→IN 批量查询→Map 聚合”的方式装配，不做联表。

## 常见问题与解决
- Unknown column 报错（如 `create_time`）
  - 原因：关联/字典表没有公共审计字段，但实体继承了 `AbsEntity`，MyBatis-Plus 会拼接这些列。
  - 处理：取消相关实体对 `AbsEntity` 的继承，实体仅保留实际存在列。

## 数据一致性与删除策略
- 主表（景区/场馆）保留审计与逻辑删除（`delFlag`）。
- 关联表采取物理清理：
  - 新增/修改：重建关联（先删后插）。
  - 删除：先清理关联，再逻辑删除主表。

## 权限配置（若依后台）
- 景区：`tourism:scenic-spot:list|query|add|edit|remove`
- 场馆：`tourism:venue:list|query|add|edit|remove`
- 需在菜单中将这些权限字符串配置到对应的菜单/按钮。

## 变更文件清单（关键）
- 控制器
  - 景区：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/controller/TourismScenicSpotController.java`
  - 场馆：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/controller/tourismVenueController.java`
- 服务层
  - 景区实现：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/service/impl/TourismScenicSpotServiceImpl.java`
  - 场馆实现：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/service/impl/TourismVenueServiceImpl.java`
  - 服务接口：`cquet-tourism/src/main/java/cn/edu/cquet/tourism/service/*.java`
- Mapper
  - `cquet-tourism/src/main/java/cn/edu/cquet/tourism/mapper/*.java`
- 实体与 VO
  - `cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/*.java`
  - `cquet-tourism/src/main/java/cn/edu/cquet/tourism/domain/vo/*.java`

---
如需“列表携带首图与计数”的轻量富集或导出/导入能力，可在此基础上追加实现，保留当前分页与权限策略不变。