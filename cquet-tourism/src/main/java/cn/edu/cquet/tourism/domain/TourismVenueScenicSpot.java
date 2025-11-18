package cn.edu.cquet.tourism.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "场馆-景区关联表")
@TableName("tourism_venue_scenic_spot")
public class TourismVenueScenicSpot {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("venue_id")
    private Long venueId;

    @TableField("scenic_spot_id")
    private Long scenicSpotId;

    @TableField("sort")
    private Integer sort;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Long getVenueId() { return venueId; }
    public void setVenueId(Long venueId) { this.venueId = venueId; }
    public Long getScenicSpotId() { return scenicSpotId; }
    public void setScenicSpotId(Long scenicSpotId) { this.scenicSpotId = scenicSpotId; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
}