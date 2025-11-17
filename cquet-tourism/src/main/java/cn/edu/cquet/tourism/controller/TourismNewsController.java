package cn.edu.cquet.tourism.controller;

import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismNews;
import cn.edu.cquet.tourism.domain.vo.TourismNewsVo;
import cn.edu.cquet.tourism.service.TourismNewsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("tourism/news")
// API 文档注解
@Tag(name = "旅游新闻管理")
/**
 * 旅游新闻管理接口层
 *
 * 说明：
 * - 提供新闻的列表、详情、创建、修改与删除接口。
 * - 使用 `TourismNewsVo` 作为查询条件 VO（标题与起止日期）。
 */
public class TourismNewsController extends BaseController {

    @Autowired
    private TourismNewsService tourismNewsService;

    @GetMapping("/list")
    @Operation(summary = "获取新闻列表")
    @PreAuthorize("@ss.hasPermi('tourism:news:list')")
    /**
     * 列表查询
     * 入参：`TourismNewsVo` 包含标题与时间范围
     * 返回：分页 `TableDataInfo`
     */
    public TableDataInfo getList(TourismNewsVo queryData) {
        startPage(); // 分页开始
        // 根据条件查询，查询符合条件的数据
        List<TourismNews> list = tourismNewsService.getNewsByTitleAndTime(queryData.getTitle(), queryData.getStartDate(), queryData.getEndDate());
        // 将数据转换为TableDataInfo对象返回
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @Operation(summary = "获取新闻信息")
    /**
     * 详情查询
     * 入参：路径参数 `id`
     * 返回：新闻详情
     */
    public Result getInfo(@PathVariable Integer id) {
        TourismNews news = tourismNewsService.getById(id);
        return success(news);
    }

    @PostMapping
    @Operation(summary = "新增新闻")
    // @Validated: 新增时，进行实体类的数据校验
    /**
     * 新增
     * 约束：新增无需指定 `id`
     */
    public Result add(@RequestBody @Validated TourismNews News) {
        if (News.getId() != null) {
            return warn("新增不需要指定id");
        }
        return toAjax(tourismNewsService.addNews(News));
    }

    @PutMapping
    @Operation(summary = "修改新闻")
    /**
     * 修改
     * 约束：必须指定 `id`
     */
    public Result update(@RequestBody @Validated TourismNews News) {
        if (News.getId() == null) {
            return warn("修改时，id不能为空");
        }
        return toAjax(tourismNewsService.updateById(News));
    }

    @DeleteMapping("/{ids}")
    @Operation(summary = "删除新闻")
    /**
     * 删除
     * 入参：路径参数 `ids`
     */
    public Result remove(@PathVariable List<Integer> ids) {
        // 将删除的结果转换为Result对象返回
        return toAjax(tourismNewsService.removeBatchByIds(ids));
    }
}
