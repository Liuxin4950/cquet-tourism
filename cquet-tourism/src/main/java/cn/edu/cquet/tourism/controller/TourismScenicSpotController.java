package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.service.TourismScenicSpotService;
import io.lettuce.core.dynamic.annotation.Param;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;
import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.vo.ScenicSpotDetailVo;
import cn.edu.cquet.tourism.domain.TourismImage;

import java.util.List;

@RestController
@RequestMapping("tourism/scenic-spot")
// API 文档注解
@Tag(name = "A级景区管理")
/**
 * A级景区管理接口层
 *
 * 说明：
 * - 负责处理景区相关的增删改查 HTTP 请求。
 * - 继承 `BaseController`，可直接使用分页 `startPage()`、封装表格数据 `getDataTable(...)`、统一返回封装 `success()/warn()/toAjax(...)` 等便捷方法。
 * - 通过 `@PreAuthorize` 控制权限，如 `tourism:scenicSpot:list` 表示具有“景区列表”权限方可访问。
 * - 通过 `@Log` 记录业务日志，`BusinessType` 指定操作类型（新增、修改、删除）。
 * - 使用 `@Operation`、`@Tag` 生成接口文档说明。
 */
public class TourismScenicSpotController extends BaseController {

    @Autowired
    private TourismScenicSpotService tourismScenicSpotService;

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:list')")
    @GetMapping("/list")
    @Operation(summary = "获取景区列表")
    /**
     * 列表查询
     *
     * 路径：`GET /tourism/scenic-spot/list`
     * 权限：`tourism:scenicSpot:list`
     * 入参：`TourismScenicSpotQueryVo`（名称、城市、等级、票价范围、状态等条件）
     * 返回：`TableDataInfo` 表格数据（包含分页总数与当前页数据）
     */
    public TableDataInfo getList(TourismScenicSpotQueryVo queryVo) {
        startPage(); // 分页开始
        // 根据条件查询，查询符合条件的数据
        List<TourismScenicSpot> list = tourismScenicSpotService.getScenicSpotList(queryVo);
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:query')")
    @GetMapping("/{id}")
    @Operation(summary = "获取景区信息")
    /**
     * 详情查询
     *
     * 路径：`GET /tourism/scenic-spot/{id}`
     * 权限：`tourism:scenicSpot:query`
     * 入参：路径参数 `id`
     * 返回：`Result` 包装的 `ScenicSpotDetailVo`，为空则返回警告“景区不存在”
     */
    public Result getInfo(@PathVariable Long id) {
        ScenicSpotDetailVo detail = tourismScenicSpotService.getDetail(id);
        if (detail == null) {
            return warn("景区不存在");
        }
        return success(detail);
    }


    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:image:list')")
    @GetMapping("/{id}/images")
    @Operation(summary = "查看当前景区的关联图片列表")
    public Result spotImages(@PathVariable Long id) {
        if (id == null) return warn("景区id不能为空");
        java.util.List<TourismImage> images = tourismScenicSpotService.getImagesByScenicSpot(id);
        return success(images);
    }

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:image:edit')")
    @PutMapping("/{id}/images")
    @Operation(summary = "设置当前景区的关联图片（覆盖式）")
    public Result setSpotImages(@PathVariable Long id, @RequestBody java.util.List<Integer> imageIds) {
        if (id == null) return warn("景区id不能为空");
        return toAjax(tourismScenicSpotService.setImagesForScenicSpot(id, imageIds));
    }

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:add')")
    @Log(title = "A级景区", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增景区")
    /**
     * 新增
     *
     * 路径：`POST /tourism/scenic-spot`
     * 权限：`tourism:scenicSpot:add`
     * 入参：请求体 `TourismScenicSpot`
     * 约束：新增无需指定 `id`
     * 返回：成功/失败统一封装 `Result`
     */
    public Result add(@RequestBody @Validated TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() != null) {
            return warn("新增不需要指定id");
        }
        boolean result = tourismScenicSpotService.addScenicSpot(scenicSpot);
        if (!result) {
            return warn("景区名称已存在");
        }
        return success(scenicSpot);
    }

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:edit')")
    @Log(title = "A级景区", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改景区")
    /**
     * 修改
     *
     * 路径：`PUT /tourism/scenic-spot`
     * 权限：`tourism:scenicSpot:edit`
     * 入参：请求体 `TourismScenicSpot`
     * 约束：修改必须指定 `id`
     * 返回：成功/失败统一封装 `Result`
     */
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

    @PreAuthorize("@ss.hasPermi('tourism:scenicSpot:remove')")
    @Log(title = "A级景区", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @Operation(summary = "删除景区")
    /**
     * 删除
     *
     * 路径：`DELETE /tourism/scenic-spot/{ids}`
     * 权限：`tourism:scenicSpot:remove`
     * 入参：路径参数 `ids`（多个 id 用逗号分隔，由框架自动转为 `List<Long>`）
     * 返回：成功/失败统一封装 `Result`
     */
    public Result remove(@PathVariable List<Long> ids) {
        // 将删除的结果转换为Result对象返回
        boolean result = tourismScenicSpotService.removeScenicSpotByIds(ids);
        if (!result) {
            return warn("删除失败");
        }
        return success();
    }
}
