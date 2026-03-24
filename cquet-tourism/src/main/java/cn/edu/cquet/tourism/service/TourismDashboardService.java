package cn.edu.cquet.tourism.service;

import java.util.List;
import java.util.Map;

public interface TourismDashboardService {

    /**
     * 获取统计数据
     * @return 统计数据对象
     */
    Map<String, Object> getStatistics();

    /**
     * 获取各区县景区分布
     * @return 区县分布数据
     */
    List<Map<String, Object>> getDistrictDistribution();

    /**
     * 获取景区热度排行
     * @return 热度排行数据
     */
    List<Map<String, Object>> getHotSpotRanking();

    /**
     * 获取活动趋势数据
     * @return 月度活动数量趋势
     */
    List<Map<String, Object>> getActivityTrend();

    /**
     * 获取地图分布数据
     * @return 地图标注数据
     */
    List<Map<String, Object>> getMapDistribution();
}
