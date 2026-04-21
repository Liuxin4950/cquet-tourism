package cn.edu.cquet.tourism.domain;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_facilities")
@Schema(description = "景区设备设施表")
public class TourismFacilities {

    @Schema(description = "主键")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "设施名称")
    @TableField("facilities")
    @NotBlank(message = "设施名称不能为空")
    @Size(max = 50, message = "设施名称长度不能超过50个字符")
    private String facilitiesName;
}
