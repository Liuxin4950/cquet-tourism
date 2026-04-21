package cn.edu.cquet.tourism.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;
import java.time.LocalDateTime;

@Data
@Schema(description = "特色活动（含最新审批信息）")
public class TourismActivityVo {
    private Long id;
    private String name;
    private String coverImage;
    private Long coverImageId;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String category;
    private Long venueId;
    private String organizer;
    private String contactPhone;
    private String description;
    private String status;
    private Integer currentParticipants;
    private Integer maxParticipants;
    private Long applicantUserId;
    private String applicantName;
    private String applyReason;
    private Date applyTime;
    private Date createTime;

    // 最新审批信息（派生）
    private String auditStatus; // 0-待审核（无记录）、1-通过、2-拒绝
    private String auditReason;
    private String auditor;
    private Date auditTime;
}
