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
@RequestMapping("tourism/activityApplication")
@Tag(name = "特色活动申报管理")
/**
 * 特色活动申报管理接口层
 *
 * 说明：为活动的审核环节提供列表与审核动作（通过/不通过）。
 */
public class TourismActivityApplicationController extends BaseController {

    @Autowired
    private TourismActivityService activityService;

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:list')")
    @GetMapping("/list")
    @Operation(summary = "申报列表（含待审核/通过/不通过）")
    /**
     * 申报列表查询
     * 入参：`name`、`venueId`、`auditStatus` 均可选
     */
    public TableDataInfo list(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer venueId,
                              @RequestParam(required = false) String auditStatus) {
        startPage();
        return getDataTable(activityService.list(name, venueId, auditStatus));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:approve')")
    @Log(title = "特色活动申报", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/approve")
    @Operation(summary = "审核通过（同步审核意见/审核人/审核时间）")
    /**
     * 审核通过
     * 入参：`id`、可选 `opinion`（表单或 JSON 体）
     */
    public Result approve(@PathVariable Long id,
                          @RequestParam(required = false) String opinion,
                          @RequestBody(required = false) java.util.Map<String, String> body) {
        String op = opinion;
        if ((op == null || op.isBlank()) && body != null) op = body.get("opinion");
        return toAjax(activityService.approve(id, op));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:reject')")
    @Log(title = "特色活动申报", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/reject")
    @Operation(summary = "审核不通过（同步审核意见/审核人/审核时间）")
    /**
     * 审核不通过
     * 入参：`id`、可选 `reason`（表单或 JSON 体），必须提供有效原因
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
