package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import java.util.Collection;
import java.util.Map;
import java.util.List;

public interface TourismActivityApprovalService {
    // 记录审批信息
    boolean recordApproval(Long activityId, String auditStatus, String reason, String auditor);
    // 查询审批历史
    List<TourismActivityApproval> history(Long activityId);
    // 查询最新审批记录
    TourismActivityApproval latest(Long activityId);
    // 批量查询最新审批记录
    Map<Long, TourismActivityApproval> latestByActivityIds(Collection<Long> activityIds);
    // 审批通过
    boolean approve(Long id, String opinion);
    // 审批拒绝
    boolean reject(Long id, String reason);
}
