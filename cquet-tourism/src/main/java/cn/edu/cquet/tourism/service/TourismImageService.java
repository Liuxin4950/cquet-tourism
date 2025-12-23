package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface TourismImageService extends IService<TourismImage> {
    TourismImage create(TourismImage image);
    List<TourismImage> createBatch(List<String> urls);
    TourismImage getById(Integer id);
    boolean removeByIds(List<Integer> ids);
}