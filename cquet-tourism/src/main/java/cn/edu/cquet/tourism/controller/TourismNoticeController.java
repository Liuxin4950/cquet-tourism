package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismNotice;
import cn.edu.cquet.tourism.domain.vo.TourismNewsVo;
import cn.edu.cquet.tourism.service.TourismNoticeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/notice")
@Tag(name = "通知公告管理")
/**
 * 通知公告管理接口层
 *
 * 说明：提供公告的列表、详情、创建、修改与删除。
 */
public class TourismNoticeController extends BaseController {

    @Autowired
    private TourismNoticeService noticeService;

    @GetMapping("/list")
    @Operation(summary = "获取通知公告列表（按标题与时间区间）")
    @PreAuthorize("@ss.hasPermi('tourism:notice:list')")
    /**
     * 列表查询
     * 入参：`TourismNewsVo`（标题、起止时间）
     * 返回：分页 `TableDataInfo`
     */
    public TableDataInfo list(TourismNewsVo queryData) {
        startPage();
        List<TourismNotice> list = noticeService.getByTitleAndTime(queryData.getTitle(), queryData.getStartDate(), queryData.getEndDate());
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取通知公告详情")
    /**
     * 详情查询
     * 入参：路径参数 `id`
     */
    public Result detail(@PathVariable Integer id) {
        return success(noticeService.getById(id));
    }

    @PostMapping
    @Operation(summary = "新增通知公告（标题、内容、发布时间）")
    /**
     * 新增
     * 约束：新增无需指定 `id`
     */
    public Result add(@RequestBody @Validated TourismNotice notice) {
        if (notice.getId() != null) return warn("新增不需要指定id");
        return toAjax(noticeService.addNotice(notice));
    }

    @PutMapping
    @Operation(summary = "修改通知公告")
    /**
     * 修改
     * 约束：必须指定 `id`
     */
    public Result edit(@RequestBody @Validated TourismNotice notice) {
        if (notice.getId() == null) return warn("修改时，id不能为空");
        return toAjax(noticeService.updateById(notice));
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除通知公告")
    /**
     * 删除
     * 入参：路径参数 `ids`
     */
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(noticeService.removeBatchByIds(ids));
    }
}
