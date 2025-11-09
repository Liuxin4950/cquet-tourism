package cn.edu.cquet.tourism.service;

<<<<<<< HEAD
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

// 继承IService（通用服务层接口，封装了基础业务方法）
public interface TourismScenicSpotService extends IService<TourismScenicSpot> {
    
    /**
     * 根据景区名称、城市、等级查询景区列表
     * @param name      景区名称
     * @param city      城市
     * @param level     景区等级
     * @return          符合条件的数据
     */
    List<TourismScenicSpot> getScenicSpotList(String name, String city, String level);
    
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
=======
import com.baomidou.mybatisplus.extension.service.IService;

import cn.edu.cquet.tourism.domain.TourismScenicSpot;

public interface TourismScenicSpotService extends IService<TourismScenicSpot> {

   
>>>>>>> d4825ad21a028c63c60839ae8d7ab1238da0d4e8
}
