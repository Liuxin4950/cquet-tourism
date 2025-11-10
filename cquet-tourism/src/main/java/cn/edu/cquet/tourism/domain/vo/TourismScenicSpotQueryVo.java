package cn.edu.cquet.tourism.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * A级景区查询参数VO类
 */
@Data
@Schema(description = "A级景区查询参数")
public class TourismScenicSpotQueryVo {

    @Schema(description = "景区名称，支持模糊查询")
    private String name;

    @Schema(description = "所属城市")
    private String city;

    @Schema(description = "景区级别(如：AAAAA, AAAA, AAA)")
    private String level;

    @Schema(description = "最低门票价格")
    private Double minTicketPrice;

    @Schema(description = "最高门票价格")
    private Double maxTicketPrice;

    @Schema(description = "景区状态(0:关闭, 1:开放)")
    private String status;

}