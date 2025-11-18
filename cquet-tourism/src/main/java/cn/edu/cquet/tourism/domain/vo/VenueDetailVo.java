package cn.edu.cquet.tourism.domain.vo;

import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "场馆详情VO")
/**
 * 场馆详情视图对象
 *
 * 说明：在场馆基础信息上，附加该场馆的图片与设施列表，用于前端详情页展示。
 */
public class VenueDetailVo extends TourismVenue {
    /** 场馆关联的图片列表 */
    private List<TourismImage> images;
    /** 场馆关联的设施列表 */
    private List<TourismFacilities> facilities;
    /** 场馆关联的景区列表 */
    private List<TourismScenicSpot> scenicSpots;
}