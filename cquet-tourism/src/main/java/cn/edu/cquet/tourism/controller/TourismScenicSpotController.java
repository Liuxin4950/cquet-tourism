package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.service.TourismScenicSpotService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/scenic-spot")
// API 文档注解
@Tag(name = "A级景区管理")
public class TourismScenicSpotController extends BaseController {

    @Autowired
    private TourismScenicSpotService tourismScenicSpotService;

    @GetMapping("/list")
    @Operation(summary = "获取景区列表")
    public TableDataInfo getList(TourismScenicSpotQueryVo queryVo) {
        startPage(); // 分页开始
        // 根据条件查询，查询符合条件的数据
        List<TourismScenicSpot> list = tourismScenicSpotService.getScenicSpotList(queryVo);
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取景区信息")
    public Result getInfo(@PathVariable Long id) {
        TourismScenicSpot scenicSpot = tourismScenicSpotService.getScenicSpotById(id);
        if (scenicSpot == null) {
            return warn("景区不存在");
        }
        return success(scenicSpot);
    }

    @PostMapping
    @Operation(summary = "新增景区")
    // @Validated: 新增时，进行实体类的数据校验
    public Result add(@RequestBody @Validated TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() != null) {
            return warn("新增不需要指定id");
        }
        boolean result = tourismScenicSpotService.addScenicSpot(scenicSpot);
        if (!result) {
            return warn("景区名称已存在");
        }
        return success();
    }

    @PutMapping
    @Operation(summary = "修改景区")
    public Result update(@RequestBody @Validated TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() == null) {
            return warn("修改时，id不能为空");
        }
        boolean result = tourismScenicSpotService.updateScenicSpot(scenicSpot);
        if (!result) {
            return warn("景区名称已存在或更新失败");
        }
        return success();
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除景区")
    public Result remove(@PathVariable List<Long> ids) {
        // 将删除的结果转换为Result对象返回
        boolean result = tourismScenicSpotService.removeScenicSpotByIds(ids);
        if (!result) {
            return warn("删除失败");
        }
        return success();
    }
}
