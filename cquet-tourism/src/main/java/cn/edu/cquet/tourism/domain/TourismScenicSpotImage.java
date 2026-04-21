package cn.edu.cquet.tourism.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_scenic_spot_image")
@Schema(description = "景区图片关联表")
public class TourismScenicSpotImage {

    @Schema(description = "主键")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "景区id")
    @TableField("scenic_spot_id")
    private Long scenicSpotId;

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
