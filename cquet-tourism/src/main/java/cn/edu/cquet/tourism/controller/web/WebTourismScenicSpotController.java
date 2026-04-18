package cn.edu.cquet.tourism.controller.web;

import cn.edu.cquet.common.annotation.Anonymous;
import cn.edu.cquet.common.core.controller.BaseController;
import cn.edu.cquet.common.core.domain.Result;
import cn.edu.cquet.common.core.page.TableDataInfo;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.ScenicSpotDetailVo;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.service.TourismScenicSpotService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("web/tourism/scenic-spot")
@Tag(name = "用户端A级景区")
public class WebTourismScenicSpotController extends BaseController {

    @Autowired
    private TourismScenicSpotService tourismScenicSpotService;

    @Anonymous
    @GetMapping("/list")
    @Operation(summary = "用户端获取景区列表")
    public TableDataInfo getList(TourismScenicSpotQueryVo queryVo) {
        startPage();
        List<TourismScenicSpot> list = tourismScenicSpotService.getScenicSpotList(queryVo);
        return getDataTable(list);
    }

    @Anonymous
    @GetMapping("/{id}")
    @Operation(summary = "用户端获取景区详情")
    public Result getInfo(@PathVariable Long id) {
        ScenicSpotDetailVo detail = tourismScenicSpotService.getDetail(id);
        if (detail == null) {
            return warn("景区不存在");
        }
        return success(detail);
    }

    @Anonymous
    @GetMapping("/{id}/images")
    @Operation(summary = "用户端获取景区图片列表")
    public Result spotImages(@PathVariable Long id) {
        if (id == null) {
            return warn("景区id不能为空");
        }
        List<TourismImage> images = tourismScenicSpotService.getImagesByScenicSpot(id);
        return success(images);
    }
}
