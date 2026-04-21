package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import cn.edu.cquet.tourism.service.TourismImageService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.net.URI;
import java.util.Collection;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
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
        return ensureByUrl(image.getUrl());
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
            TourismImage img = ensureByUrl(url);
            if (img != null) {
                result.add(img);
            }
        }
        return result; // 返回创建记录集合
    }

    @Override
    /**
     * 按主键查询图片记录
     */
    public TourismImage getById(Long id) {
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
    public boolean removeByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) { // 基本校验
            return false;
        }
        return imageMapper.deleteBatchIds(ids) > 0; // 批量删除
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public TourismImage ensureByUrl(String url) {
        if (!StringUtils.hasText(url)) {
            return null;
        }
        LambdaQueryWrapper<TourismImage> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismImage::getUrl, url).last("LIMIT 1");
        TourismImage existing = imageMapper.selectOne(queryWrapper);
        if (existing != null) {
            return existing;
        }
        TourismImage image = new TourismImage();
        image.setUrl(url);
        fillMetadata(image);
        imageMapper.insert(image);
        return image;
    }

    @Override
    public Map<Long, TourismImage> getImageMap(Collection<Long> ids) {
        Map<Long, TourismImage> imageMap = new LinkedHashMap<>();
        if (ids == null || ids.isEmpty()) {
            return imageMap;
        }
        List<TourismImage> images = imageMapper.selectBatchIds(ids);
        for (TourismImage image : images) {
            imageMap.put(image.getId(), image);
        }
        return imageMap;
    }

    private void fillMetadata(TourismImage image) {
        String sanitizedUrl = sanitizeUrl(image.getUrl());
        String fileName = extractFileName(sanitizedUrl);
        image.setFileName(fileName);
        image.setOriginalName(fileName);
        image.setFileExt(extractFileExt(fileName));
        image.setStorageType(StringUtils.hasText(image.getStorageType()) ? image.getStorageType() : "local");
        image.setStatus(StringUtils.hasText(image.getStatus()) ? image.getStatus() : "0");
        image.setDelFlag(StringUtils.hasText(image.getDelFlag()) ? image.getDelFlag() : "0");
        if (image.getFileSize() == null) {
            image.setFileSize(0L);
        }
    }

    private String sanitizeUrl(String url) {
        if (!StringUtils.hasText(url)) {
            return "";
        }
        try {
            URI uri = URI.create(url);
            if (uri.getPath() != null) {
                return uri.getPath();
            }
        } catch (Exception ignored) {
            // 回退到字符串解析，兼容相对路径或不规范 URL。
        }
        int queryIndex = url.indexOf('?');
        return queryIndex >= 0 ? url.substring(0, queryIndex) : url;
    }

    private String extractFileName(String sanitizedUrl) {
        if (!StringUtils.hasText(sanitizedUrl)) {
            return null;
        }
        int slashIndex = sanitizedUrl.lastIndexOf('/');
        return slashIndex >= 0 ? sanitizedUrl.substring(slashIndex + 1) : sanitizedUrl;
    }

    private String extractFileExt(String fileName) {
        if (!StringUtils.hasText(fileName) || !fileName.contains(".")) {
            return null;
        }
        return fileName.substring(fileName.lastIndexOf('.') + 1);
    }
}
