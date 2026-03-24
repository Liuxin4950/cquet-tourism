package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotMapper;
import cn.edu.cquet.tourism.mapper.TourismVenueMapper;
import cn.edu.cquet.tourism.service.TourismDashboardService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TourismDashboardServiceImpl implements TourismDashboardService {

    @Autowired
    private TourismScenicSpotMapper scenicSpotMapper;

    @Autowired
    private TourismVenueMapper venueMapper;

    @Autowired
    private TourismActivityMapper activityMapper;

    @Override
    public Map<String, Object> getStatistics() {
        Map<String, Object> statistics = new HashMap<>();

        // 统计景区数量
        long scenicCount = scenicSpotMapper.selectCount(null);
        statistics.put("scenicCount", scenicCount);

        // 统计场馆数量
        long venueCount = venueMapper.selectCount(null);
        statistics.put("venueCount", venueCount);

        // 统计活动数量
        long activityCount = activityMapper.selectCount(null);
        statistics.put("activityCount", activityCount);

        // 统计待审核活动数量（状态为0表示待审核）
        LambdaQueryWrapper<TourismActivity> pendingWrapper = new LambdaQueryWrapper<>();
        pendingWrapper.eq(TourismActivity::getStatus, "0");
        long pendingCount = activityMapper.selectCount(pendingWrapper);
        statistics.put("pendingCount", pendingCount);

        return statistics;
    }

    @Override
    public List<Map<String, Object>> getDistrictDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询各区县景区数量
        List<TourismScenicSpot> scenicSpots = scenicSpotMapper.selectList(null);
        Map<String, Long> scenicDistrictCount = scenicSpots.stream()
                .filter(s -> s.getDistrict() != null && !s.getDistrict().isEmpty())
                .collect(Collectors.groupingBy(TourismScenicSpot::getDistrict, Collectors.counting()));

        // 查询各区县场馆数量
        List<TourismVenue> venues = venueMapper.selectList(null);
        Map<String, Long> venueDistrictCount = venues.stream()
                .filter(v -> v.getDistrict() != null && !v.getDistrict().isEmpty())
                .collect(Collectors.groupingBy(TourismVenue::getDistrict, Collectors.counting()));

        // 合并数据
        Set<String> allDistricts = new HashSet<>();
        allDistricts.addAll(scenicDistrictCount.keySet());
        allDistricts.addAll(venueDistrictCount.keySet());

        for (String district : allDistricts) {
            Map<String, Object> item = new HashMap<>();
            item.put("district", district);
            item.put("scenicCount", scenicDistrictCount.getOrDefault(district, 0L));
            item.put("venueCount", venueDistrictCount.getOrDefault(district, 0L));
            result.add(item);
        }

        // 按景区数量降序排序
        result.sort((a, b) -> Long.compare(
                (Long) b.getOrDefault("scenicCount", 0L),
                (Long) a.getOrDefault("scenicCount", 0L)
        ));

        return result;
    }

    @Override
    public List<Map<String, Object>> getHotSpotRanking() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询所有景区并按浏览量排序
        LambdaQueryWrapper<TourismScenicSpot> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(TourismScenicSpot::getViewCount);
        wrapper.last("LIMIT 10");

        List<TourismScenicSpot> scenicSpots = scenicSpotMapper.selectList(wrapper);

        for (TourismScenicSpot spot : scenicSpots) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", spot.getName());
            item.put("viewCount", spot.getViewCount() != null ? spot.getViewCount() : 0);
            item.put("collectionCount", spot.getCollectionCount() != null ? spot.getCollectionCount() : 0);
            item.put("level", spot.getLevel());
            result.add(item);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getActivityTrend() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询所有活动
        List<TourismActivity> activities = activityMapper.selectList(null);

        // 按月份统计
        Map<String, Long> monthlyCount = new HashMap<>();
        for (int i = 1; i <= 12; i++) {
            monthlyCount.put(String.valueOf(i), 0L);
        }

        for (TourismActivity activity : activities) {
            if (activity.getCreateTime() != null) {
                String month = String.valueOf(activity.getCreateTime().getMonth() + 1);
                monthlyCount.merge(month, 1L, Long::sum);
            }
        }

        // 转换为列表
        for (int i = 1; i <= 12; i++) {
            Map<String, Object> item = new HashMap<>();
            item.put("month", i + "月");
            item.put("count", monthlyCount.getOrDefault(String.valueOf(i), 0L));
            result.add(item);
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getMapDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询有经纬度的景区
        LambdaQueryWrapper<TourismScenicSpot> scenicWrapper = new LambdaQueryWrapper<>();
        scenicWrapper.isNotNull(TourismScenicSpot::getLongitude)
                    .isNotNull(TourismScenicSpot::getLatitude);
        List<TourismScenicSpot> scenicSpots = scenicSpotMapper.selectList(scenicWrapper);

        for (TourismScenicSpot spot : scenicSpots) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", spot.getName());
            item.put("longitude", spot.getLongitude());
            item.put("latitude", spot.getLatitude());
            item.put("type", "scenic");
            item.put("level", spot.getLevel());
            item.put("viewCount", spot.getViewCount() != null ? spot.getViewCount() : 0);
            result.add(item);
        }

        // 查询有经纬度的场馆
        LambdaQueryWrapper<TourismVenue> venueWrapper = new LambdaQueryWrapper<>();
        venueWrapper.isNotNull(TourismVenue::getLongitude)
                    .isNotNull(TourismVenue::getLatitude);
        List<TourismVenue> venues = venueMapper.selectList(venueWrapper);

        for (TourismVenue venue : venues) {
            Map<String, Object> item = new HashMap<>();
            item.put("name", venue.getName());
            item.put("longitude", venue.getLongitude());
            item.put("latitude", venue.getLatitude());
            item.put("type", "venue");
            item.put("category", venue.getCategory());
            item.put("viewCount", venue.getViewCount() != null ? venue.getViewCount() : 0);
            result.add(item);
        }

        return result;
    }
}
