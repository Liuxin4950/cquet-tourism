package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismNotice;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface TourismNoticeService extends IService<TourismNotice> {
    List<TourismNotice> getByTitleAndTime(String title, String startTime, String endTime);
    boolean addNotice(TourismNotice notice);
}