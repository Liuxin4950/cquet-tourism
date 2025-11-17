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
    private TourismNewsMapper tourismNewsMapper; // 新闻表 Mapper

    @Override
    /**
     * 列表查询
     * 条件：标题模糊；创建时间在起止范围之间
     */
    public List<TourismNews> getNewsByTitleAndTime(String title, String StartTime, String EndTime) {
        LambdaQueryWrapper<TourismNews> queryWrapper = new LambdaQueryWrapper<>(); // 创建查询构造器
        queryWrapper.like(title != null && !title.isBlank(), TourismNews::getTitle, title) // 标题模糊匹配
                .between(StartTime != null && EndTime != null && !StartTime.isBlank() && !EndTime.isBlank(), TourismNews::getCreateTime, StartTime, EndTime); // 创建时间范围
        return tourismNewsMapper.selectList(queryWrapper); // 执行查询
    }

    @Override
    /**
     * 新增新闻
     * 规则：标题唯一
     */
    public boolean addNews(TourismNews news) {
        LambdaQueryWrapper<TourismNews> queryWrapper = new LambdaQueryWrapper<>(); // 唯一性校验条件
        queryWrapper.eq(TourismNews::getTitle, news.getTitle()); // 标题唯一
        List<TourismNews> list = tourismNewsMapper.selectList(queryWrapper); // 执行查询
        if (!list.isEmpty()) { // 有重复则失败
            return false;
        }
        return tourismNewsMapper.insert(news) > 0; // 插入记录
    }
}
