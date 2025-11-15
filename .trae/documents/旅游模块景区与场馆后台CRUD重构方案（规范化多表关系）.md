## 目标
- 将“景区”“场馆”改为基于原子化表结构的完整后台管理CRUD，兼容分页列表、详情、添加、修改、删除。
- 适配你已新增的规范化表（图片表、图片关联表、设备表、设备关联表），正确维护多对多/一对多关系。
- 严格按若依权限与审计规范添加权限校验与操作日志。

## 影响范围
- 控制器：`TourismScenicSpotController`、`tourismVenueController`（建议规范为 `TourismVenueController`）。
- 服务层：`TourismScenicSpotService`/Impl、`TourismVenueService`/Impl。
- 数据访问：新增关联与子表的Mapper；必要时新增Mapper XML或批量查询方法。
- VO/请求模型：新增详情VO；在实体上增加仅用于请求的非持久化字段或单独DTO，用于接收`imageIds`/`facilitiesIds`。

## 数据模型与Mapper
- 已有实体：
  - `tourism_scenic_spot` → `TourismScenicSpot`
  - `tourism_venue` → `TourismVenue`
  - `tourism_image` → `TourismImage`
  - `tourism_scenic_spot_image` → `TourismScenicSpotImage`
  - `tourism_venue_image` → `TourismVenueImage`
  - `tourism_facilities` → `TourismFacilities`
  - `tourism_venue_facilities` → `TourismVenueFacilities`
- 新增Mapper接口（BaseMapper即可，后续服务层组合查询）：
  - `TourismImageMapper`
  - `TourismScenicSpotImageMapper`
  - `TourismVenueImageMapper`
  - `TourismFacilitiesMapper`
  - `TourismVenueFacilitiesMapper`
- 如需复杂聚合（列表联表一次性返回）再补充对应的Mapper XML方法；首版先采用“主表分页 + 子表二次批量查询(IN)”方案，简化实现、保持分页正确。

## VO/请求体设计
- 为避免过多DTO，按若依常见实践在主实体上增加仅请求用字段（`@TableField(exist=false)`）：
  - `TourismScenicSpot`: `List<Integer> imageIds`
  - `TourismVenue`: `List<Integer> imageIds`, `List<Integer> facilitiesIds`
- 新增详情VO：
  - `ScenicSpotDetailVo`: 基本字段 + `List<TourismImage> images`
  - `VenueDetailVo`: 基本字段 + `List<TourismImage> images` + `List<TourismFacilities> facilities`

## 接口与权限
- 景区 `@RequestMapping("tourism/scenic-spot")`
  - GET `/list` 分页查询（已有）；权限：`@PreAuthorize("@ss.hasPermi('tourism:scenic-spot:list')")`
  - GET `/{id}` 详情（返回 `ScenicSpotDetailVo`）；权限：`tourism:scenic-spot:query`
  - POST 新增（接收`TourismScenicSpot`含`imageIds`）；权限：`tourism:scenic-spot:add`，日志：`@Log(title="A级景区", businessType=INSERT)`
  - PUT 修改（接收`TourismScenicSpot`含`imageIds`）；权限：`tourism:scenic-spot:edit`，日志：UPDATE
  - DELETE `/{ids}` 删除（逻辑删主表并清理关联）；权限：`tourism:scenic-spot:remove`，日志：DELETE
- 場馆 `@RequestMapping("tourism/venue")`
  - GET `/list`（已有名称/地址筛选）；权限：`tourism:venue:list`
  - GET `/{id}` 详情（返回 `VenueDetailVo`）；权限：`tourism:venue:query`
  - POST 新增（接收`TourismVenue`含`imageIds`、`facilitiesIds`）；权限：`tourism:venue:add`，日志：INSERT
  - PUT 修改（同上）；权限：`tourism:venue:edit`，日志：UPDATE
  - DELETE `/{ids}` 删除（逻辑删并清理关联）；权限：`tourism:venue:remove`，日志：DELETE
- 说明：这些权限字符串需在若依菜单中配置到对应菜单按钮。

## 服务层实现要点（事务）
- 新增：
  - 插入主表记录，拿到主键ID。
  - 批量插入关联表记录（图片/设备），支持`sort`可选。
- 修改：
  - 更新主表。
  - 先物理删除旧的关联，再批量插入新的关联（保证幂等）。
- 删除：
  - 主表逻辑删除（`delFlag`=2）。
  - 物理清理关联表记录。
- 列表：
  - 按现有条件分页查询主表。
  - 取出本页ID集合，分别批量查询图片/设备并`Map<主表ID, List<子项>>`聚合；
  - 列表页一般显示封面或数量即可，完整子项放到详情接口。
- 详情：
  - 查询主表。
  - 通过关联表批量拿到图片与设备，组装到VO。
- 全部`@Transactional(rollbackFor=Exception.class)`保证一致性。

## 校验与公共字段
- 新增时校验主键为空、名称唯一（已有校验基础保持）。
- 修改时校验主键存在、名称唯一（排除自身）。
- 统一设置`createBy/updateBy`使用`BaseController#getUsername()`。
- 过滤`delFlag=0`数据（列表/详情）。

## 控制器调整与规范
- 按若依风格补充：`@PreAuthorize`、`@Log`（`cn.edu.cquet.common.enums.BusinessType`）、`toAjax/success/error`统一返回。
- `tourismVenueController`重命名为`TourismVenueController`以保持类名规范（仅代码层变更，不影响路由）。

## 验证与交付
- 自测用例：
  - 新增景区/场馆（带多张图片、多个设备）→ 查询详情返回完整关联。
  - 修改（替换/新增/减少图片与设备）→ 关联正确同步。
  - 删除 → 主表`delFlag=2`，关联表记录被清理。
  - 分页列表 → 条件筛选、分页正确。
- 提供示例请求JSON与响应示例，确保前端管理端可直接对接。

## 预计变更文件（示例）
- 新增：`mapper/*Mapper.java`（Image/关联/设备），必要时对应`resources/mapper/tourism/*.xml`
- 更新：
  - `controller/TourismScenicSpotController.java`
  - `controller/tourismVenueController.java`（或重命名）
  - `service/impl/TourismScenicSpotServiceImpl.java`
  - `service/impl/TourismVenueServiceImpl.java`
  - `domain/TourismScenicSpot.java`、`domain/TourismVenue.java`（添加`@TableField(exist=false)`集合字段）
  - 新增VO：`domain/vo/ScenicSpotDetailVo.java`、`domain/vo/VenueDetailVo.java`

是否按该方案实施并提交代码修改？确认后我将一次性完成上述变更与自测，并给出接口示例。