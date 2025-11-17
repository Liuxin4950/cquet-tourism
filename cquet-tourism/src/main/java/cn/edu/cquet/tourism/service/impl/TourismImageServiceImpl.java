package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import cn.edu.cquet.tourism.service.TourismImageService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;

@Service
/**
 * 图片服务实现
 *
 * 说明：仅维护图片基础记录（URL），不涉及文件存储；提供单条与批量创建、查询与删除。
 */
public class TourismImageServiceImpl extends ServiceImpl<TourismImageMapper, TourismImage> implements TourismImageService {

    @Autowired
    private TourismImageMapper imageMapper; // 图片表 Mapper

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 创建单条图片记录
     * 约束：`url` 必填
     */
    public TourismImage create(TourismImage image) {
        if (image == null || !StringUtils.hasText(image.getUrl())) { // 基本校验：对象存在且 URL 非空
            return null; // 违反约束直接返回
        }
        imageMapper.insert(image); // 插入图片记录
        return image; // 返回带主键的记录
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量创建图片记录
     * 规则：忽略空 URL
     */
    public List<TourismImage> createBatch(List<String> urls) {
        List<TourismImage> result = new ArrayList<>(); // 结果列表
        if (urls == null || urls.isEmpty()) { // 入参校验
            log.warn("图片URL列表为空"); // 提示但不抛异常
            return result; // 返回空列表
        }
        for (String url : urls) { // 遍历 URL
            if (!StringUtils.hasText(url)) { // 忽略空 URL
                continue;
            }
            TourismImage img = new TourismImage(); // 构造实体
            img.setUrl(url); // 设置 URL
            imageMapper.insert(img); // 插入记录
            result.add(img); // 收集结果
        }
        return result; // 返回创建记录集合
    }

    @Override
    /**
     * 按主键查询图片记录
     */
    public TourismImage getById(Integer id) {
        if (id == null) { // 基本校验
            return null;
        }
        return imageMapper.selectById(id); // 主键查询
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量删除图片记录
     */
    public boolean removeByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) { // 基本校验
            return false;
        }
        return imageMapper.deleteBatchIds(ids) > 0; // 批量删除
    }
}