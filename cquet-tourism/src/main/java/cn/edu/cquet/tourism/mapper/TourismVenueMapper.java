package cn.edu.cquet.tourism.mapper;

import cn.edu.cquet.tourism.domain.TourismVenue;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface TourismVenueMapper extends BaseMapper<TourismVenue> {
    /**
     * 根据id查询场馆信息
     * @param id  场馆id
     * @return    场馆信息
     */
    Map<String, Object> getVenueById(Long id);
}
