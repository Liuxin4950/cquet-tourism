package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismNews;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

// 继承IService（通用服务层接口，封装了基础业务方法）
public interface TourismNewsService extends IService<TourismNews> {
    /**
     * 根据标题模糊查询，根据时间区间查询
     * @param title     标题
     * @param StartTime 开始时间
     * @param EndTime   结束时间
     * @return          符合条件的数据
     */
    List<TourismNews> getNewsByTitleAndTime(String title, String StartTime, String EndTime);

    /**
     * 添加新闻
     * @param news  新增的值
     * @return      符合条件的数据
     */
    boolean addNews(TourismNews news);
}
