package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.R;
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

import java.util.List;

@RestController
@RequestMapping("tourism/venue")
@Tag(name = "场馆信息")
public class tourismVenueController extends BaseController {

    @Autowired
    private TourismVenueService tourismVenueService;

    @GetMapping("/list")
    @Operation(summary = "获取场馆列表")
    public TableDataInfo getList(@Param("name") String name, @Param("address") String address) {
        startPage(); // 分页开始
        // 根据条件查询，查询符合条件的数据
        List<TourismVenue> list = tourismVenueService.getVenueByNameAndAddress(name, address);
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取场馆信息")
    public Result getInfo(@PathVariable Long id) {
        TourismVenue venue = tourismVenueService.getById(id);
        if (venue == null) {
            return warn("场馆不存在");
        }
        return success(venue);
    }

    @PostMapping
    @Operation(summary = "新增场馆")
    public Result add(@RequestBody @Validated TourismVenue venue) {
        if (venue.getId() != null) {
            return warn("新增不需要指定id");
        }
        return toAjax(tourismVenueService.addVenue(venue));
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除场馆")
    public Result remove(@RequestBody List<Integer> ids) {
        // 将删除的结果转换为Result对象返回
        return toAjax(tourismVenueService.removeByIds(ids));
    }
}
