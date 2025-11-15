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
public class TourismImageServiceImpl extends ServiceImpl<TourismImageMapper, TourismImage> implements TourismImageService {

    @Autowired
    private TourismImageMapper imageMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public TourismImage create(TourismImage image) {
        if (image == null || !StringUtils.hasText(image.getUrl())) {
            return null;
        }
        imageMapper.insert(image);
        return image;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
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
    public TourismImage getById(Integer id) {
        if (id == null) {
            return null;
        }
        return imageMapper.selectById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return false;
        }
        return imageMapper.deleteBatchIds(ids) > 0;
    }
}