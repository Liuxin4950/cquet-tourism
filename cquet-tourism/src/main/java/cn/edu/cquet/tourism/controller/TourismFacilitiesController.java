package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.service.TourismFacilitiesService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 设备设施管理Controller
 * @author 
 * @date 2025-04-14
 */
@Tag(name = "设备设施管理", description = "设备设施管理接口")
@RestController
@RequestMapping("/tourism/facilities")
public class TourismFacilitiesController extends BaseController {

    @Autowired
    private TourismFacilitiesService tourismFacilitiesService;

    @PreAuthorize("@ss.hasPermi('tourism:facilities:list')")
    @GetMapping("/list")
    @Operation(summary = "获取设备设施列表")
    public TableDataInfo getList(@RequestParam(value = "facilitiesName", required = false) String facilitiesName) {
        startPage(); // 分页开始
        List<TourismFacilities> list = tourismFacilitiesService.getFacilitiesListByName(facilitiesName);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('tourism:facilities:query')")
    @GetMapping("/{id}")
    @Operation(summary = "获取设备设施信息")
    public Result getInfo(@PathVariable Integer id) {
        return success(tourismFacilitiesService.getById(id));
    }

    /**
     * 新增设备设施
     */
    @PreAuthorize("@ss.hasPermi('tourism:facilities:add')")
    @Log(title = "设备设施管理", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增设备设施")
    public Result add(@RequestBody @Validated TourismFacilities tourismFacilities) {
        if (tourismFacilities.getId() != null) {
            return warn("新增不需要指定id");
        }
        return toAjax(tourismFacilitiesService.save(tourismFacilities));
    }

    /**
     * 修改设备设施
     */
    @PreAuthorize("@ss.hasPermi('tourism:facilities:edit')")
    @Log(title = "设备设施管理", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改设备设施")
    public Result edit(@RequestBody @Validated TourismFacilities tourismFacilities) {
        if (tourismFacilities.getId() == null) {
            return warn("修改时，id不能为空");
        }
        return toAjax(tourismFacilitiesService.updateById(tourismFacilities));
    }

    /**
     * 删除设备设施
     */
    @PreAuthorize("@ss.hasPermi('tourism:facilities:remove')")
    @Log(title = "设备设施管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @Operation(summary = "删除设备设施")
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(tourismFacilitiesService.removeByIds(ids));
    }
}