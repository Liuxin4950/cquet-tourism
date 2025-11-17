package cn.edu.cquet.tourism.service.impl;

import cn.edu.cquet.common.annotation.Log;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.mapper.TourismVenueMapper;
import cn.edu.cquet.tourism.service.TourismVenueService;
import cn.edu.cquet.tourism.domain.TourismVenueImage;
import cn.edu.cquet.tourism.domain.TourismVenueFacilities;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.mapper.TourismVenueImageMapper;
import cn.edu.cquet.tourism.mapper.TourismVenueFacilitiesMapper;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import cn.edu.cquet.tourism.mapper.TourismFacilitiesMapper;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;

@Slf4j
@Service
public class TourismVenueServiceImpl extends ServiceImpl<TourismVenueMapper, TourismVenue> implements TourismVenueService {

    @Autowired
    private TourismVenueMapper tourismVenueMapper;

    @Autowired
    private TourismVenueImageMapper venueImageMapper;

    @Autowired
    private TourismVenueFacilitiesMapper venueFacilitiesMapper;

    @Autowired
    private TourismImageMapper imageMapper;

    @Autowired
    private TourismFacilitiesMapper facilitiesMapper;

    @Autowired
    private TourismActivityMapper activityMapper;

    @Override
    // 根据名称和地址查询场馆列表
    public List<TourismVenue> getVenueByNameAndAddress(String name, String address) {
        // 创建条件构造器
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>();
        // 添加查询条件
        queryWrapper.like(name != null && !name.isBlank(), TourismVenue::getName, name)
                .like(address != null && !address.isBlank(), TourismVenue::getAddress, address);
        queryWrapper.eq(TourismVenue::getDelFlag, "0");
        // 调用mapper方法，传入条件构造器，查询数据
        return tourismVenueMapper.selectList(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addVenue(TourismVenue venue) {
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismVenue::getName, venue.getName());
        List<TourismVenue> list = tourismVenueMapper.selectList(queryWrapper);
        if (!list.isEmpty()) {
            log.error("该场馆已存在");
            return false;
        }
        int inserted = tourismVenueMapper.insert(venue);
        if (inserted <= 0) return false;
        if (venue.getImageIds() != null && !venue.getImageIds().isEmpty()) {
            for (Integer imageId : venue.getImageIds()) {
                TourismVenueImage rel = new TourismVenueImage();
                rel.setVenueId(venue.getId());
                rel.setImageId(imageId);
                venueImageMapper.insert(rel);
            }
        }
        if (venue.getFacilitiesIds() != null && !venue.getFacilitiesIds().isEmpty()) {
            for (Integer fid : venue.getFacilitiesIds()) {
                TourismVenueFacilities rel = new TourismVenueFacilities();
                rel.setVenueId(venue.getId());
                rel.setFacilitiesId(fid);
                venueFacilitiesMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateVenue(TourismVenue venue) {
        if (venue.getId() == null) return false;
        LambdaQueryWrapper<TourismVenue> q = new LambdaQueryWrapper<>();
        q.eq(TourismVenue::getName, venue.getName()).ne(TourismVenue::getId, venue.getId());
        if (!tourismVenueMapper.selectList(q).isEmpty()) {
            log.error("该场馆已存在");
            return false;
        }
        int updated = tourismVenueMapper.updateById(venue);
        if (updated <= 0) return false;
        if (venue.getImageIds() != null) {
            LambdaQueryWrapper<TourismVenueImage> del = new LambdaQueryWrapper<>();
            del.eq(TourismVenueImage::getVenueId, venue.getId());
            venueImageMapper.delete(del);
            for (Integer imageId : venue.getImageIds()) {
                TourismVenueImage rel = new TourismVenueImage();
                rel.setVenueId(venue.getId());
                rel.setImageId(imageId);
                venueImageMapper.insert(rel);
            }
        }
        if (venue.getFacilitiesIds() != null) {
            LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>();
            del2.eq(TourismVenueFacilities::getVenueId, venue.getId());
            venueFacilitiesMapper.delete(del2);
            for (Integer fid : venue.getFacilitiesIds()) {
                TourismVenueFacilities rel = new TourismVenueFacilities();
                rel.setVenueId(venue.getId());
                rel.setFacilitiesId(fid);
                venueFacilitiesMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    public VenueDetailVo getDetail(Long id) {
        TourismVenue v = tourismVenueMapper.selectById(id);
        if (v == null) return null;
        VenueDetailVo vo = new VenueDetailVo();
        BeanUtils.copyProperties(v, vo);

        LambdaQueryWrapper<TourismVenueImage> q1 = new LambdaQueryWrapper<>();
        q1.eq(TourismVenueImage::getVenueId, v.getId());
        List<TourismVenueImage> vimgs = venueImageMapper.selectList(q1);
        if (!vimgs.isEmpty()) {
            // 获取图片关联表的所有id
            List<Integer> imageIds = vimgs.stream().map(TourismVenueImage::getImageId).collect(java.util.stream.Collectors.toList());
            List<TourismImage> images = imageMapper.selectBatchIds(imageIds);
            vo.setImages(images);
        }
        LambdaQueryWrapper<TourismVenueFacilities> q2 = new LambdaQueryWrapper<>();
        q2.eq(TourismVenueFacilities::getVenueId, v.getId());
        List<TourismVenueFacilities> vfs = venueFacilitiesMapper.selectList(q2);
        if (!vfs.isEmpty()) {
            List<Integer> fids = vfs.stream().map(TourismVenueFacilities::getFacilitiesId).collect(java.util.stream.Collectors.toList());
            List<TourismFacilities> facilities = facilitiesMapper.selectBatchIds(fids);
            vo.setFacilities(facilities);
        }
        return vo;
    }

    public List<TourismActivity> getActivitiesByVenueId(Integer venueId) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismActivity::getVenueId, venueId)
          .eq(TourismActivity::getDelFlag, "0")
          .eq(TourismActivity::getAuditStatus, "1")
          .eq(TourismActivity::getStatus, "0")
          .orderByDesc(TourismActivity::getCreateTime);
        return activityMapper.selectList(qw);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean removeVenueByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return false;
        LambdaQueryWrapper<TourismVenueImage> del1 = new LambdaQueryWrapper<>();
        del1.in(TourismVenueImage::getVenueId, ids);
        venueImageMapper.delete(del1);

        LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>();
        del2.in(TourismVenueFacilities::getVenueId, ids);
        venueFacilitiesMapper.delete(del2);

        return tourismVenueMapper.deleteBatchIds(ids) > 0;
    }
}
