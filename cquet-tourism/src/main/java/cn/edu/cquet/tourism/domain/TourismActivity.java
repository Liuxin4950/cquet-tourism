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

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("tourism_activity")
@Schema(description = "特色活动")
public class TourismActivity extends AbsEntity {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    @TableField("cover_image")
    private String coverImage;

    @TableField("start_time")
    private LocalDateTime startTime;

    @TableField("end_time")
    private LocalDateTime endTime;

    private String category;

    @TableField("venue_id")
    private Integer venueId;

    private String organizer;

    @TableField("contact_phone")
    private String contactPhone;

    private String description;

    private String status;

    @TableField("audit_status")
    private String auditStatus;

    @TableField("audit_reason")
    private String auditReason;

    @TableField("auditor")
    private String auditor;
}