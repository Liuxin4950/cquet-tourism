package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.mapper.TourismActivityApprovalMapper;
import cn.edu.cquet.tourism.service.TourismActivityApprovalService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.edu.cquet.common.utils.SecurityUtils;

import java.util.Date;
import java.util.List;

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
          .orderByDesc(TourismActivityApproval::getAuditTime);
        return approvalMapper.selectList(qw);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean approve(Long id, String opinion) {
        if (id == null) return false;
        cn.edu.cquet.tourism.domain.TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        // 写审批记录
        recordApproval(id, "1", opinion, cn.edu.cquet.common.utils.SecurityUtils.getUsername());
        // 可选：通过后将运行状态置为正常
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<cn.edu.cquet.tourism.domain.TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>();
        uw.set(cn.edu.cquet.tourism.domain.TourismActivity::getStatus, "0")
          .set(cn.edu.cquet.tourism.domain.TourismActivity::getUpdateTime, new java.util.Date())
          .eq(cn.edu.cquet.tourism.domain.TourismActivity::getId, id);
        activityMapper.update(null, uw);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean reject(Long id, String reason) {
        if (id == null || !org.springframework.util.StringUtils.hasText(reason)) return false;
        cn.edu.cquet.tourism.domain.TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        // 写审批记录
        recordApproval(id, "2", reason, cn.edu.cquet.common.utils.SecurityUtils.getUsername());
        // 可选：更新活动更新时间
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<cn.edu.cquet.tourism.domain.TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>();
        uw.set(cn.edu.cquet.tourism.domain.TourismActivity::getUpdateTime, new java.util.Date())
          .eq(cn.edu.cquet.tourism.domain.TourismActivity::getId, id);
        activityMapper.update(null, uw);
        return true;
    }
}