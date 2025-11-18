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
import cn.edu.cquet.tourism.domain.TourismVenueScenicSpot;
import cn.edu.cquet.tourism.mapper.TourismVenueScenicSpotMapper;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotMapper;
// duplicate imports removed

@Slf4j
@Service
/**
 * 场馆服务实现
 *
 * 说明：
 * - 继承 MyBatis-Plus `ServiceImpl`，实现 `TourismVenueService` 业务方法。
 * - 维护与图片、设施、活动的多表关联关系。
 */
public class TourismVenueServiceImpl extends ServiceImpl<TourismVenueMapper, TourismVenue> implements TourismVenueService {

    @Autowired
    private TourismVenueMapper tourismVenueMapper; // 场馆主表 Mapper

    @Autowired
    private TourismVenueImageMapper venueImageMapper; // 场馆-图片关联 Mapper

    @Autowired
    private TourismVenueFacilitiesMapper venueFacilitiesMapper; // 场馆-设施关联 Mapper

    @Autowired
    private TourismImageMapper imageMapper; // 图片 Mapper

    @Autowired
    private TourismFacilitiesMapper facilitiesMapper; // 设施 Mapper

    @Autowired
    private TourismActivityMapper activityMapper; // 活动 Mapper

    @Autowired
    private TourismVenueScenicSpotMapper venueScenicSpotMapper; // 场馆-景区关联 Mapper

    @Autowired
    private TourismScenicSpotMapper scenicSpotMapper; // 景区 Mapper

    // duplicate fields removed (venueImageMapper, imageMapper)

    @Override
    /**
     * 根据名称和地址查询场馆列表
     * 条件：名称、地址支持模糊；仅查询未删除的数据
     */
    public List<TourismVenue> getVenueByNameAndAddress(String name, String address) {
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>(); // 创建查询构造器
        queryWrapper.like(name != null && !name.isBlank(), TourismVenue::getName, name) // 名称模糊查询
                .like(address != null && !address.isBlank(), TourismVenue::getAddress, address); // 地址模糊查询
        queryWrapper.eq(TourismVenue::getDelFlag, "0"); // 仅查询未删除的数据
        return tourismVenueMapper.selectList(queryWrapper); // 执行查询
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 新增场馆
     * 规则：名称唯一；保存主表后同步图片与设施关联关系
     */
    public boolean addVenue(TourismVenue venue) {
        LambdaQueryWrapper<TourismVenue> queryWrapper = new LambdaQueryWrapper<>(); // 唯一性校验条件
        queryWrapper.eq(TourismVenue::getName, venue.getName()); // 以名称作为唯一约束
        List<TourismVenue> list = tourismVenueMapper.selectList(queryWrapper); // 执行查询
        if (!list.isEmpty()) { // 存在同名则失败
            log.error("该场馆已存在");
            return false;
        }
        int inserted = tourismVenueMapper.insert(venue); // 插入主表
        if (inserted <= 0) return false; // 插入失败
        // 处理图片关联：若传入 imageIds，则批量插入关联表
        if (venue.getImageIds() != null && !venue.getImageIds().isEmpty()) {
            for (Integer imageId : venue.getImageIds()) {
                TourismVenueImage rel = new TourismVenueImage(); // 关联对象
                rel.setVenueId(venue.getId()); // 绑定场馆ID
                rel.setImageId(imageId); // 绑定图片ID
                venueImageMapper.insert(rel); // 插入关联
            }
        }
        // 处理设施关联：若传入 facilitiesIds，则批量插入关联表
        if (venue.getFacilitiesIds() != null && !venue.getFacilitiesIds().isEmpty()) {
            for (Integer fid : venue.getFacilitiesIds()) {
                TourismVenueFacilities rel = new TourismVenueFacilities(); // 关联对象
                rel.setVenueId(venue.getId()); // 绑定场馆ID
                rel.setFacilitiesId(fid); // 绑定设施ID
                venueFacilitiesMapper.insert(rel); // 插入关联
            }
        }
        return true; // 成功
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新场馆
     * 规则：排除自身后名称唯一；更新主表；若携带 `imageIds`/`facilitiesIds`，先清理旧关联再重建
     */
    public boolean updateVenue(TourismVenue venue) {
        if (venue.getId() == null) return false; // 更新必须携带主键
        LambdaQueryWrapper<TourismVenue> q = new LambdaQueryWrapper<>(); // 唯一性校验
        q.eq(TourismVenue::getName, venue.getName()).ne(TourismVenue::getId, venue.getId()); // 同名但排除自身
        if (!tourismVenueMapper.selectList(q).isEmpty()) { // 有冲突则失败
            log.error("该场馆已存在");
            return false;
        }
        int updated = tourismVenueMapper.updateById(venue); // 更新主表
        if (updated <= 0) return false; // 更新失败
        // 更新图片关联：若提供 imageIds，则先删后插重建关联
        if (venue.getImageIds() != null) {
            LambdaQueryWrapper<TourismVenueImage> del = new LambdaQueryWrapper<>(); // 删除条件
            del.eq(TourismVenueImage::getVenueId, venue.getId()); // 绑定场馆ID
            venueImageMapper.delete(del); // 删除旧关联
            for (Integer imageId : venue.getImageIds()) { // 重建关联
                TourismVenueImage rel = new TourismVenueImage();
                rel.setVenueId(venue.getId());
                rel.setImageId(imageId);
                venueImageMapper.insert(rel);
            }
        }
        // 更新设施关联：若提供 facilitiesIds，则先删后插重建关联
        if (venue.getFacilitiesIds() != null) {
            LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>(); // 删除条件
            del2.eq(TourismVenueFacilities::getVenueId, venue.getId()); // 绑定场馆ID
            venueFacilitiesMapper.delete(del2); // 删除旧关联
            for (Integer fid : venue.getFacilitiesIds()) { // 重建关联
                TourismVenueFacilities rel = new TourismVenueFacilities();
                rel.setVenueId(venue.getId());
                rel.setFacilitiesId(fid);
                venueFacilitiesMapper.insert(rel);
            }
        }
        return true; // 成功
    }

    @Override
    /**
     * 场馆详情
     * 内容：主表信息 + 图片列表 + 设施列表
     */
    public VenueDetailVo getDetail(Long id) {
        TourismVenue v = tourismVenueMapper.selectById(id); // 主键查询场馆
        if (v == null) return null; // 不存在直接返回
        VenueDetailVo vo = new VenueDetailVo(); // 创建详情 VO
        BeanUtils.copyProperties(v, vo); // 拷贝主表字段

        LambdaQueryWrapper<TourismVenueImage> q1 = new LambdaQueryWrapper<>(); // 查询图片关联
        q1.eq(TourismVenueImage::getVenueId, v.getId()); // venue_id=当前场馆ID
        List<TourismVenueImage> vimgs = venueImageMapper.selectList(q1); // 关联记录列表
        if (!vimgs.isEmpty()) {
            List<Integer> imageIds = vimgs.stream().map(TourismVenueImage::getImageId).collect(java.util.stream.Collectors.toList()); // 提取图片ID
            List<TourismImage> images = imageMapper.selectBatchIds(imageIds); // 批量查询图片
            vo.setImages(images); // 设置图片列表
        }
        LambdaQueryWrapper<TourismVenueFacilities> q2 = new LambdaQueryWrapper<>(); // 查询设施关联
        q2.eq(TourismVenueFacilities::getVenueId, v.getId()); // venue_id=当前场馆ID
        List<TourismVenueFacilities> vfs = venueFacilitiesMapper.selectList(q2); // 关联记录列表
        if (!vfs.isEmpty()) {
            List<Integer> fids = vfs.stream().map(TourismVenueFacilities::getFacilitiesId).collect(java.util.stream.Collectors.toList()); // 提取设施ID
            List<TourismFacilities> facilities = facilitiesMapper.selectBatchIds(fids); // 批量查询设施
            vo.setFacilities(facilities); // 设置设施列表
        }
        // 追加：场馆关联的景区列表
        LambdaQueryWrapper<TourismVenueScenicSpot> q3 = new LambdaQueryWrapper<>();
        q3.eq(TourismVenueScenicSpot::getVenueId, v.getId());
        java.util.List<TourismVenueScenicSpot> vss = venueScenicSpotMapper.selectList(q3);
        if (!vss.isEmpty()) {
            java.util.List<Long> spotIds = vss.stream().map(TourismVenueScenicSpot::getScenicSpotId).collect(java.util.stream.Collectors.toList());
            java.util.List<cn.edu.cquet.tourism.domain.TourismScenicSpot> spots = scenicSpotMapper.selectBatchIds(spotIds);
            vo.setScenicSpots(spots);
        }
        return vo; // 返回详情
    }

    /**
     * 查询场馆下的活动列表
     * 条件：未删除、审核通过、状态正常；按创建时间倒序
     */
    public List<TourismActivity> getActivitiesByVenueId(Integer venueId) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>(); // 构造查询
        qw.eq(TourismActivity::getVenueId, venueId) // 指定场馆ID
          .eq(TourismActivity::getDelFlag, "0") // 未删除
          .eq(TourismActivity::getAuditStatus, "1") // 审核通过
          .eq(TourismActivity::getStatus, "0") // 状态正常
          .orderByDesc(TourismActivity::getCreateTime); // 按创建时间倒序
        return activityMapper.selectList(qw); // 执行查询
    }

    @Override
    public java.util.List<cn.edu.cquet.tourism.domain.TourismScenicSpot> getScenicSpotsByVenue(Long venueId) {
        LambdaQueryWrapper<TourismVenueScenicSpot> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismVenueScenicSpot::getVenueId, venueId);
        java.util.List<TourismVenueScenicSpot> rels = venueScenicSpotMapper.selectList(qw);
        if (rels.isEmpty()) return java.util.Collections.emptyList();
        java.util.List<Long> ids = rels.stream().map(TourismVenueScenicSpot::getScenicSpotId).collect(java.util.stream.Collectors.toList());
        return scenicSpotMapper.selectBatchIds(ids);
    }

    @Override
    public java.util.List<cn.edu.cquet.tourism.domain.TourismImage> getImagesByVenue(Long venueId) {
        LambdaQueryWrapper<cn.edu.cquet.tourism.domain.TourismVenueImage> qw = new LambdaQueryWrapper<>();
        qw.eq(cn.edu.cquet.tourism.domain.TourismVenueImage::getVenueId, venueId.intValue());
        java.util.List<cn.edu.cquet.tourism.domain.TourismVenueImage> rels = venueImageMapper.selectList(qw);
        if (rels.isEmpty()) return java.util.Collections.emptyList();
        java.util.List<Integer> imageIds = rels.stream().map(cn.edu.cquet.tourism.domain.TourismVenueImage::getImageId).collect(java.util.stream.Collectors.toList());
        return imageMapper.selectBatchIds(imageIds);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public boolean setImagesForVenue(Long venueId, java.util.List<Integer> imageIds) {
        LambdaQueryWrapper<cn.edu.cquet.tourism.domain.TourismVenueImage> del = new LambdaQueryWrapper<>();
        del.eq(cn.edu.cquet.tourism.domain.TourismVenueImage::getVenueId, venueId.intValue());
        venueImageMapper.delete(del);
        if (imageIds != null) {
            int sort = 0;
            for (Integer imgId : imageIds) {
                cn.edu.cquet.tourism.domain.TourismVenueImage rel = new cn.edu.cquet.tourism.domain.TourismVenueImage();
                rel.setVenueId(venueId.intValue());
                rel.setImageId(imgId);
                rel.setSort(sort++);
                venueImageMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public boolean setScenicSpotsForVenue(Long venueId, java.util.List<Long> scenicSpotIds) {
        LambdaQueryWrapper<TourismVenueScenicSpot> del = new LambdaQueryWrapper<>();
        del.eq(TourismVenueScenicSpot::getVenueId, venueId);
        venueScenicSpotMapper.delete(del);
        if (scenicSpotIds != null) {
            for (Long sid : scenicSpotIds) {
                TourismVenueScenicSpot rel = new TourismVenueScenicSpot();
                rel.setVenueId(venueId);
                rel.setScenicSpotId(sid);
                rel.setSort(0);
                venueScenicSpotMapper.insert(rel);
            }
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量删除场馆
     * 步骤：删除图片与设施的关联；批量逻辑删除主表
     */
    public boolean removeVenueByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return false; // 校验：至少一个 id
        LambdaQueryWrapper<TourismVenueImage> del1 = new LambdaQueryWrapper<>(); // 删除图片关联
        del1.in(TourismVenueImage::getVenueId, ids);
        venueImageMapper.delete(del1);

        LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>(); // 删除设施关联
        del2.in(TourismVenueFacilities::getVenueId, ids);
        venueFacilitiesMapper.delete(del2);

        LambdaQueryWrapper<TourismVenueScenicSpot> del3 = new LambdaQueryWrapper<>(); // 删除景区关联
        del3.in(TourismVenueScenicSpot::getVenueId, ids.stream().map(Integer::longValue).collect(java.util.stream.Collectors.toList()));
        venueScenicSpotMapper.delete(del3);

        // 删除当前场馆下的特色活动（以确保联动清理申报与评论等）
        LambdaQueryWrapper<TourismActivity> delAct = new LambdaQueryWrapper<>();
        delAct.in(TourismActivity::getVenueId, ids);
        activityMapper.delete(delAct);

        return tourismVenueMapper.deleteBatchIds(ids) > 0; // 删除主表并返回结果
    }
}
