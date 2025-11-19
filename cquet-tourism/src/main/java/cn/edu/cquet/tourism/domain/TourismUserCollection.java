package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@TableName("tourism_user_collection")
@Schema(description = "用户收藏表")
@EqualsAndHashCode(callSuper = true)
public class TourismUserCollection extends AbsEntity {

    @Schema(description = "主键，整型")
    @TableId(type = IdType.AUTO)
    private Integer id;

    @Schema(description = "用户id")
    @TableField("user_id")
    private Integer userId;

    @Schema(description = "收藏目标类型")
    @TableField("target_type")
    private String targetType;

    @Schema(description = "收藏目标id")
    @TableField("target_id")
    private Integer targetId;

}
