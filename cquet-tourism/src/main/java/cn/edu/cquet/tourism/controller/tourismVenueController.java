package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.mapper.TourismVenueMapper;
import cn.edu.cquet.tourism.service.TourismVenueService;
import io.lettuce.core.dynamic.annotation.Param;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;
import cn.edu.cquet.tourism.domain.TourismActivity;

import java.util.List;

@RestController
@RequestMapping("tourism/venue")
@Tag(name = "场馆信息")
public class tourismVenueController extends BaseController {

    @Autowired
    private TourismVenueService tourismVenueService;

    @PreAuthorize("@ss.hasPermi('tourism:venue:list')")
    @GetMapping("/list")
    @Operation(summary = "获取场馆列表")
    public TableDataInfo getList(@Param("name") String name, @Param("address") String address) {
        startPage(); // 分页开始
        // 根据条件查询，查询符合条件的数据
        List<TourismVenue> list = tourismVenueService.getVenueByNameAndAddress(name, address);
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:query')")
    @GetMapping("/{id}")
    @Operation(summary = "获取场馆信息")
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
    public Result add(@RequestBody @Validated TourismVenue venue) {
        if (venue.getId() != null) {
            return warn("新增不需要指定id");
        }
        return toAjax(tourismVenueService.addVenue(venue));
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:edit')")
    @Log(title = "场馆管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改场馆")
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
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(tourismVenueService.removeVenueByIds(ids));
    }

    @PreAuthorize("@ss.hasPermi('tourism:venue:activity:list')")
    @GetMapping("/{id}/activities")
    @Operation(summary = "查看当前场馆的特色活动列表")
    public Result activities(@PathVariable Long id) {
        if (id == null) {
            return warn("场馆id不能为空");
        }
        List<TourismActivity> list = ((cn.edu.cquet.tourism.service.impl.TourismVenueServiceImpl)tourismVenueService).getActivitiesByVenueId(id.intValue());
        return success(list);
    }
}
