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

    @Autowired
    private cn.edu.cquet.tourism.service.TourismActivityApprovalService approvalService; // 审批记录服务

    @Override
    /**
     * 列表查询
     * 条件：名称模糊、场馆、审核状态；仅查询未删除；按创建时间降序
     */
    public List<TourismActivity> list(String name, Integer venueId, String auditStatus) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>(); // 创建查询构造器
        qw.like(StringUtils.hasText(name), TourismActivity::getName, name) // 名称模糊
          .eq(venueId != null, TourismActivity::getVenueId, venueId) // 场馆过滤
          .eq(TourismActivity::getDelFlag, "0") // 未删除
          .orderByDesc(TourismActivity::getCreateTime); // 创建时间倒序
        List<TourismActivity> list = activityMapper.selectList(qw);
        // 若携带审核状态筛选，则根据最新审批记录进行过滤
        if (StringUtils.hasText(auditStatus)) {
            String as = normalizeAuditStatus(auditStatus);
            if ("0".equals(as)) {
                list = list.stream().filter(a -> {
                    List<cn.edu.cquet.tourism.domain.TourismActivityApproval> h = approvalService.history(a.getId());
                    return h == null || h.isEmpty();
                }).toList();
            } else if ("1".equals(as) || "2".equals(as)) {
                list = list.stream().filter(a -> {
                    List<cn.edu.cquet.tourism.domain.TourismActivityApproval> h = approvalService.history(a.getId());
                    cn.edu.cquet.tourism.domain.TourismActivityApproval latest = (h == null || h.isEmpty()) ? null : h.get(0);
                    return latest != null && as.equals(latest.getAuditStatus());
                }).toList();
            }
        }
        return list;
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
        // 名称重复校验（同名活动不允许，忽略删除记录）
        if (StringUtils.hasText(activity.getName())) {
            LambdaQueryWrapper<TourismActivity> qwName = new LambdaQueryWrapper<>();
            qwName.eq(TourismActivity::getDelFlag, "0").eq(TourismActivity::getName, activity.getName());
            if (activityMapper.selectCount(qwName) > 0) return false;
        }
        // 同场馆同时间段占用校验（有交集视为冲突，忽略已删除）
        if (activity.getVenueId() != null && activity.getStartTime() != null && activity.getEndTime() != null) {
            LambdaQueryWrapper<TourismActivity> qwTime = new LambdaQueryWrapper<>();
            qwTime.eq(TourismActivity::getDelFlag, "0")
                 .eq(TourismActivity::getVenueId, activity.getVenueId())
                 .lt(TourismActivity::getStartTime, activity.getEndTime())
                 .gt(TourismActivity::getEndTime, activity.getStartTime());
            if (activityMapper.selectCount(qwTime) > 0) return false;
        }
        // 申报信息补全
        activity.setApplicantUserId(cn.edu.cquet.common.utils.SecurityUtils.getUserId());
        activity.setApplicantName(cn.edu.cquet.common.utils.SecurityUtils.getUsername());
        if (activity.getApplyReason() == null) activity.setApplyReason(activity.getDescription());
        activity.setApplyTime(new java.util.Date());
        return activityMapper.insert(activity) > 0; // 插入记录
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新活动
     */
    public boolean update(TourismActivity activity) {
        if (activity == null || activity.getId() == null) return false;
        return activityMapper.updateById(activity) > 0;
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByIds(java.util.List<Long> ids) {
        if (ids == null || ids.isEmpty()) return false;
        return activityMapper.deleteBatchIds(ids) > 0;
    }
}