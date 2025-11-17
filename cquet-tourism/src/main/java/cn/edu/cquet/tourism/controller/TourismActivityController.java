package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.service.TourismActivityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("tourism/activity")
@Tag(name = "特色活动管理")
/**
 * 特色活动管理接口层
 *
 * 说明：活动具备审核流转（通过/不通过）、启停状态等业务字段；本控制器提供列表、详情、状态更新、创建与修改、审核动作。
 */
public class TourismActivityController extends BaseController {

    @Autowired
    private TourismActivityService activityService;

    @PreAuthorize("@ss.hasPermi('tourism:activity:list')")
    @GetMapping("/list")
    @Operation(summary = "活动列表（含审核状态筛选）")
    /**
     * 列表查询
     * 入参：`name`（活动名称模糊）、`venueId`（所属场馆）、`auditStatus`（审核状态）均可选
     * 返回：分页 `TableDataInfo`
     */
    public TableDataInfo list(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer venueId,
                              @RequestParam(required = false) String auditStatus) {
        startPage();
        return getDataTable(activityService.list(name, venueId, auditStatus));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:query')")
    @GetMapping("/{id}")
    @Operation(summary = "活动详情")
    /**
     * 详情查询
     * 入参：路径参数 `id`
     * 返回：`Result` 包装的 `TourismActivity`，不存在则返回警告
     */
    public Result detail(@PathVariable Long id) {
        TourismActivity a = activityService.detail(id);
        if (a == null) return warn("活动不存在");
        return success(a);
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:edit')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}/status/{status}")
    @Operation(summary = "活动状态管理：暂停/启动")
    /**
     * 更新活动状态
     * 路径：`PUT /tourism/activity/{id}/status/{status}`
     * 入参：`status` 取值约定：启动/暂停等（由服务层校验）
     */
    public Result updateStatus(@PathVariable Long id, @PathVariable String status) {
        return toAjax(activityService.updateStatus(id, status));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:add')")
    @Log(title = "特色活动", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增特色活动")
    /**
     * 新增
     * 约束：新增不需要指定 `id`
     */
    public Result add(@RequestBody TourismActivity activity) {
        if (activity.getId() != null) return warn("新增不需要指定id");
        return toAjax(activityService.create(activity));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:edit')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改特色活动")
    /**
     * 修改
     * 约束：必须指定 `id`
     */
    public Result edit(@RequestBody TourismActivity activity) {
        if (activity.getId() == null) return warn("修改时，id不能为空");
        return toAjax(activityService.update(activity));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:approve')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/approve")
    @Operation(summary = "审核通过")
    /**
     * 审核通过
     * 入参：路径参数 `id`；可选 `opinion`（表单或 JSON 体）
     */
    public Result approve(@PathVariable Long id,
                          @RequestParam(required = false) String opinion,
                          @RequestBody(required = false) java.util.Map<String, String> body) {
        String op = opinion;
        if ((op == null || op.isBlank()) && body != null) op = body.get("opinion");
        return toAjax(activityService.approve(id, op));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:reject')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/reject")
    @Operation(summary = "审核不通过")
    /**
     * 审核不通过
     * 入参：路径参数 `id`；可选 `reason`（表单或 JSON 体）；必须提供有效原因
     */
    public Result reject(@PathVariable Long id,
                         @RequestParam(required = false) String reason,
                         @RequestBody(required = false) java.util.Map<String, String> body) {
        String r = reason;
        if ((r == null || r.isBlank()) && body != null) r = body.get("reason");
        if (r == null || r.isBlank()) return warn("请提供审核不通过原因");
        return toAjax(activityService.reject(id, r));
    }
}