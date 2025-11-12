package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismVenue;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

public interface TourismVenueService extends IService<TourismVenue> {
    /**
     * 根据名称和地址模糊查询
     * @param name      名称
     * @param address   地址
     * @return          符合条件数据
     */
    List<TourismVenue> getVenueByNameAndAddress(String name, String address);

    /**
     * 添加场馆
     * @param venue   新增的值
     * @return        操作结果
     */
    boolean addVenue(TourismVenue venue);
}
