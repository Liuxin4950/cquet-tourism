package cn.edu.cquet.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.edu.cquet.system.domain.SysOperLog;
import cn.edu.cquet.system.mapper.SysOperLogMapper;
import cn.edu.cquet.system.service.ISysOperLogService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * 操作日志 服务层处理
 *
 *
 */
@Service
public class SysOperLogServiceImpl extends ServiceImpl<SysOperLogMapper, SysOperLog> implements ISysOperLogService {


    /**
     * 新增操作日志
     *
     * @param operLog 操作日志对象
     */
    @Override
    public void insertOperlog(SysOperLog operLog) {
        this.baseMapper.insert(operLog);
    }

    /**
     * 查询系统操作日志集合
     *
     * @param operLog 操作日志对象
     * @return 操作日志集合
     */
    @Override
    public List<SysOperLog> selectOperLogList(SysOperLog operLog) {
        return this.baseMapper.selectOperLogList(operLog);
    }

    /**
     * 批量删除系统操作日志
     *
     * @param operIds 需要删除的操作日志ID
     * @return 结果
     */
    @Override
    public int deleteOperLogByIds(Long[] operIds) {
        return this.baseMapper.deleteBatchIds(Arrays.asList(operIds));
    }

    /**
     * 清空操作日志
     */
    @Override
    public void cleanOperLog() {
        this.baseMapper.cleanOperLog();
    }
}
