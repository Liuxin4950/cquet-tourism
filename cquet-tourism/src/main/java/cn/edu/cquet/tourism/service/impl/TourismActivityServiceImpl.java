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
/**
 * 特色活动服务实现
 *
 * 说明：提供活动的列表、详情、状态更新、创建与修改、审核通过/不通过等业务。
 */
public class TourismActivityServiceImpl extends ServiceImpl<TourismActivityMapper, TourismActivity> implements TourismActivityService {

    @Autowired
    private TourismActivityMapper activityMapper;

    @Override
    /**
     * 列表查询
     * 条件：名称模糊、场馆、审核状态；仅查询未删除；按创建时间降序
     */
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
    /**
     * 详情查询
     */
    public TourismActivity detail(Long id) {
        if (id == null) return null;
        return activityMapper.selectById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新活动状态
     */
    public boolean updateStatus(Long id, String status) {
        if (id == null || !StringUtils.hasText(status)) return false;
        TourismActivity a = new TourismActivity();
        a.setId(id);
        a.setStatus(status);
        return activityMapper.updateById(a) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 新增活动
     * 默认审核状态：`0`（待审核）
     */
    public boolean create(TourismActivity activity) {
        if (activity == null) return false;
        String as = normalizeAuditStatus(activity.getAuditStatus());
        activity.setAuditStatus(StringUtils.hasText(as) ? as : "0");
        return activityMapper.insert(activity) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新活动
     */
    public boolean update(TourismActivity activity) {
        if (activity == null || activity.getId() == null) return false;
        String as = normalizeAuditStatus(activity.getAuditStatus());
        activity.setAuditStatus(StringUtils.hasText(as) ? as : activity.getAuditStatus());
        return activityMapper.updateById(activity) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 审核通过
     * 效果：审核状态=通过、活动状态=正常；记录审核意见/人/时间
     */
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
    /**
     * 审核不通过
     * 效果：审核状态=不通过；记录原因、审核人与时间
     */
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

    /**
     * 审核状态归一化
     * 支持中英文与数字混写：`pending/approved/rejected` 或 `0/1/2`
     */
    private String normalizeAuditStatus(String s) {
        if (!StringUtils.hasText(s)) return null;
        String v = s.trim().toLowerCase();
        if ("pending".equals(v) || "0".equals(v)) return "0";
        if ("approved".equals(v) || "1".equals(v)) return "1";
        if ("rejected".equals(v) || "2".equals(v)) return "2";
        return s;
    }
}