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
// 继承ServiceImpl类（通用服务层接口的实现类），最后实现service接口规定的方法
public class TourismNewsServiceImpl extends ServiceImpl<TourismNewsMapper, TourismNews> implements TourismNewsService {

    @Autowired
    private TourismNewsMapper tourismNewsMapper;

    @Override
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
