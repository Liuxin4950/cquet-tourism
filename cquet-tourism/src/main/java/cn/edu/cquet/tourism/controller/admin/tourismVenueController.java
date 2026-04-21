package cn.edu.cquet.tourism.controller.admin;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.service.TourismVenueService;
import org.springframework.web.bind.annotation.RequestParam;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;
import cn.edu.cquet.tourism.domain.vo.TourismActivityVo;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;

import java.util.List;

@RestController
@RequestMapping("tourism/venue")
@Tag(name = "场馆信息")
/**
 * 场馆信息接口层
 *
 * 说明：
 * - 提供场馆的增删改查、详情与活动列表查询等接口。
 * - 继承 `BaseController`，统一分页、返回格式与Ajax结果转换。
 * - 使用 `@PreAuthorize` 控制权限，`@Log` 记录操作日志。
 * - 通过 `@Operation` 与 `@Tag` 输出接口文档。
 */
public class tourismVenueController extends BaseController {

    @Autowired
    private TourismVenueService tourismVenueService;

    @Autowired
    private cn.edu.cquet.tourism.service.TourismActivityApprovalService approvalService;

    @GetMapping("/list")
    @PreAuthorize("@ss.hasPermi('tourism:venue:list')")
    @Operation(summary = "获取场馆列表")
    /**
     * 列表查询
     *
     * 路径：`GET /tourism/venue/list`
     * 权限：`tourism:venue:list`
     * 入参：`name`、`address`（均为可选模糊查询条件）
     * 返回：分页表格数据 `TableDataInfo`
     */
    public TableDataInfo getList(@RequestParam(required = false) String name,
                                 @RequestParam(required = false) String address,
                                 @RequestParam(required = false) String city,
                                 @RequestParam(required = false) String district,
                                 @RequestParam(required = false) String category,
                                 @RequestParam(required = false) String status) {
        startPage();
        List<TourismVenue> list = tourismVenueService.getVenueList(name, address, city, district, category, status);
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @PreAuthorize("@ss.hasPermi('tourism:venue:query')")
    @Operation(summary = "获取场馆信息")
    /**
     * 详情查询
     *
     * 路径：`GET /tourism/venue/{id}`
     * 权限：`tourism:venue:query`
     * 入参：路径参数 `id`
     * 返回：`Result` 包装的 `VenueDetailVo`，为空则返回警告"场馆不存在"
     */
    public Result getInfo(@PathVariable Long id) {
        VenueDetailVo venue = tourismVenueService.getDetail(id);
        if (venue == null) {
            return warn("场馆不存在");
        }
        return success(venue);
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:add')")
    @Log(title = "场馆管理", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增场馆")
    /**
     * 新增
     *
     * 路径：`POST /tourism/venue`
     * 权限：`tourism:venue:add`
     * 入参：请求体 `TourismVenue`
     * 约束：新增无需指定 `id`
     * 返回：统一 `Result`（`toAjax` 将受影响行数转换为布尔/成功失败）
     */
    public Result add(@RequestBody @Validated TourismVenue venue) {
        if (venue.getId() != null) {
            return warn("新增不需要指定id");
        }
        boolean ok = tourismVenueService.addVenue(venue);
        if (!ok) return warn("该场馆已存在或新增失败");
        return success(venue);
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:edit')")
    @Log(title = "场馆管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改场馆")
    /**
     * 修改
     *
     * 路径：`PUT /tourism/venue`
     * 权限：`tourism:venue:edit`
     * 入参：请求体 `TourismVenue`
     * 约束：必须指定 `id`
     * 返回：统一 `Result`
     */
    public Result edit(@RequestBody @Validated TourismVenue venue) {
        if (venue.getId() == null) {
            return warn("修改时，id不能为空");
        }
        return toAjax(tourismVenueService.updateVenue(venue));
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:remove')")
    @Log(title = "场馆管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @Operation(summary = "删除场馆")
    /**
     * 删除
     *
     * 路径：`DELETE /tourism/venue/{ids}`
     * 权限：`tourism:venue:remove`
     * 入参：路径参数 `ids`
     * 返回：统一 `Result`
     */
    public Result remove(@PathVariable List<Long> ids) {
        return toAjax(tourismVenueService.removeVenueByIds(ids));
    }

    @GetMapping("/{id}/activities")
    @PreAuthorize("@ss.hasPermi('tourism:venueActivity:list')")
    @Operation(summary = "查看当前场馆的特色活动列表")
    /**
     * 查询场馆下的特色活动列表
     *
     * 路径：`GET /tourism/venue/{id}/activities`
     * 权限：`tourism:venueActivity:list`
     * 入参：路径参数 `id`
     * 返回：`Result` 包装的活动列表（含审批派生字段）
     */
    public Result activities(@PathVariable Long id) {
        if (id == null) {
            return warn("场馆id不能为空");
        }
        List<TourismActivity> list = tourismVenueService.getActivitiesByVenueId(id);
        java.util.Map<Long, TourismActivityApproval> latestMap = approvalService.latestByActivityIds(
                list.stream().map(TourismActivity::getId).toList()
        );
        java.util.List<TourismActivityVo> vos = new java.util.ArrayList<>(list.size());
        for (TourismActivity a : list) {
            TourismActivityVo vo = new TourismActivityVo();
            vo.setId(a.getId()); vo.setName(a.getName()); vo.setCategory(a.getCategory()); vo.setStartTime(a.getStartTime()); vo.setEndTime(a.getEndTime());
            vo.setStatus(a.getStatus());
            vo.setCoverImage(a.getCoverImage());
            vo.setCoverImageId(a.getCoverImageId());
            TourismActivityApproval latest = latestMap.get(a.getId());
            vo.setAuditStatus(a.getAuditStatus() != null ? a.getAuditStatus() : "0");
            if (latest != null) { vo.setAuditStatus(latest.getAuditStatus()); vo.setAuditReason(latest.getReason()); vo.setAuditor(latest.getAuditor()); vo.setAuditTime(latest.getAuditTime()); }
            vos.add(vo);
        }
        return success(vos);
    }


    @GetMapping("/{id}/images")
    @PreAuthorize("@ss.hasPermi('tourism:venue:image:list')")
    @Operation(summary = "查看当前场馆的关联图片列表")
    public Result venueImages(@PathVariable Long id) {
        if (id == null) return warn("场馆id不能为空");
        List<TourismImage> images = tourismVenueService.getImagesByVenue(id);
        return success(images);
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:image:edit')")
    @PutMapping("/{id}/images")
    @Operation(summary = "设置当前场馆的关联图片（覆盖式）")
    public Result setVenueImages(@PathVariable Long id, @RequestBody List<Long> imageIds) {
        if (id == null) return warn("场馆id不能为空");
        return toAjax(tourismVenueService.setImagesForVenue(id, imageIds));
    }
}
