package cn.edu.cquet.tourism.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_venue_image")
@Schema(description = "场馆图片关联表")
public class TourismVenueImage {

    @Schema(description = "主键")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "场馆id")
    @TableField("venue_id")
    private Long venueId;

    @Schema(description = "图片id")
    @TableField("image_id")
    private Long imageId;

    @Schema(description = "排序")
    @TableField("sort_order")
    private Integer sortOrder;

    @Schema(description = "是否封面")
    @TableField("is_cover")
    private String isCover;
}
