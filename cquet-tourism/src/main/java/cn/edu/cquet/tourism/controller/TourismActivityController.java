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
public class TourismActivityController extends BaseController {

    @Autowired
    private TourismActivityService activityService;

    @PreAuthorize("@ss.hasPermi('tourism:activity:list')")
    @GetMapping("/list")
    @Operation(summary = "活动列表（含审核状态筛选）")
    public TableDataInfo list(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer venueId,
                              @RequestParam(required = false) String auditStatus) {
        startPage();
        return getDataTable(activityService.list(name, venueId, auditStatus));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:query')")
    @GetMapping("/{id}")
    @Operation(summary = "活动详情")
    public Result detail(@PathVariable Long id) {
        TourismActivity a = activityService.detail(id);
        if (a == null) return warn("活动不存在");
        return success(a);
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:edit')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}/status/{status}")
    @Operation(summary = "活动状态管理：暂停/启动")
    public Result updateStatus(@PathVariable Long id, @PathVariable String status) {
        return toAjax(activityService.updateStatus(id, status));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:add')")
    @Log(title = "特色活动", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增特色活动")
    public Result add(@RequestBody TourismActivity activity) {
        if (activity.getId() != null) return warn("新增不需要指定id");
        return toAjax(activityService.create(activity));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:edit')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改特色活动")
    public Result edit(@RequestBody TourismActivity activity) {
        if (activity.getId() == null) return warn("修改时，id不能为空");
        return toAjax(activityService.update(activity));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:approve')")
    @Log(title = "特色活动", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/approve")
    @Operation(summary = "审核通过")
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
    public Result reject(@PathVariable Long id,
                         @RequestParam(required = false) String reason,
                         @RequestBody(required = false) java.util.Map<String, String> body) {
        String r = reason;
        if ((r == null || r.isBlank()) && body != null) r = body.get("reason");
        if (r == null || r.isBlank()) return warn("请提供审核不通过原因");
        return toAjax(activityService.reject(id, r));
    }
}