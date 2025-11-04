package cn.edu.cquet.common.core.domain.abs;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 基础分页查询，默认第一页，每页10条
 */
@Data
public class AbsQuery {

    @Schema(description = "当前页", required = true)
    private Long pageNum = 1L;

    @Schema(description = "每页条数", required = true)
    private Long pageSize = 10L;

    @Schema(description = "偏移量")
    private Long offset;

    @Schema(description = "状态",required = false)
    private String status;

    @Schema(description = "删除标志（0代表存在 2代表删除）")
    private String delFlag;

    public static Long getOffset(Long pageNum) {
    	return pageNum-1L;
	}

}
