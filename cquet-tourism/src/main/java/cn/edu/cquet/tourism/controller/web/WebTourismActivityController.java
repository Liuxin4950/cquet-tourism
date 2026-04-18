package cn.edu.cquet.tourism.controller.web;

import cn.edu.cquet.common.annotation.Anonymous;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.domain.vo.TourismActivityVo;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
import cn.edu.cquet.tourism.service.TourismActivityService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("web/tourism/activity")
@Tag(name = "用户端特色活动")
public class WebTourismActivityController extends BaseController {

    @Autowired
    private TourismActivityService activityService;

    @Autowired
    private TourismActivityApprovalService approvalService;

    @Anonymous
    @GetMapping("/list")
    @Operation(summary = "用户端活动列表")
    public TableDataInfo list(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer venueId,
                              @RequestParam(required = false) String auditStatus) {
        startPage();
        List<TourismActivity> list = activityService.list(name, venueId, auditStatus);
        List<TourismActivityVo> vos = new ArrayList<>(list.size());
        for (TourismActivity activity : list) {
            vos.add(toVo(activity));
        }
        return getDataTable(vos);
    }

    @Anonymous
    @GetMapping("/{id}")
    @Operation(summary = "用户端活动详情")
    public Result detail(@PathVariable Long id) {
        TourismActivity activity = activityService.detail(id);
        if (activity == null) {
            return warn("活动不存在");
        }
        return success(toVo(activity));
    }

    private TourismActivityVo toVo(TourismActivity activity) {
        TourismActivityVo vo = new TourismActivityVo();
        BeanUtils.copyProperties(activity, vo);
        List<TourismActivityApproval> history = approvalService.history(activity.getId());
        TourismActivityApproval latest = (history == null || history.isEmpty()) ? null : history.get(0);
        if (latest == null) {
            vo.setAuditStatus("0");
        } else {
            vo.setAuditStatus(latest.getAuditStatus());
            vo.setAuditReason(latest.getReason());
            vo.setAuditor(latest.getAuditor());
            vo.setAuditTime(latest.getAuditTime());
        }
        return vo;
    }
}
