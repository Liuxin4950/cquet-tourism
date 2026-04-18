package cn.edu.cquet.tourism.controller.admin;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.tourism.service.TourismDashboardService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/tourism/dashboard")
@Tag(name = "数据大屏统计")
public class TourismDashboardController extends BaseController {

    @Autowired
    private TourismDashboardService dashboardService;

    @PreAuthorize("@ss.hasPermi('tourism:dashboard:statistics')")
    @GetMapping("/statistics")
    @Operation(summary = "获取统计数据")
    public Result getStatistics() {
        return success(dashboardService.getStatistics());
    }

    @PreAuthorize("@ss.hasPermi('tourism:dashboard:district')")
    @GetMapping("/district-distribution")
    @Operation(summary = "获取各区县分布")
    public Result getDistrictDistribution() {
        return success(dashboardService.getDistrictDistribution());
    }

    @PreAuthorize("@ss.hasPermi('tourism:dashboard:hotspot')")
    @GetMapping("/hotspot-ranking")
    @Operation(summary = "获取热度排行")
    public Result getHotSpotRanking() {
        return success(dashboardService.getHotSpotRanking());
    }

    @PreAuthorize("@ss.hasPermi('tourism:dashboard:trend')")
    @GetMapping("/activity-trend")
    @Operation(summary = "获取活动趋势")
    public Result getActivityTrend() {
        return success(dashboardService.getActivityTrend());
    }

    @PreAuthorize("@ss.hasPermi('tourism:dashboard:map')")
    @GetMapping("/map-distribution")
    @Operation(summary = "获取地图分布数据")
    public Result getMapDistribution() {
        return success(dashboardService.getMapDistribution());
    }
}
