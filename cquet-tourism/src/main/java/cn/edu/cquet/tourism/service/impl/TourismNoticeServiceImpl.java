package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismNotice;
import cn.edu.cquet.tourism.mapper.TourismNoticeMapper;
import cn.edu.cquet.tourism.service.TourismNoticeService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
/**
 * 通知公告服务实现
 */
public class TourismNoticeServiceImpl extends ServiceImpl<TourismNoticeMapper, TourismNotice> implements TourismNoticeService {

    @Autowired
    private TourismNoticeMapper noticeMapper; // 公告表 Mapper

    @Override
    /**
     * 列表查询
     * 条件：标题模糊 + 创建时间范围
     */
    public List<TourismNotice> getByTitleAndTime(String title, String startTime, String endTime) {
        LambdaQueryWrapper<TourismNotice> qw = new LambdaQueryWrapper<>(); // 创建查询构造器
        qw.like(title != null && !title.isBlank(), TourismNotice::getTitle, title) // 标题模糊
          .between(startTime != null && endTime != null && !startTime.isBlank() && !endTime.isBlank(), TourismNotice::getCreateTime, startTime, endTime); // 创建时间范围
        return noticeMapper.selectList(qw); // 执行查询
    }

    @Override
    /**
     * 新增公告
     * 规则：标题唯一
     */
    public boolean addNotice(TourismNotice notice) {
        LambdaQueryWrapper<TourismNotice> qw = new LambdaQueryWrapper<>(); // 唯一性校验条件
        qw.eq(TourismNotice::getTitle, notice.getTitle()); // 标题唯一
        if (!noticeMapper.selectList(qw).isEmpty()) { // 若存在重复，返回失败
            log.error("标题重复");
            return false;
        }
        return noticeMapper.insert(notice) > 0; // 插入记录
    }
}