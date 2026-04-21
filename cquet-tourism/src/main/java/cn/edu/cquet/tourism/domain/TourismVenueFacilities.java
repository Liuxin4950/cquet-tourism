package cn.edu.cquet.tourism.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_venue_facilities")
@Schema(description = "场馆设备关联表")
public class TourismVenueFacilities {

    @Schema(description = "主键")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "场馆id")
    @TableField("venue_id")
    private Long venueId;

    @Schema(description = "设备id")
    @TableField("facilities_id")
    private Long facilitiesId;

    @Schema(description = "排序")
    private Integer sort;
}
