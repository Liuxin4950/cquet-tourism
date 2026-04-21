package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.mapper.TourismActivityApprovalMapper;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.edu.cquet.common.utils.SecurityUtils;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class TourismActivityApprovalServiceImpl implements TourismActivityApprovalService {

    @Autowired
    private TourismActivityApprovalMapper approvalMapper;

    @Autowired
    private cn.edu.cquet.tourism.mapper.TourismActivityMapper activityMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean recordApproval(Long activityId, String auditStatus, String reason, String auditor) {
        if (activityId == null || auditStatus == null) return false;
        TourismActivityApproval ap = new TourismActivityApproval();
        ap.setActivityId(activityId);
        ap.setAuditStatus(auditStatus);
        ap.setReason(reason);
        ap.setAuditor(auditor != null ? auditor : SecurityUtils.getUsername());
        ap.setAuditTime(new Date());
        return approvalMapper.insert(ap) > 0;
    }

    @Override
    public List<TourismActivityApproval> history(Long activityId) {
        if (activityId == null) return java.util.Collections.emptyList();
        LambdaQueryWrapper<TourismActivityApproval> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismActivityApproval::getActivityId, activityId)
          .eq(TourismActivityApproval::getDelFlag, "0")
          .orderByDesc(TourismActivityApproval::getAuditTime)
          .orderByDesc(TourismActivityApproval::getId);
        return approvalMapper.selectList(qw);
    }

    @Override
    public TourismActivityApproval latest(Long activityId) {
        if (activityId == null) {
            return null;
        }
        Map<Long, TourismActivityApproval> latestMap = latestByActivityIds(Collections.singletonList(activityId));
        return latestMap.get(activityId);
    }

    @Override
    public Map<Long, TourismActivityApproval> latestByActivityIds(Collection<Long> activityIds) {
        Map<Long, TourismActivityApproval> latestMap = new LinkedHashMap<>();
        if (activityIds == null || activityIds.isEmpty()) {
            return latestMap;
        }
        LambdaQueryWrapper<TourismActivityApproval> qw = new LambdaQueryWrapper<>();
        qw.in(TourismActivityApproval::getActivityId, activityIds)
          .eq(TourismActivityApproval::getDelFlag, "0")
          .orderByAsc(TourismActivityApproval::getActivityId)
          .orderByDesc(TourismActivityApproval::getAuditTime)
          .orderByDesc(TourismActivityApproval::getId);
        List<TourismActivityApproval> approvals = approvalMapper.selectList(qw);
        for (TourismActivityApproval approval : approvals) {
            latestMap.putIfAbsent(approval.getActivityId(), approval);
        }
        return latestMap;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean approve(Long id, String opinion) {
        if (id == null) return false;
        TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        UpdateWrapper<TourismActivity> uw = new UpdateWrapper<>();
        uw.set("audit_status", "1")
          .set("status", "0")
          .set("update_time", new Date())
          .eq("id", id);
        if (activityMapper.update(null, uw) <= 0) {
            return false;
        }
        return recordApproval(id, "1", opinion, SecurityUtils.getUsername());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean reject(Long id, String reason) {
        if (id == null || !org.springframework.util.StringUtils.hasText(reason)) return false;
        TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        UpdateWrapper<TourismActivity> uw = new UpdateWrapper<>();
        uw.set("audit_status", "2")
          .set("update_time", new Date())
          .eq("id", id);
        if (activityMapper.update(null, uw) <= 0) {
            return false;
        }
        return recordApproval(id, "2", reason, SecurityUtils.getUsername());
    }
}
