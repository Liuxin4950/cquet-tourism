package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivity;

import java.util.List;

public interface TourismActivityService {
    // 列表查询（根据名称、场馆ID、审核状态）
    List<TourismActivity> list(String name, Long venueId, String auditStatus);
    // 详情查询（根据ID）
    TourismActivity detail(Long id);
    // 更新状态（根据ID）
    boolean updateStatus(Long id, String status);
    // 创建活动
    boolean create(TourismActivity activity);
    // 更新活动
    boolean update(TourismActivity activity);
    boolean removeByIds(java.util.List<Long> ids);
}
