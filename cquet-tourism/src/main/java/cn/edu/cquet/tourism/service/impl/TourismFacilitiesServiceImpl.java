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
    /**
     * 设施列表查询
     * 条件：按 `facilitiesName` 模糊匹配（可选）
     */
    public List<TourismFacilities> getFacilitiesListByName(String facilitiesName) {
        LambdaQueryWrapper<TourismFacilities> queryWrapper = new LambdaQueryWrapper<>(); // 创建查询构造器
        if (StringUtils.isNotBlank(facilitiesName)) { // 仅当名称非空时追加条件
            queryWrapper.like(TourismFacilities::getFacilitiesName, facilitiesName); // 名称模糊匹配
        }
        return this.list(queryWrapper); // 执行查询返回列表
    }

}