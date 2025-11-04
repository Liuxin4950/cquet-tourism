package cn.edu.cquet.common.utils;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.edu.cquet.common.core.domain.abs.AbsEntity;
import cn.edu.cquet.common.core.domain.abs.AbsQuery;

/**
 * 分页工具类
 */
public class XtPageUtil {

    /**
     * 获取plus的分页对象
     * @param q
     * @param <T> 实体类
     * @param <Q> 查询类
     * @return
     */
    public static  <T extends AbsEntity, Q extends AbsQuery>  IPage<T> getPage(Q q, Class<T> c) {
        Page<T> page = new Page<T>()
                .setCurrent(q.getPageNum())
                .setSize(q.getPageSize());
        return page;
    }

}
