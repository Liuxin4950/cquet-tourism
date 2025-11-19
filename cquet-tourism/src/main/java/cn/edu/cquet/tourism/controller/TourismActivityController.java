package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.domain.vo.TourismActivityVo;
import cn.edu.cquet.tourism.service.TourismActivityService;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
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

    @Autowired
    private TourismActivityApprovalService approvalService;

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
        java.util.List<TourismActivity> list = activityService.list(name, venueId, auditStatus);
        java.util.List<TourismActivityVo> vos = new java.util.ArrayList<>(list.size());
        for (TourismActivity a : list) {
            vos.add(toVo(a));
        }
        return getDataTable(vos);
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
        return success(toVo(a));
    }

    private TourismActivityVo toVo(TourismActivity a) {
        TourismActivityVo vo = new TourismActivityVo();
        BeanUtils.copyProperties(a, vo);
        java.util.List<TourismActivityApproval> h = approvalService.history(a.getId());
        TourismActivityApproval latest = (h == null || h.isEmpty()) ? null : h.get(0);
        if (latest == null) { vo.setAuditStatus("0"); } else { vo.setAuditStatus(latest.getAuditStatus()); vo.setAuditReason(latest.getReason()); vo.setAuditor(latest.getAuditor()); vo.setAuditTime(latest.getAuditTime()); }
        return vo;
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
        try {
            boolean ok = activityService.create(activity);
            if (!ok) return warn("活动名称重复或同一场馆同时间段已被占用");
            return success(activity);
        } catch (Exception e) {
            return warn(e.getMessage() != null ? e.getMessage() : "新增失败");
        }
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
        return toAjax(approvalService.approve(id, op));
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
        return toAjax(approvalService.reject(id, r));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activity:remove')")
    @Log(title = "特色活动", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @Operation(summary = "删除特色活动")
    public Result remove(@PathVariable java.util.List<Long> ids) {
        return toAjax(activityService.removeByIds(ids));
    }
}