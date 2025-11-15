package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotMapper;
import cn.edu.cquet.tourism.service.TourismScenicSpotService;
import cn.edu.cquet.tourism.domain.vo.ScenicSpotDetailVo;
import cn.edu.cquet.tourism.domain.TourismScenicSpotImage;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotImageMapper;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
// 继承ServiceImpl类（通用服务层接口的实现类），最后实现service接口规定的方法
public class TourismScenicSpotServiceImpl extends ServiceImpl<TourismScenicSpotMapper, TourismScenicSpot> implements TourismScenicSpotService {

    @Autowired
    private TourismScenicSpotMapper tourismScenicSpotMapper;

    @Autowired
    private TourismScenicSpotImageMapper scenicSpotImageMapper;

    @Autowired
    private TourismImageMapper imageMapper;

    @Override
    public List<TourismScenicSpot> getScenicSpotList(TourismScenicSpotQueryVo queryVo) {
        // 创建条件构造器
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        
        // 添加查询条件
        queryWrapper.like(queryVo.getName() != null && !queryVo.getName().isBlank(), 
                         TourismScenicSpot::getName, queryVo.getName())
                   .eq(queryVo.getCity() != null && !queryVo.getCity().isBlank(), 
                       TourismScenicSpot::getCity, queryVo.getCity())
                   .eq(queryVo.getLevel() != null && !queryVo.getLevel().isBlank(), 
                       TourismScenicSpot::getLevel, queryVo.getLevel())
                   .ge(queryVo.getMinTicketPrice() != null, 
                       TourismScenicSpot::getTicketPrice, queryVo.getMinTicketPrice())
                   .le(queryVo.getMaxTicketPrice() != null, 
                       TourismScenicSpot::getTicketPrice, queryVo.getMaxTicketPrice())
                   .eq(queryVo.getStatus() != null && !queryVo.getStatus().isBlank(), 
                       TourismScenicSpot::getStatus, queryVo.getStatus())
                   .eq(TourismScenicSpot::getDelFlag, "0") // 只查询未删除的数据
                   .orderByDesc(TourismScenicSpot::getCreateTime); // 按创建时间降序排列
        
        // 调用mapper方法，传入条件构造器，查询数据
        return tourismScenicSpotMapper.selectList(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addScenicSpot(TourismScenicSpot scenicSpot) {
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        // 判断景区名称是否重复
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName());
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            log.error("该景区已存在");
            return false; // 景区名称已存在
        }
        int inserted = tourismScenicSpotMapper.insert(scenicSpot);
        if (inserted <= 0) return false;
        if (scenicSpot.getImageIds() != null && !scenicSpot.getImageIds().isEmpty()) {
            for (Integer imageId : scenicSpot.getImageIds()) {
                TourismScenicSpotImage rel = new TourismScenicSpotImage();
                rel.setScenicSpotId(scenicSpot.getId().intValue());
                rel.setImageId(imageId);
                scenicSpotImageMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateScenicSpot(TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() == null) {
            log.error("修改时，id不能为空");
            return false;
        }
        // 检查景区名称是否与其他景区重复（排除当前景区）
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName())
                .ne(TourismScenicSpot::getId, scenicSpot.getId());
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            log.error("该景区已存在");
            return false; // 景区名称已存在
        }
        int updated = tourismScenicSpotMapper.updateById(scenicSpot);
        if (updated <= 0) return false;
        if (scenicSpot.getImageIds() != null) {
            LambdaQueryWrapper<TourismScenicSpotImage> del = new LambdaQueryWrapper<>();
            del.eq(TourismScenicSpotImage::getScenicSpotId, scenicSpot.getId().intValue());
            scenicSpotImageMapper.delete(del);
            for (Integer imageId : scenicSpot.getImageIds()) {
                TourismScenicSpotImage rel = new TourismScenicSpotImage();
                rel.setScenicSpotId(scenicSpot.getId().intValue());
                rel.setImageId(imageId);
                scenicSpotImageMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeScenicSpotByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) {
            log.error("删除时，id不能为空");
            return false;
        }
        // 先清理关联
        LambdaQueryWrapper<TourismScenicSpotImage> del = new LambdaQueryWrapper<>();
        del.in(TourismScenicSpotImage::getScenicSpotId, ids.stream().map(Long::intValue).collect(java.util.stream.Collectors.toList()));
        scenicSpotImageMapper.delete(del);
        // 逻辑删除主表
        return tourismScenicSpotMapper.deleteBatchIds(ids) > 0;
    }

    @Override
    public TourismScenicSpot getScenicSpotById(Long id) {
        if (id == null) {
            log.error("查询时，id不能为空");
            return null;
        }
        return tourismScenicSpotMapper.selectById(id);
    }

    @Override
    public ScenicSpotDetailVo getDetail(Long id) {
        TourismScenicSpot spot = getScenicSpotById(id);
        if (spot == null) return null;
        ScenicSpotDetailVo vo = new ScenicSpotDetailVo();
        BeanUtils.copyProperties(spot, vo);

        LambdaQueryWrapper<TourismScenicSpotImage> q = new LambdaQueryWrapper<>();
        q.eq(TourismScenicSpotImage::getScenicSpotId, spot.getId().intValue());
        List<TourismScenicSpotImage> rels = scenicSpotImageMapper.selectList(q);
        if (!rels.isEmpty()) {
            List<Integer> imageIds = rels.stream().map(TourismScenicSpotImage::getImageId).collect(java.util.stream.Collectors.toList());
            List<TourismImage> images = imageMapper.selectBatchIds(imageIds);
            vo.setImages(images);
        }
        return vo;
    }
}