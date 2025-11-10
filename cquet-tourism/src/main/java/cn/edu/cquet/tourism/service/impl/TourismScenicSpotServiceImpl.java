package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotMapper;
import cn.edu.cquet.tourism.service.TourismScenicSpotService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
// 继承ServiceImpl类（通用服务层接口的实现类），最后实现service接口规定的方法
public class TourismScenicSpotServiceImpl extends ServiceImpl<TourismScenicSpotMapper, TourismScenicSpot> implements TourismScenicSpotService {

    @Autowired
    private TourismScenicSpotMapper tourismScenicSpotMapper;

    @Override
    public List<TourismScenicSpot> getScenicSpotList(TourismScenicSpotQueryVo queryVo) {
        // 创建条件构造器
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        
        // 添加查询条件
        queryWrapper.like(queryVo.getName() != null && !queryVo.getName().isBlank(), 
                         TourismScenicSpot::getName, queryVo.getName())
                   .eq(queryVo.getCity() != null && !queryVo.getCity().isBlank(), 
                       TourismScenicSpot::getCity, queryVo.getCity())
                   .eq(queryVo.getLevel() != null && !queryVo.getLevel().isBlank(), 
                       TourismScenicSpot::getLevel, queryVo.getLevel())
                   .ge(queryVo.getMinTicketPrice() != null, 
                       TourismScenicSpot::getTicketPrice, queryVo.getMinTicketPrice())
                   .le(queryVo.getMaxTicketPrice() != null, 
                       TourismScenicSpot::getTicketPrice, queryVo.getMaxTicketPrice())
                   .eq(queryVo.getStatus() != null && !queryVo.getStatus().isBlank(), 
                       TourismScenicSpot::getStatus, queryVo.getStatus())
                   .eq(TourismScenicSpot::getDelFlag, "0") // 只查询未删除的数据
                   .orderByDesc(TourismScenicSpot::getCreateTime); // 按创建时间降序排列
        
        // 调用mapper方法，传入条件构造器，查询数据
        return tourismScenicSpotMapper.selectList(queryWrapper);
    }

    @Override
    public boolean addScenicSpot(TourismScenicSpot scenicSpot) {
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        // 判断景区名称是否重复
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName());
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            return false; // 景区名称已存在
        }
        return tourismScenicSpotMapper.insert(scenicSpot) > 0;
    }

    @Override
    public boolean updateScenicSpot(TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() == null) {
            return false;
        }
        // 检查景区名称是否与其他景区重复（排除当前景区）
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName())
                .ne(TourismScenicSpot::getId, scenicSpot.getId());
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            return false; // 景区名称已存在
        }
        return tourismScenicSpotMapper.updateById(scenicSpot) > 0;
    }

    @Override
    public boolean removeScenicSpotByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            return false;
        }
        return tourismScenicSpotMapper.deleteBatchIds(ids) > 0;
    }

    @Override
    public TourismScenicSpot getScenicSpotById(Long id) {
        if (id == null) {
            return null;
        }
        return tourismScenicSpotMapper.selectById(id);
    }
}