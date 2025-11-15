package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.common.utils.StringUtils;
import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.mapper.TourismFacilitiesMapper;
import cn.edu.cquet.tourism.service.TourismFacilitiesService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 设备设施服务实现类
 * @author 
 * @date 2025-04-14
 */
@Service
public class TourismFacilitiesServiceImpl extends ServiceImpl<TourismFacilitiesMapper, TourismFacilities> implements TourismFacilitiesService {

    @Override
    public List<TourismFacilities> getFacilitiesListByName(String facilitiesName) {
        LambdaQueryWrapper<TourismFacilities> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotBlank(facilitiesName)) {
            queryWrapper.like(TourismFacilities::getFacilitiesName, facilitiesName);
        }
        return this.list(queryWrapper);
    }

}