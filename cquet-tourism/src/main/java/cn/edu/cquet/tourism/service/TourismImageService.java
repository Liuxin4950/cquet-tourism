package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface TourismImageService extends IService<TourismImage> {
    TourismImage create(TourismImage image);
    List<TourismImage> createBatch(List<String> urls);
    TourismImage getById(Long id);
    boolean removeByIds(List<Long> ids);
    TourismImage ensureByUrl(String url);
    java.util.Map<Long, TourismImage> getImageMap(java.util.Collection<Long> ids);
}
