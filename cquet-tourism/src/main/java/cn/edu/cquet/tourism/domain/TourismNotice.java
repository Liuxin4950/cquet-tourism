package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import cn.edu.cquet.common.xss.Xss;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@TableName("tourism_notice")
@Schema(description = "通知公告")
public class TourismNotice extends AbsEntity {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @TableField("notice_title")
    @Schema(description = "公告标题")
    @NotBlank(message = "标题不能为空")
    @Xss(message = "标题不能包含脚本")
    @Size(min = 2, max = 50, message = "标题长度需在2-50之间")
    private String title;

    @TableField("notice_content")
    @Schema(description = "公告内容（富文本）")
    @NotBlank(message = "内容不能为空")
    private String content;
}