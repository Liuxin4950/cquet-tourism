package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("tourism_activity_approval")
@Schema(description = "特色活动审批记录")
public class TourismActivityApproval extends AbsEntity {

    @TableId(type = IdType.AUTO)
    @Schema(description = "主键ID")
    private Long id;

    @TableField("activity_id")
    @NotNull
    @Schema(description = "活动ID")
    private Long activityId;

    @TableField("auditor")
    @Size(max = 50)
    @Schema(description = "审核人")
    private String auditor;

    @TableField("audit_status")
    @Size(max = 1)
    @Schema(description = "审核状态：0-待审核，1-通过，2-拒绝")
    private String auditStatus;

    @TableField("reason")
    @Size(max = 255)
    @Schema(description = "审核意见或不通过原因")
    private String reason;

    @TableField("audit_time")
    @Schema(description = "审核时间")
    private Date auditTime;
}