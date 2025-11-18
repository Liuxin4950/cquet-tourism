package cn.edu.cquet.tourism.domain.vo;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.TourismVenue;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "景区详情VO")
/**
 * 景区详情视图对象
 *
 * 说明：在景区基础信息上，附加该景区关联的图片列表，便于前端一次性渲染详情页。
 */
public class ScenicSpotDetailVo extends TourismScenicSpot {
    /** 景区关联的图片列表 */
    private List<TourismImage> images;
    /** 景区关联的场馆列表 */
    private List<TourismVenue> venues;
}