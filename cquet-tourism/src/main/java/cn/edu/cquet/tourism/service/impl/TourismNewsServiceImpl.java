package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismNews;
import cn.edu.cquet.tourism.mapper.TourismNewsMapper;
import cn.edu.cquet.tourism.service.TourismNewsService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
/**
 * 新闻服务实现
 *
 * 说明：继承 MyBatis-Plus `ServiceImpl`，实现新闻的查询与新增。
 */
public class TourismNewsServiceImpl extends ServiceImpl<TourismNewsMapper, TourismNews> implements TourismNewsService {

    @Autowired
    private TourismNewsMapper tourismNewsMapper;

    @Override
    /**
     * 列表查询
     * 条件：标题模糊；创建时间在起止范围之间
     */
    public List<TourismNews> getNewsByTitleAndTime(String title, String StartTime, String EndTime) {
        // 创建条件构造器
        LambdaQueryWrapper<TourismNews> queryWrapper = new LambdaQueryWrapper<>();
        // 添加查询条件
        queryWrapper.like(title != null && !title.isBlank(), TourismNews::getTitle, title)
                .between(StartTime != null && EndTime != null && !StartTime.isBlank() && !EndTime.isBlank(), TourismNews::getCreateTime, StartTime, EndTime);
        // 调用mapper方法，传入条件构造器，查询数据
        return tourismNewsMapper.selectList(queryWrapper);
    }

    @Override
    /**
     * 新增新闻
     * 规则：标题唯一
     */
    public boolean addNews(TourismNews news) {
        LambdaQueryWrapper<TourismNews> queryWrapper = new LambdaQueryWrapper<>();
        // 判断title是否重复
        queryWrapper.eq(TourismNews::getTitle, news.getTitle());
        List<TourismNews> list = tourismNewsMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            return false;
        }
        return tourismNewsMapper.insert(news) > 0;
    }
}
