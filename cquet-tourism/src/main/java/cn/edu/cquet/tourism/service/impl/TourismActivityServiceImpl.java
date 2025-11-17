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
    private TourismActivityMapper activityMapper; // 活动表 Mapper

    @Override
    /**
     * 列表查询
     * 条件：名称模糊、场馆、审核状态；仅查询未删除；按创建时间降序
     */
    public List<TourismActivity> list(String name, Integer venueId, String auditStatus) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>(); // 创建查询构造器
        String as = normalizeAuditStatus(auditStatus); // 归一化审核状态
        qw.like(StringUtils.hasText(name), TourismActivity::getName, name) // 名称模糊
          .eq(venueId != null, TourismActivity::getVenueId, venueId) // 场馆过滤
          .eq(StringUtils.hasText(as), TourismActivity::getAuditStatus, as) // 审核状态过滤
          .eq(TourismActivity::getDelFlag, "0") // 未删除
          .orderByDesc(TourismActivity::getCreateTime); // 创建时间倒序
        return activityMapper.selectList(qw); // 执行查询
    }

    @Override
    /**
     * 详情查询
     */
    public TourismActivity detail(Long id) {
        if (id == null) return null; // 基本校验
        return activityMapper.selectById(id); // 主键查询
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新活动状态
     */
    public boolean updateStatus(Long id, String status) {
        if (id == null || !StringUtils.hasText(status)) return false; // 校验 id 与状态
        TourismActivity a = new TourismActivity(); // 构造更新实体（仅设置变更字段）
        a.setId(id); // 主键
        a.setStatus(status); // 状态
        return activityMapper.updateById(a) > 0; // 执行更新
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 新增活动
     * 默认审核状态：`0`（待审核）
     */
    public boolean create(TourismActivity activity) {
        if (activity == null) return false; // 基本校验
        String as = normalizeAuditStatus(activity.getAuditStatus()); // 归一化传入的审核状态
        activity.setAuditStatus(StringUtils.hasText(as) ? as : "0"); // 默认待审核
        return activityMapper.insert(activity) > 0; // 插入记录
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新活动
     */
    public boolean update(TourismActivity activity) {
        if (activity == null || activity.getId() == null) return false; // 校验
        String as = normalizeAuditStatus(activity.getAuditStatus()); // 归一化审核状态
        activity.setAuditStatus(StringUtils.hasText(as) ? as : activity.getAuditStatus()); // 若归一化结果为空则保留原值
        return activityMapper.updateById(activity) > 0; // 更新记录
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 审核通过
     * 效果：审核状态=通过、活动状态=正常；记录审核意见/人/时间
     */
    public boolean approve(Long id, String opinion) {
        if (id == null) return false; // 校验
        TourismActivity exist = activityMapper.selectById(id); // 查询是否存在
        if (exist == null) return false; // 不存在
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>(); // 构造更新器
        uw.set(TourismActivity::getAuditStatus, "1") // 审核通过
          .set(TourismActivity::getStatus, "0") // 启动状态
          .set(org.springframework.util.StringUtils.hasText(opinion), TourismActivity::getAuditReason, opinion) // 可选记录审核意见
          .set(TourismActivity::getAuditor, SecurityUtils.getUsername()) // 记录审核人
          .set(TourismActivity::getUpdateTime, new java.util.Date()) // 更新时间
          .eq(TourismActivity::getId, id); // 目标记录
        int rows = activityMapper.update(null, uw); // 执行更新
        return rows > 0; // 返回结果
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 审核不通过
     * 效果：审核状态=不通过；记录原因、审核人与时间
     */
    public boolean reject(Long id, String reason) {
        if (id == null || !StringUtils.hasText(reason)) return false; // 校验：必须提供原因
        TourismActivity exist = activityMapper.selectById(id); // 查询是否存在
        if (exist == null) return false; // 不存在
        com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<TourismActivity> uw = new com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper<>(); // 构造更新器
        uw.set(TourismActivity::getAuditStatus, "2") // 审核不通过
          .set(TourismActivity::getAuditReason, reason) // 记录原因
          .set(TourismActivity::getAuditor, SecurityUtils.getUsername()) // 审核人
          .set(TourismActivity::getUpdateTime, new java.util.Date()) // 更新时间
          .eq(TourismActivity::getId, id); // 目标记录
        int rows = activityMapper.update(null, uw); // 执行更新
        return rows > 0; // 返回结果
    }

    /**
     * 审核状态归一化
     * 支持中英文与数字混写：`pending/approved/rejected` 或 `0/1/2`
     */
    private String normalizeAuditStatus(String s) {
        if (!StringUtils.hasText(s)) return null; // 空值直接返回 null 便于上层忽略
        String v = s.trim().toLowerCase(); // 去空格并转小写
        if ("pending".equals(v) || "0".equals(v)) return "0"; // 待审核
        if ("approved".equals(v) || "1".equals(v)) return "1"; // 通过
        if ("rejected".equals(v) || "2".equals(v)) return "2"; // 不通过
        return s; // 未匹配则回传原值
    }
}