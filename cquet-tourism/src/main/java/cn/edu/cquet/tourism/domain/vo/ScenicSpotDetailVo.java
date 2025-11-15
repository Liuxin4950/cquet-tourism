package cn.edu.cquet.tourism.domain.vo;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "景区详情VO")
public class ScenicSpotDetailVo extends TourismScenicSpot {
    private List<TourismImage> images;
}