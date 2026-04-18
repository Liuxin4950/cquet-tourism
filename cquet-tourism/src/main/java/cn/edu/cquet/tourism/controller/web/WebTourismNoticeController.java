package cn.edu.cquet.tourism.controller.web;

import cn.edu.cquet.common.annotation.Anonymous;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismNotice;
import cn.edu.cquet.tourism.domain.vo.TourismNewsVo;
import cn.edu.cquet.tourism.service.TourismNoticeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("web/tourism/notice")
@Tag(name = "用户端通知公告")
public class WebTourismNoticeController extends BaseController {

    @Autowired
    private TourismNoticeService noticeService;

    @Anonymous
    @GetMapping("/list")
    @Operation(summary = "用户端获取通知公告列表")
    public TableDataInfo list(TourismNewsVo queryData) {
        startPage();
        List<TourismNotice> list = noticeService.getByTitleAndTime(
                queryData.getTitle(),
                queryData.getStartDate(),
                queryData.getEndDate());
        return getDataTable(list);
    }

    @Anonymous
    @GetMapping("/{id}")
    @Operation(summary = "用户端获取通知公告详情")
    public Result detail(@PathVariable Integer id) {
        return success(noticeService.getById(id));
    }
}
