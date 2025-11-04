package cn.edu.cquet.common.core.domain.abs;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;


@Data
public abstract class AbsForm {

    /** 创建时间 */
    @Schema(description = "创建时间",required = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    private Date createTime;

    /** 修改时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    @Schema(description = "修改时间",required = false)
    private Date updateTime;

    /**是否删除,0代表存在 2代表删除*/
    @Schema(description = "是否删除,0代表存在 2代表删除",required = false)
    private String delFlag;

    @Schema(description = "状态（0正常 1停用）",required = false)
    private String status;

    /** 创建者 */
    @Schema(description = "创建者",required = false)
    private String createBy;

    /** 更新者 */
    @Schema(description = "更新者",required = false)
    private String updateBy;

    /** 备注 */
    @Schema(description = "备注",required = false)
    private String remark;

}
