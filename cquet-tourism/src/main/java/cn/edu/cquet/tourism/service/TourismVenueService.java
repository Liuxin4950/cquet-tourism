package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismVenue;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;

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
     * 根据名称、地址、城市模糊查询
     */
    List<TourismVenue> getVenueList(String name, String address, String city);

    /**
     * 添加场馆
     * @param venue   新增的值
     * @return        操作结果
     */
    boolean addVenue(TourismVenue venue);

    /**
     * 修改场馆
     */
    boolean updateVenue(TourismVenue venue);

    /**
     * 获取场馆详情（含图片、设施）
     */
    VenueDetailVo getDetail(Long id);

    /**
     * 删除场馆并清理关联
     */
    boolean removeVenueByIds(java.util.List<Integer> ids);


    /**
     * 查询场馆关联的图片列表
     */
    java.util.List<TourismImage> getImagesByVenue(Long venueId);

    /**
     * 设置场馆关联的图片（覆盖式）
     */
    boolean setImagesForVenue(Long venueId, List<Integer> imageIds);
}
