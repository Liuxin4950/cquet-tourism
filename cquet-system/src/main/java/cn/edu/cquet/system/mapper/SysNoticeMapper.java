package cn.edu.cquet.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.edu.cquet.system.domain.SysNotice;

import java.util.List;

/**
 * 通知公告表 数据层
 *
 *
 */
public interface SysNoticeMapper extends BaseMapper<SysNotice> {
    /**
     * 查询公告列表
     *
     * @param notice 公告信息
     * @return 公告集合
     */
    List<SysNotice> selectNoticeList(SysNotice notice);


}
