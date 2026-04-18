package cn.edu.cquet.tourism.controller.admin;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
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
/**
 * 图片管理接口层
 *
 * 说明：
 * - 负责图片记录的新增、批量新增、查询与删除。
 * - 图片仅保存 URL 等基础信息，具体文件存储由外部系统负责。
 * - 统一使用 `Result` 封装返回，权限与日志按注解控制。
 */
public class TourismImageController extends BaseController {

    @Autowired
    private TourismImageService imageService;

    @PreAuthorize("@ss.hasPermi('tourism:image:add')")
    @Log(title = "图片管理", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增图片记录（保存URL）")
    /**
     * 新增单条图片记录
     *
     * 路径：`POST /tourism/images`
     * 权限：`tourism:image:add`
     * 入参：请求体 `TourismImage`（至少包含 `url`）
     * 返回：创建后的记录
     */
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
    /**
     * 批量新增图片记录
     *
     * 路径：`POST /tourism/images/batch`
     * 权限：`tourism:image:add`
     * 入参：请求体为 URL 字符串列表
     * 返回：创建成功的图片记录列表
     */
    public Result addBatch(@RequestBody List<String> urls) {
        List<TourismImage> created = imageService.createBatch(urls);
        return success(created);
    }
    @PreAuthorize("@ss.hasPermi('tourism:image:list')")
    @GetMapping("/list")
    @Operation(summary = "获取图片列表")
    /**
     * 获取图片列表
     *
     * 路径：`GET /tourism/images/list`
     * 权限：`tourism:image:list`
     * 返回：分页表格数据 `TableDataInfo`
     */
    public TableDataInfo list() {
        startPage();
        List<TourismImage> list = imageService.list();
        return getDataTable(list);
    }



    @PreAuthorize("@ss.hasPermi('tourism:image:query')")
    @GetMapping("/{id}")
    @Operation(summary = "查询图片记录")
    /**
     * 根据主键查询图片记录
     *
     * 路径：`GET /tourism/images/{id}`
     * 权限：`tourism:image:query`
     * 入参：路径参数 `id`
     * 返回：图片记录，不存在则返回警告
     */
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
    /**
     * 删除图片记录
     *
     * 路径：`DELETE /tourism/images/{ids}`
     * 权限：`tourism:image:remove`
     * 入参：路径参数 `ids`
     * 返回：统一 `Result`
     */
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(imageService.removeByIds(ids));
    }
}
