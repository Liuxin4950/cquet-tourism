package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;

import java.util.List;

public interface TourismImageService {
    TourismImage create(TourismImage image);
    List<TourismImage> createBatch(List<String> urls);
    TourismImage getById(Integer id);
    boolean removeByIds(List<Integer> ids);
}