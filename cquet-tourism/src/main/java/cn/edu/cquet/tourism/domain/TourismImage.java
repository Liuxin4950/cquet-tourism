package cn.edu.cquet.tourism.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_image")
@Schema(description = "图片信息")
public class TourismImage {

    @Schema(description = "图片ID")
    @TableId(type = IdType.AUTO)
    private Integer id;

    @Schema(description = "图片URL")
    @TableField("image_url")
    private String url;
}
