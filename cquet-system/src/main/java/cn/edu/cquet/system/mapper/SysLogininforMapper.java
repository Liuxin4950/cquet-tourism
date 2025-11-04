package cn.edu.cquet.system.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.edu.cquet.system.domain.SysLogininfor;

import java.util.List;

/**
 * 系统访问日志情况信息 数据层
 *
 *
 */
public interface SysLogininforMapper extends BaseMapper<SysLogininfor> {


    /**
     * 查询系统登录日志集合
     *
     * @param logininfor 访问日志对象
     * @return 登录记录集合
     */
    List<SysLogininfor> selectLogininforList(SysLogininfor logininfor);

    /**
     * 批量删除系统登录日志
     *
     * @param infoIds 需要删除的登录日志ID
     * @return 结果
     */
    int deleteLogininforByIds(Long[] infoIds);

    /**
     * 清空系统登录日志
     *
     * @return 结果
     */
    @InterceptorIgnore(blockAttack = "true")
    int cleanLogininfor();
}
