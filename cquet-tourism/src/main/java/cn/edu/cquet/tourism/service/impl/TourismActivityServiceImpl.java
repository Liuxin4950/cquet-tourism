package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;
import cn.edu.cquet.tourism.service.TourismActivityService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import cn.edu.cquet.common.utils.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class TourismActivityServiceImpl extends ServiceImpl<TourismActivityMapper, TourismActivity> implements TourismActivityService {

    @Autowired
    private TourismActivityMapper activityMapper;

    @Override
    public List<TourismActivity> list(String name, Integer venueId, String auditStatus) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>();
        String as = normalizeAuditStatus(auditStatus);
        qw.like(StringUtils.hasText(name), TourismActivity::getName, name)
          .eq(venueId != null, TourismActivity::getVenueId, venueId)
          .eq(StringUtils.hasText(as), TourismActivity::getAuditStatus, as)
          .eq(TourismActivity::getDelFlag, "0")
          .orderByDesc(TourismActivity::getCreateTime);
        return activityMapper.selectList(qw);
    }

    @Override
    public TourismActivity detail(Long id) {
        if (id == null) return null;
        return activityMapper.selectById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateStatus(Long id, String status) {
        if (id == null || !StringUtils.hasText(status)) return false;
        TourismActivity a = new TourismActivity();
        a.setId(id);
        a.setStatus(status);
        return activityMapper.updateById(a) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean create(TourismActivity activity) {
        if (activity == null) return false;
        String as = normalizeAuditStatus(activity.getAuditStatus());
        activity.setAuditStatus(StringUtils.hasText(as) ? as : "0");
        return activityMapper.insert(activity) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(TourismActivity activity) {
        if (activity == null || activity.getId() == null) return false;
        String as = normalizeAuditStatus(activity.getAuditStatus());
        activity.setAuditStatus(StringUtils.hasText(as) ? as : activity.getAuditStatus());
        return activityMapper.updateById(activity) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean approve(Long id, String opinion) {
        if (id == null) return false;
        TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>();
        uw.set(TourismActivity::getAuditStatus, "1")
          .set(TourismActivity::getStatus, "0")
          .set(org.springframework.util.StringUtils.hasText(opinion), TourismActivity::getAuditReason, opinion)
          .set(TourismActivity::getAuditor, SecurityUtils.getUsername())
          .set(TourismActivity::getUpdateTime, new java.util.Date())
          .eq(TourismActivity::getId, id);
        int rows = activityMapper.update(null, uw);
        return rows > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean reject(Long id, String reason) {
        if (id == null || !StringUtils.hasText(reason)) return false;
        TourismActivity exist = activityMapper.selectById(id);
        if (exist == null) return false;
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>();
        uw.set(TourismActivity::getAuditStatus, "2")
          .set(TourismActivity::getAuditReason, reason)
          .set(TourismActivity::getAuditor, SecurityUtils.getUsername())
          .set(TourismActivity::getUpdateTime, new java.util.Date())
          .eq(TourismActivity::getId, id);
        int rows = activityMapper.update(null, uw);
        return rows > 0;
    }

    private String normalizeAuditStatus(String s) {
        if (!StringUtils.hasText(s)) return null;
        String v = s.trim().toLowerCase();
        if ("pending".equals(v) || "0".equals(v)) return "0";
        if ("approved".equals(v) || "1".equals(v)) return "1";
        if ("rejected".equals(v) || "2".equals(v)) return "2";
        return s;
    }
}