package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Min;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("tourism_activity")
@Schema(description = "特色活动")
public class TourismActivity extends AbsEntity {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @Schema(description = "活动名称")
    @NotBlank(message = "活动名称不能为空")
    @Size(min = 2, max = 50)
    private String name;

    @TableField("cover_image")
    @Schema(description = "封面图片地址")
    private String coverImage;

    @TableField("cover_image_id")
    @Schema(description = "封面图片ID")
    private Long coverImageId;

    @TableField("start_time")
    @NotNull(message = "开始时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    @Schema(description = "开始时间")
    private LocalDateTime startTime;

    @TableField("end_time")
    @NotNull(message = "结束时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    @Schema(description = "结束时间")
    private LocalDateTime endTime;

    @Schema(description = "活动类别")
    @NotBlank(message = "类别不能为空")
    private String category;

    @TableField("venue_id")
    @NotNull(message = "所属场馆不能为空")
    @Schema(description = "所属场馆ID")
    private Long venueId;

    @Schema(description = "主办方")
    @Size(max = 100)
    private String organizer;

    @TableField("contact_phone")
    @Size(max = 20)
    @Schema(description = "联系电话")
    private String contactPhone;

    @Schema(description = "活动介绍")
    @Size(max = 1000)
    private String description;

    @Schema(description = "运行状态：0-正常，1-停用")
    @Size(max = 1)
    private String status;

    @TableField("current_participants")
    @Schema(description = "当前报名人数")
    @Min(0)
    private Integer currentParticipants;

    @TableField("max_participants")
    @Schema(description = "最大人数")
    @Min(1)
    private Integer maxParticipants;

    @TableField("applicant_user_id")
    @Schema(description = "申报用户ID")
    private Long applicantUserId;

    @TableField("applicant_name")
    @Schema(description = "申报人姓名")
    @Size(max = 50)
    private String applicantName;

    @TableField("apply_reason")
    @Schema(description = "申报理由")
    @Size(max = 255)
    private String applyReason;

    @TableField("apply_time")
    @Schema(description = "申报时间")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    private java.util.Date applyTime;

    @TableField("audit_status")
    @Schema(description = "审核状态：0-待审核，1-通过，2-拒绝")
    @Size(max = 1)
    private String auditStatus;
}
