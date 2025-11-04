package cn.edu.cquet.common.core.domain.abs;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Entity基类
 *
 */
@Data
public abstract class AbsEntity<T extends Model> extends Model {


    /** 创建时间 */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    @Schema(description = "创建时间",required = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    private Date createTime;

    /** 修改时间 */
    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    @Schema(description = "修改时间",required = false)
    private Date updateTime;

    /**是否删除,0代表存在 2代表删除*/
    @TableField(value = "del_flag", fill = FieldFill.INSERT_UPDATE)
    @Schema(description = "是否删除,0代表存在 2代表删除",required = false)
    private String delFlag;

    @Schema(description = "状态（0正常 1停用）",required = false)
    private String status;

    /** 创建者 */
    @TableField(value = "create_by", fill = FieldFill.INSERT)
    @Schema(description = "创建者",required = false)
    private String createBy;

    /** 更新者 */
    @TableField(value = "update_by", fill = FieldFill.UPDATE)
    @Schema(description = "更新者",required = false)
    private String updateBy;

    /** 备注*/
    @Schema(description = "备注",required = false)
    private String remark;


    /** 请求参数 */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    @TableField(exist = false)
    private Map<String, Object> params;


    public Map<String, Object> getParams()
    {
        if (params == null)
        {
            params = new HashMap<>();
        }
        return params;
    }

    public void setParams(Map<String, Object> params)
    {
        this.params = params;
    }


}
