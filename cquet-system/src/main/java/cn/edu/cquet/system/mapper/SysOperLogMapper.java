package cn.edu.cquet.system.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.edu.cquet.system.domain.SysOperLog;

import java.util.List;

/**
 * 操作日志 数据层
 *
 *
 */
public interface SysOperLogMapper extends BaseMapper<SysOperLog> {


    /**
     * 查询系统操作日志集合
     *
     * @param operLog 操作日志对象
     * @return 操作日志集合
     */
    List<SysOperLog> selectOperLogList(SysOperLog operLog);

    /**
     * 清空操作日志
     */
    @InterceptorIgnore(blockAttack = "true")
    void cleanOperLog();
}
