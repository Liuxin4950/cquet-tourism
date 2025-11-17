package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import io.swagger.v3.oas.annotations.media.Schema;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import java.math.BigDecimal;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
@TableName("tourism_scenic_spot")
@Schema(description = "旅游景点")    
/**
 * 景区实体
 *
 * 说明：
 * - 继承抽象实体 `AbsEntity`，包含通用字段（创建人/时间、更新人/时间、删除标记等）。
 * - 与图片存在多对多关系，通过中间表 `tourism_scenic_spot_image` 维护，业务层以 `imageIds` 辅助绑定。
 */
public class TourismScenicSpot extends AbsEntity {
    
    @Schema(description = "主键，整型")
    @TableId(type = IdType.AUTO) // 主键自增
    private Long id;
    
    @Schema(description = "景点名称")
    private String name;
    
    @Schema(description = "景点等级") 
    private String level;

    @Schema(description = "景点封面图片") 
    @TableField("cover_image")
    private String coverImage;

//    @Schema(description = "景点图片URL列表")
//    @TableField("image_urls")
//    private String imageUrls;

    @Schema(description = "门票价格") 
    @TableField("ticket_price")
    private BigDecimal ticketPrice;
    
    @Schema(description = "景点地址") 
    private String address;

    @Schema(description = "景点所在城市") 
    private String city;

    @Schema(description = "景点所在区县") 
    private String district;

    @Schema(description = "景点开放时间") 
    @TableField("opening_hours")
    private String openingHours;

    @Schema(description = "景点联系电话") 
    @TableField("contact_phone")
    private String contactPhone;

    @Schema(description = "景点网站") 
    private String website;

    @Schema(description = "景点描述") 
    private String description;

    @Schema(description = "景点经度") 
    private BigDecimal longitude;

    @Schema(description = "景点纬度") 
    private BigDecimal latitude;

    @Schema(description = "景点收藏数量") 
    @TableField("collection_count")
    private Integer collectionCount;

    @Schema(description = "景点访问数量") 
    @TableField("view_count")
    private Integer viewCount;

    @TableField(exist = false)
    private List<Integer> imageIds;
}
