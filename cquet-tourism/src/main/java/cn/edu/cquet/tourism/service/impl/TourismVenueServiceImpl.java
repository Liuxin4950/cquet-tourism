package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.mapper.TourismVenueMapper;
import cn.edu.cquet.tourism.service.TourismVenueService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Slf4j
@Service
public class TourismVenueServiceImpl extends ServiceImpl<TourismVenueMapper, TourismVenue> implements TourismVenueService {

    @Autowired
    private TourismVenueMapper tourismVenueMapper;

    @Override
    // 根据名称和地址查询场馆列表
    public List<TourismVenue> getVenueByNameAndAddress(String name, String address) {
        // 创建条件构造器
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>();
        // 添加查询条件
        queryWrapper.like(name != null && !name.isBlank(), TourismVenue::getName, name)
                .like(address != null && !address.isBlank(), TourismVenue::getAddress, address);
        // 调用mapper方法，传入条件构造器，查询数据
        return tourismVenueMapper.selectList(queryWrapper);
    }

    @Override
    public boolean addVenue(TourismVenue venue) {
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismVenue::getName, venue.getName());
        List<TourismVenue> list = tourismVenueMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            log.error("该场馆已存在");
            return false;
        }
        return tourismVenueMapper.insert(venue) > 0;
    }
}
