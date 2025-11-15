package cn.edu.cquet.tourism.domain.vo;

import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismVenue;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;

@Data
@Schema(description = "场馆详情VO")
public class VenueDetailVo extends TourismVenue {
    private List<TourismImage> images;
    private List<TourismFacilities> facilities;
}