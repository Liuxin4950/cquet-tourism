package cn.edu.cquet.tourism.controller.web;

import cn.edu.cquet.common.annotation.Anonymous;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.domain.vo.TourismActivityVo;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
import cn.edu.cquet.tourism.service.TourismVenueService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("web/tourism/venue")
@Tag(name = "用户端场馆")
public class WebTourismVenueController extends BaseController {

    @Autowired
    private TourismVenueService tourismVenueService;

    @Autowired
    private TourismActivityApprovalService approvalService;

    @Anonymous
    @GetMapping("/list")
    @Operation(summary = "用户端获取场馆列表")
    public TableDataInfo getList(@RequestParam(required = false) String name,
                                 @RequestParam(required = false) String address,
                                 @RequestParam(required = false) String city) {
        startPage();
        List<TourismVenue> list = tourismVenueService.getVenueList(name, address, city);
        return getDataTable(list);
    }

    @Anonymous
    @GetMapping("/{id}")
    @Operation(summary = "用户端获取场馆详情")
    public Result getInfo(@PathVariable Long id) {
        VenueDetailVo venue = tourismVenueService.getDetail(id);
        if (venue == null) {
            return warn("场馆不存在");
        }
        return success(venue);
    }

    @Anonymous
    @GetMapping("/{id}/activities")
    @Operation(summary = "用户端查看场馆活动列表")
    public Result activities(@PathVariable Long id) {
        if (id == null) {
            return warn("场馆id不能为空");
        }
        List<TourismActivity> list = tourismVenueService.getActivitiesByVenueId(id);
        Map<Long, TourismActivityApproval> latestMap = approvalService.latestByActivityIds(
                list.stream().map(TourismActivity::getId).toList()
        );
        List<TourismActivityVo> vos = new ArrayList<>(list.size());
        for (TourismActivity activity : list) {
            TourismActivityVo vo = new TourismActivityVo();
            vo.setId(activity.getId());
            vo.setName(activity.getName());
            vo.setCoverImage(activity.getCoverImage());
            vo.setCoverImageId(activity.getCoverImageId());
            vo.setCategory(activity.getCategory());
            vo.setStartTime(activity.getStartTime());
            vo.setEndTime(activity.getEndTime());
            vo.setStatus(activity.getStatus());
            TourismActivityApproval latest = latestMap.get(activity.getId());
            vo.setAuditStatus(activity.getAuditStatus() != null ? activity.getAuditStatus() : "0");
            if (latest != null) {
                vo.setAuditStatus(latest.getAuditStatus());
                vo.setAuditReason(latest.getReason());
                vo.setAuditor(latest.getAuditor());
                vo.setAuditTime(latest.getAuditTime());
            }
            vos.add(vo);
        }
        return success(vos);
    }

    @Anonymous
    @GetMapping("/{id}/images")
    @Operation(summary = "用户端查看场馆图片列表")
    public Result venueImages(@PathVariable Long id) {
        if (id == null) {
            return warn("场馆id不能为空");
        }
        List<TourismImage> images = tourismVenueService.getImagesByVenue(id);
        return success(images);
    }
}
