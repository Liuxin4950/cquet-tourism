package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.domain.vo.ScenicSpotDetailVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

// 继承IService（通用服务层接口，封装了基础业务方法）
public interface TourismScenicSpotService extends IService<TourismScenicSpot> {
    
    /**
     * 根据查询条件获取景区列表
     * @param queryVo 查询条件VO
     * @return 符合条件的数据
     */
    List<TourismScenicSpot> getScenicSpotList(TourismScenicSpotQueryVo queryVo);
    
    /**
     * 添加景区
     * @param scenicSpot  新增的值
     * @return            操作结果
     */
    boolean addScenicSpot(TourismScenicSpot scenicSpot);
    
    /**
     * 更新景区信息
     * @param scenicSpot  更新的值
     * @return            操作结果
     */
    boolean updateScenicSpot(TourismScenicSpot scenicSpot);
    
    /**
     * 删除景区
     * @param ids  景区ID列表
     * @return     操作结果
     */
    boolean removeScenicSpotByIds(List<Long> ids);
    
    /**
     * 根据ID获取景区详情
     * @param id  景区ID
     * @return    景区信息
     */
    TourismScenicSpot getScenicSpotById(Long id);

    /**
     * 获取景区详情（含图片等关联）
     */
    ScenicSpotDetailVo getDetail(Long id);


    /**
     * 查询景区关联的图片列表
     */
    List<TourismImage> getImagesByScenicSpot(Long scenicSpotId);

    /**
     * 设置景区关联的图片（覆盖式）
     */
    boolean setImagesForScenicSpot(Long scenicSpotId, List<Integer> imageIds);
}
