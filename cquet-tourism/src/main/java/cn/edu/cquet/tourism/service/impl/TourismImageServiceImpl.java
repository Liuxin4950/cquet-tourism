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
    private TourismImageMapper imageMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 创建单条图片记录
     * 约束：`url` 必填
     */
    public TourismImage create(TourismImage image) {
        if (image == null || !StringUtils.hasText(image.getUrl())) {
            return null;
        }
        imageMapper.insert(image);
        return image;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量创建图片记录
     * 规则：忽略空 URL
     */
    public List<TourismImage> createBatch(List<String> urls) {
        List<TourismImage> result = new ArrayList<>();
        if (urls == null || urls.isEmpty()) {
            log.warn("图片URL列表为空");
            return result;
        }
        for (String url : urls) {
            // 忽略空字符串
            if (!StringUtils.hasText(url)) {
                continue;
            }
            TourismImage img = new TourismImage();
            img.setUrl(url);
            imageMapper.insert(img);
            result.add(img);
        }
        return result;
    }

    @Override
    /**
     * 按主键查询图片记录
     */
    public TourismImage getById(Integer id) {
        if (id == null) {
            return null;
        }
        return imageMapper.selectById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量删除图片记录
     */
    public boolean removeByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return false;
        }
        return imageMapper.deleteBatchIds(ids) > 0;
    }
}