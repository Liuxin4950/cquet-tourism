package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivity;

import java.util.List;

public interface TourismActivityService {
    List<TourismActivity> list(String name, Integer venueId, String auditStatus);
    TourismActivity detail(Long id);
    boolean updateStatus(Long id, String status);
    boolean create(TourismActivity activity);
    boolean update(TourismActivity activity);
    boolean approve(Long id, String opinion);
    boolean reject(Long id, String reason);
}