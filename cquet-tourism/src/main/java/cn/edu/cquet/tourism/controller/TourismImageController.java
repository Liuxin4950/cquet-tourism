package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.enums.BusinessType;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.service.TourismImageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/images")
@Tag(name = "图片管理")
public class TourismImageController extends BaseController {

    @Autowired
    private TourismImageService imageService;

    @PreAuthorize("@ss.hasPermi('tourism:image:add')")
    @Log(title = "图片管理", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增图片记录（保存URL）")
    public Result add(@RequestBody @Validated TourismImage image) {
        if (image == null || image.getUrl() == null || image.getUrl().isBlank()) {
            return warn("图片URL不能为空");
        }
        TourismImage created = imageService.create(image);
        if (created == null || created.getId() == null) {
            return warn("保存失败");
        }
        return success(created);
    }

    @PreAuthorize("@ss.hasPermi('tourism:image:add')")
    @Log(title = "图片管理", businessType = BusinessType.INSERT)
    @PostMapping("/batch")
    @Operation(summary = "批量新增图片记录（URL列表）")
    public Result addBatch(@RequestBody List<String> urls) {
        List<TourismImage> created = imageService.createBatch(urls);
        return success(created);
    }

    @PreAuthorize("@ss.hasPermi('tourism:image:query')")
    @GetMapping("/{id}")
    @Operation(summary = "查询图片记录")
    public Result get(@PathVariable Integer id) {
        TourismImage img = imageService.getById(id);
        if (img == null) {
            return warn("图片不存在");
        }
        return success(img);
    }

    @PreAuthorize("@ss.hasPermi('tourism:image:remove')")
    @Log(title = "图片管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @Operation(summary = "删除图片记录")
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(imageService.removeByIds(ids));
    }
}