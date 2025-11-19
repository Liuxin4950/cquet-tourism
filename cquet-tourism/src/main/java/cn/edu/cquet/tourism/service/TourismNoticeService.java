package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismNotice;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;


// 特色活动通知服务接口
public interface TourismNoticeService extends IService<TourismNotice> {
    // 根据标题和时间范围查询通知
    List<TourismNotice> getByTitleAndTime(String title, String startTime, String endTime);
    // 添加通知
    boolean addNotice(TourismNotice notice);
}