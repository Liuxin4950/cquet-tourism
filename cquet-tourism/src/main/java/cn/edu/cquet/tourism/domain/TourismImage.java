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
@EqualsAndHashCode(callSuper = true)
@TableName("tourism_image")
@Schema(description = "图片信息")
public class TourismImage extends AbsEntity {

    @Schema(description = "图片ID")
    @TableId(type = IdType.AUTO)
    private Long id;

    @Schema(description = "图片URL")
    @TableField("image_url")
    private String url;

    @Schema(description = "系统文件名")
    @TableField("file_name")
    private String fileName;

    @Schema(description = "原始文件名")
    @TableField("original_name")
    private String originalName;

    @Schema(description = "文件后缀")
    @TableField("file_ext")
    private String fileExt;

    @Schema(description = "MIME类型")
    @TableField("mime_type")
    private String mimeType;

    @Schema(description = "文件大小")
    @TableField("file_size")
    private Long fileSize;

    @Schema(description = "存储类型")
    @TableField("storage_type")
    private String storageType;
}
