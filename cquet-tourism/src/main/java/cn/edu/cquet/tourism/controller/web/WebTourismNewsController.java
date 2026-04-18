package cn.edu.cquet.tourism.controller.web;

import cn.edu.cquet.common.annotation.Anonymous;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismNews;
import cn.edu.cquet.tourism.domain.vo.TourismNewsVo;
import cn.edu.cquet.tourism.service.TourismNewsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("web/tourism/news")
@Tag(name = "用户端旅游新闻")
public class WebTourismNewsController extends BaseController {

    @Autowired
    private TourismNewsService tourismNewsService;

    @Anonymous
    @GetMapping("/list")
    @Operation(summary = "用户端获取新闻列表")
    public TableDataInfo getList(TourismNewsVo queryData) {
        startPage();
        List<TourismNews> list = tourismNewsService.getNewsByTitleAndTime(
                queryData.getTitle(),
                queryData.getStartDate(),
                queryData.getEndDate());
        return getDataTable(list);
    }

    @Anonymous
    @GetMapping("/{id}")
    @Operation(summary = "用户端获取新闻详情")
    public Result getInfo(@PathVariable Integer id) {
        TourismNews news = tourismNewsService.getById(id);
        return success(news);
    }
}
