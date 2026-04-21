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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneId;
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
        LambdaQueryWrapper<TourismScenicSpot> scenicWrapper = new LambdaQueryWrapper<>();
        scenicWrapper.eq(TourismScenicSpot::getDelFlag, "0");
        long scenicCount = scenicSpotMapper.selectCount(scenicWrapper);
        statistics.put("scenicCount", scenicCount);

        // 统计场馆数量
        LambdaQueryWrapper<TourismVenue> venueWrapper = new LambdaQueryWrapper<>();
        venueWrapper.eq(TourismVenue::getDelFlag, "0");
        long venueCount = venueMapper.selectCount(venueWrapper);
        statistics.put("venueCount", venueCount);

        // 统计活动数量
        LambdaQueryWrapper<TourismActivity> activityWrapper = new LambdaQueryWrapper<>();
        activityWrapper.eq(TourismActivity::getDelFlag, "0");
        long activityCount = activityMapper.selectCount(activityWrapper);
        statistics.put("activityCount", activityCount);

        // 统计待审核活动数量（状态为0表示待审核）
        LambdaQueryWrapper<TourismActivity> pendingWrapper = new LambdaQueryWrapper<>();
        pendingWrapper.eq(TourismActivity::getDelFlag, "0")
                .eq(TourismActivity::getAuditStatus, "0");
        long pendingCount = activityMapper.selectCount(pendingWrapper);
        statistics.put("pendingCount", pendingCount);

        return statistics;
    }

    @Override
    public List<Map<String, Object>> getDistrictDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询各区县景区数量
        LambdaQueryWrapper<TourismScenicSpot> scenicWrapper = new LambdaQueryWrapper<>();
        scenicWrapper.eq(TourismScenicSpot::getDelFlag, "0");
        List<TourismScenicSpot> scenicSpots = scenicSpotMapper.selectList(scenicWrapper);
        Map<String, Long> scenicDistrictCount = scenicSpots.stream()
                .map(TourismScenicSpot::getDistrict)
                .map(this::normalizeDistrict)
                .filter(Objects::nonNull)
                .collect(Collectors.groupingBy(district -> district, Collectors.counting()));

        // 查询各区县场馆数量
        LambdaQueryWrapper<TourismVenue> venueWrapper = new LambdaQueryWrapper<>();
        venueWrapper.eq(TourismVenue::getDelFlag, "0");
        List<TourismVenue> venues = venueMapper.selectList(venueWrapper);
        Map<String, Long> venueDistrictCount = venues.stream()
                .map(TourismVenue::getDistrict)
                .map(this::normalizeDistrict)
                .filter(Objects::nonNull)
                .collect(Collectors.groupingBy(district -> district, Collectors.counting()));

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

        // 按总量降序排序
        result.sort((a, b) -> Long.compare(
                toLong(b.get("scenicCount")) + toLong(b.get("venueCount")),
                toLong(a.get("scenicCount")) + toLong(a.get("venueCount"))
        ));

        return result;
    }

    @Override
    public List<Map<String, Object>> getHotSpotRanking() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询所有景区并按浏览量排序
        LambdaQueryWrapper<TourismScenicSpot> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TourismScenicSpot::getDelFlag, "0");
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
        LocalDate currentDate = LocalDate.now();
        LinkedHashMap<YearMonth, Long> monthlyCount = new LinkedHashMap<>();
        for (int i = 11; i >= 0; i--) {
            YearMonth month = YearMonth.from(currentDate.minusMonths(i));
            monthlyCount.put(month, 0L);
        }

        LambdaQueryWrapper<TourismActivity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TourismActivity::getDelFlag, "0");
        List<TourismActivity> activities = activityMapper.selectList(wrapper);

        for (TourismActivity activity : activities) {
            YearMonth activityMonth = resolveActivityMonth(activity);
            if (activityMonth != null && monthlyCount.containsKey(activityMonth)) {
                monthlyCount.merge(activityMonth, 1L, Long::sum);
            }
        }

        List<Map<String, Object>> result = new ArrayList<>();
        monthlyCount.forEach((month, count) -> {
            Map<String, Object> item = new HashMap<>();
            item.put("month", month.toString());
            item.put("count", count);
            result.add(item);
        });
        return result;
    }

    @Override
    public List<Map<String, Object>> getMapDistribution() {
        List<Map<String, Object>> result = new ArrayList<>();

        // 查询有经纬度的景区
        LambdaQueryWrapper<TourismScenicSpot> scenicWrapper = new LambdaQueryWrapper<>();
        scenicWrapper.eq(TourismScenicSpot::getDelFlag, "0")
                    .isNotNull(TourismScenicSpot::getLongitude)
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
        venueWrapper.eq(TourismVenue::getDelFlag, "0")
                    .isNotNull(TourismVenue::getLongitude)
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

    private String normalizeDistrict(String district) {
        if (district == null) {
            return null;
        }
        String normalized = district.trim();
        return normalized.isEmpty() ? null : normalized;
    }

    private long toLong(Object value) {
        return value instanceof Number ? ((Number) value).longValue() : 0L;
    }

    private YearMonth resolveActivityMonth(TourismActivity activity) {
        if (activity.getStartTime() != null) {
            LocalDateTime startTime = activity.getStartTime();
            return YearMonth.from(startTime);
        }
        if (activity.getCreateTime() != null) {
            return YearMonth.from(activity.getCreateTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
        }
        return null;
    }
}
