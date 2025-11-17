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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/notice")
@Tag(name = "通知公告管理")
public class TourismNoticeController extends BaseController {

    @Autowired
    private TourismNoticeService noticeService;

    @GetMapping("/list")
    @Operation(summary = "获取通知公告列表（按标题与时间区间）")
    public TableDataInfo list(TourismNewsVo queryData) {
        startPage();
        List<TourismNotice> list = noticeService.getByTitleAndTime(queryData.getTitle(), queryData.getStartDate(), queryData.getEndDate());
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取通知公告详情")
    public Result detail(@PathVariable Integer id) {
        return success(noticeService.getById(id));
    }

    @PostMapping
    @Operation(summary = "新增通知公告（标题、内容、发布时间）")
    public Result add(@RequestBody @Validated TourismNotice notice) {
        if (notice.getId() != null) return warn("新增不需要指定id");
        return toAjax(noticeService.addNotice(notice));
    }

    @PutMapping
    @Operation(summary = "修改通知公告")
    public Result edit(@RequestBody @Validated TourismNotice notice) {
        if (notice.getId() == null) return warn("修改时，id不能为空");
        return toAjax(noticeService.updateById(notice));
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除通知公告")
    public Result remove(@PathVariable List<Integer> ids) {
        return toAjax(noticeService.removeBatchByIds(ids));
    }
}