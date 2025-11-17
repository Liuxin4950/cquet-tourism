package cn.edu.cquet.tourism.domain.vo;

import lombok.Data;

@Data
/**
 * 新闻查询条件 VO
 *
 * 说明：用于列表查询的条件载体，包含标题与起止日期字符串。
 */
public class TourismNewsVo {
    /** 新闻标题（模糊查询） */
    private String title;
    /** 起始日期（字符串） */
    private String startDate;
    /** 结束日期（字符串） */
    private String endDate;
}
