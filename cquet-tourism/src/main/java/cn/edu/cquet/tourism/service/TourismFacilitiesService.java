package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismFacilities;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 设备设施Service接口
 *
 * @author 
 * @date 2025-04-14
 */
public interface TourismFacilitiesService extends IService<TourismFacilities>
{
    /**
     * 根据名称查询设备设施列表
     *
     * @param facilitiesName 设备设施名称
     * @return 设备设施列表
     */
    List<TourismFacilities> getFacilitiesListByName(String facilitiesName);
}