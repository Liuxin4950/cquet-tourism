package cn.edu.cquet.tourism.domain;

import cn.edu.cquet.common.annotation.Excel;
import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.poi.hpsf.Decimal;

import java.math.BigDecimal;
import java.util.List;

// AbsEntity: 抽象实体类
@TableName("tourism_venue")
@Schema(description = "场馆信息") // 描述
@EqualsAndHashCode(callSuper = true) // 继承父类属性, 重写所有equals和hashCode方法
@Data
/**
 * 场馆实体
 *
 * 说明：
 * - 继承抽象实体 `AbsEntity`，包含通用审计字段。
 * - 与图片通过 `tourism_venue_image` 建立关联；与设施通过 `tourism_venue_facilities` 建立关联。
 * - 业务层通过 `imageIds`、`facilitiesIds` 辅助批量绑定关联。
 */
public class TourismVenue extends AbsEntity {
    @Schema(description = "主键，整型")
    @TableId(type = IdType.AUTO) // 主键自增
    private Integer id;

    @Schema(description = "场馆名称")
    @Size(min = 2, max = 20, message = "场馆名称长度不能小于2位或大于20位")
    private String name;

    @Schema(description = "场馆类别")
    private String category;

    @Schema(description = "场馆封面图片")
    @TableField("cover_image")
    private String coverImage;

//    @Schema(description = "场馆图片URL列表, 数组")
//    private String imageUrls;

    @Schema(description = "门票价格")
    // Decimal: BigDecimal，常用于金融，高精度计算
    @TableField("ticket_price")
    private BigDecimal ticketPrice;

    @Schema(description = "场馆地址")
    private String address;

    @Schema(description = "场馆所在城市")
    private String city;

    @Schema(description = "场馆所在区县")
    private String district;

    @Schema(description = "场馆开放时间")
    @TableField("opening_hours")
    private String openingHours;

    @Schema(description = "场馆联系电话")
    @TableField("contact_phone")
    @Size(min = 11, max = 11, message = "联系电话长度必须为11位")
    private String contactPhone;

    @Schema(description = "场馆网站")
    private String website;

    @Schema(description = "场馆描述")
    private String description;

    @Schema(description = "场馆经度")
    private BigDecimal longitude;

    @Schema(description = "场馆纬度")
    private BigDecimal latitude;

    @Schema(description = "场馆容纳人数")
    private Integer capacity;

//    @Schema(description = "设施信息")
//    private String facilities;

    @Schema(description = "是否需要预约")
    @TableField("booking_required")
    private String bookingRequired;

    @Schema(description = "场馆收藏次数")
    @TableField("collection_count")
    private Integer collectionCount;

    @Schema(description = "场馆访问次数")
    @TableField("view_count")
    private Integer viewCount;

    @Schema(description = "场馆状态")
    private String status; // 0：正常，1：停用

    @TableField(exist = false)
    private List<Integer> imageIds;

    @TableField(exist = false)
    private List<Integer> facilitiesIds;
}
