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

@EqualsAndHashCode(callSuper = true) // 继承父类属性, 重写所有equals和hashCode方法
@Data
@TableName("tourism_news") // 表名
@Schema(description = "旅游新闻") // 描述
public class TourismNews extends AbsEntity {

    @Schema(description = "主键，整型")
    @TableId(type = IdType.AUTO) // 主键自增
    private Integer id;

    @TableField("title")
    @Schema(description = "新闻标题")
    @NotBlank(message = "标题不能为空") // 不能为空
    @Xss(message = "标题不能包含脚本")
    @Size(min = 5, max = 30, message = "标题长度不能小于5位或大于30位")
    private String title;

    @TableField("content")
    @Schema(description = "新闻内容（富文本）")
    @NotBlank(message = "内容不能为空")
    private String content;

    @Schema(description = "作者")
    @Xss(message = "作者不能包含脚本")
    private String author;

}
