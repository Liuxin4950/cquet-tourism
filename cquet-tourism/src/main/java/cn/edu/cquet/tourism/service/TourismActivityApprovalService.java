package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import java.util.List;

public interface TourismActivityApprovalService {
    // 记录审批信息
    boolean recordApproval(Long activityId, String auditStatus, String reason, String auditor);
    // 查询审批历史
    List<TourismActivityApproval> history(Long activityId);
    // 审批通过
    boolean approve(Long id, String opinion);
    // 审批拒绝
    boolean reject(Long id, String reason);
}