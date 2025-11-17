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
public class TourismNoticeServiceImpl extends ServiceImpl<TourismNoticeMapper, TourismNotice> implements TourismNoticeService {

    @Autowired
    private TourismNoticeMapper noticeMapper;

    @Override
    public List<TourismNotice> getByTitleAndTime(String title, String startTime, String endTime) {
        LambdaQueryWrapper<TourismNotice> qw = new LambdaQueryWrapper<>();
        qw.like(title != null && !title.isBlank(), TourismNotice::getTitle, title)
          .between(startTime != null && endTime != null && !startTime.isBlank() && !endTime.isBlank(),
                   TourismNotice::getCreateTime, startTime, endTime);
        return noticeMapper.selectList(qw);
    }

    @Override
    public boolean addNotice(TourismNotice notice) {
        LambdaQueryWrapper<TourismNotice> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismNotice::getTitle, notice.getTitle());
        if (!noticeMapper.selectList(qw).isEmpty()) {
            log.error("标题重复");
            return false;
        }
        return noticeMapper.insert(notice) > 0;
    }
}