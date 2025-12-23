package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.service.TourismActivityService;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
import cn.edu.cquet.tourism.domain.vo.TourismActivityVo;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/activity-approval")
@Tag(name = "特色活动审批")
public class TourismActivityApprovalController extends BaseController {

    @Autowired
    private TourismActivityService activityService;

    @Autowired
    private TourismActivityApprovalService approvalService;

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:list')")
    @GetMapping("/list")
    @Operation(summary = "待审核活动列表")
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

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:history')")
    @GetMapping("/{activityId}/history")
    @Operation(summary = "查看审批历史")
    public Result history(@PathVariable Long activityId) {
        List<TourismActivityApproval> list = approvalService.history(activityId);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:approve')")
    @Log(title = "特色活动审批", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/pass")
    @Operation(summary = "审批通过")
    public Result pass(@PathVariable Long id,
                       @RequestParam(required = false) String opinion,
                       @RequestBody(required = false) java.util.Map<String, String> body) {
        String op = opinion;
        if ((op == null || op.isBlank()) && body != null) op = body.get("opinion");
        return toAjax(approvalService.approve(id, op));
    }

    @PreAuthorize("@ss.hasPermi('tourism:activityApplication:reject')")
    @Log(title = "特色活动审批", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/reject")
    @Operation(summary = "审批拒绝")
    public Result reject(@PathVariable Long id,
                         @RequestParam(required = false) String reason,
                         @RequestBody(required = false) java.util.Map<String, String> body) {
        String r = reason;
        if ((r == null || r.isBlank()) && body != null) r = body.get("reason");
        if (r == null || r.isBlank()) return warn("请提供审核不通过原因");
        return toAjax(approvalService.reject(id, r));
    }

    private TourismActivityVo toVo(TourismActivity a) {
        TourismActivityVo vo = new TourismActivityVo();
        BeanUtils.copyProperties(a, vo);
        java.util.List<TourismActivityApproval> h = approvalService.history(a.getId());
        TourismActivityApproval latest = (h == null || h.isEmpty()) ? null : h.get(0);
        if (latest == null) { vo.setAuditStatus("0"); }
        else { vo.setAuditStatus(latest.getAuditStatus()); vo.setAuditReason(latest.getReason()); vo.setAuditor(latest.getAuditor()); vo.setAuditTime(latest.getAuditTime()); }
        return vo;
    }
}