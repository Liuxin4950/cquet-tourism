package cn.edu.cquet.tourism.service.impl;

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
import java.util.Objects;
import cn.edu.cquet.common.utils.bean.BeanUtils;
import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;
import org.springframework.util.StringUtils;

import java.util.stream.Collectors;

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
    private cn.edu.cquet.tourism.service.TourismImageService imageService; // 图片服务

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
        List<TourismVenue> venues = tourismVenueMapper.selectList(queryWrapper); // 执行查询
        hydrateCoverImages(venues);
        return venues;
    }

    @Override
    public List<TourismVenue> getVenueList(String name, String address, String city, String district, String category, String status) {
        LambdaQueryWrapper<TourismVenue> qw = new LambdaQueryWrapper<>();
        qw.like(name != null && !name.isBlank(), TourismVenue::getName, name)
          .like(address != null && !address.isBlank(), TourismVenue::getAddress, address)
          .like(city != null && !city.isBlank(), TourismVenue::getCity, city)
          .like(district != null && !district.isBlank(), TourismVenue::getDistrict, district)
          .eq(category != null && !category.isBlank(), TourismVenue::getCategory, category)
          .eq(status != null && !status.isBlank(), TourismVenue::getStatus, status)
          .eq(TourismVenue::getDelFlag, "0");
        List<TourismVenue> venues = tourismVenueMapper.selectList(qw);
        hydrateCoverImages(venues);
        return venues;
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
        resolveCoverImageReference(venue);
        int inserted = tourismVenueMapper.insert(venue); // 插入主表
        if (inserted <= 0) return false; // 插入失败
        // 处理图片关联：若传入 imageIds，则批量插入关联表
        if (venue.getImageIds() != null && !venue.getImageIds().isEmpty()) {
            int sortOrder = 0;
            for (Long imageId : venue.getImageIds()) {
                TourismVenueImage rel = new TourismVenueImage(); // 关联对象
                rel.setVenueId(venue.getId()); // 绑定场馆ID
                rel.setImageId(imageId); // 绑定图片ID
                rel.setSortOrder(sortOrder);
                rel.setIsCover(sortOrder == 0 ? "1" : "0");
                venueImageMapper.insert(rel); // 插入关联
                sortOrder++;
            }
        }
        // 处理设施关联：若传入 facilitiesIds，则批量插入关联表
        if (venue.getFacilitiesIds() != null && !venue.getFacilitiesIds().isEmpty()) {
            for (Long fid : venue.getFacilitiesIds()) {
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
        resolveCoverImageReference(venue);
        int updated = tourismVenueMapper.updateById(venue); // 更新主表
        if (updated <= 0) return false; // 更新失败
        // 更新图片关联：若提供 imageIds，则先删后插重建关联
        if (venue.getImageIds() != null) {
            LambdaQueryWrapper<TourismVenueImage> del = new LambdaQueryWrapper<>(); // 删除条件
            del.eq(TourismVenueImage::getVenueId, venue.getId()); // 绑定场馆ID
            venueImageMapper.delete(del); // 删除旧关联
            int sortOrder = 0;
            for (Long imageId : venue.getImageIds()) { // 重建关联
                TourismVenueImage rel = new TourismVenueImage();
                rel.setVenueId(venue.getId());
                rel.setImageId(imageId);
                rel.setSortOrder(sortOrder);
                rel.setIsCover(sortOrder == 0 ? "1" : "0");
                venueImageMapper.insert(rel);
                sortOrder++;
            }
        }
        // 更新设施关联：若提供 facilitiesIds，则先删后插重建关联
        if (venue.getFacilitiesIds() != null) {
            LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>(); // 删除条件
            del2.eq(TourismVenueFacilities::getVenueId, venue.getId()); // 绑定场馆ID
            venueFacilitiesMapper.delete(del2); // 删除旧关联
            for (Long fid : venue.getFacilitiesIds()) { // 重建关联
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
        hydrateCoverImages(java.util.Collections.singletonList(v));
        VenueDetailVo vo = new VenueDetailVo(); // 创建详情 VO
        BeanUtils.copyProperties(v, vo); // 拷贝主表字段

        LambdaQueryWrapper<TourismVenueImage> q1 = new LambdaQueryWrapper<>(); // 查询图片关联
        q1.eq(TourismVenueImage::getVenueId, v.getId())
          .orderByDesc(TourismVenueImage::getIsCover)
          .orderByAsc(TourismVenueImage::getSortOrder)
          .orderByAsc(TourismVenueImage::getId); // venue_id=当前场馆ID
        List<TourismVenueImage> vimgs = venueImageMapper.selectList(q1); // 关联记录列表
        if (!vimgs.isEmpty()) {
            List<Long> imageIds = vimgs.stream().map(TourismVenueImage::getImageId).collect(Collectors.toList()); // 提取图片ID
            Map<Long, TourismImage> imageMap = imageService.getImageMap(imageIds);
            List<TourismImage> images = imageIds.stream().map(imageMap::get).filter(Objects::nonNull).collect(Collectors.toList());
            vo.setImages(images); // 设置图片列表
        }
        LambdaQueryWrapper<TourismVenueFacilities> q2 = new LambdaQueryWrapper<>(); // 查询设施关联
        q2.eq(TourismVenueFacilities::getVenueId, v.getId()); // venue_id=当前场馆ID
        List<TourismVenueFacilities> vfs = venueFacilitiesMapper.selectList(q2); // 关联记录列表
        if (!vfs.isEmpty()) {
            List<Long> fids = vfs.stream().map(TourismVenueFacilities::getFacilitiesId).collect(Collectors.toList()); // 提取设施ID
            List<TourismFacilities> facilities = facilitiesMapper.selectBatchIds(fids); // 批量查询设施
            vo.setFacilities(facilities); // 设置设施列表
        }
        return vo; // 返回详情
    }

    /**
     * 查询场馆下的活动列表
     * 条件：未删除、审核通过、状态正常；按创建时间倒序
     */
    public List<TourismActivity> getActivitiesByVenueId(Long venueId) {
        LambdaQueryWrapper<TourismActivity> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismActivity::getVenueId, venueId)
          .eq(TourismActivity::getDelFlag, "0")
          .eq(TourismActivity::getAuditStatus, "1")
          .eq(TourismActivity::getStatus, "0")
          .orderByDesc(TourismActivity::getCreateTime);
        java.util.List<TourismActivity> activities = activityMapper.selectList(qw);
        hydrateActivityCoverImages(activities);
        return activities;
    }


    @Override
    public java.util.List<TourismImage> getImagesByVenue(Long venueId) {
        LambdaQueryWrapper<TourismVenueImage> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismVenueImage::getVenueId, venueId)
          .orderByDesc(TourismVenueImage::getIsCover)
          .orderByAsc(TourismVenueImage::getSortOrder)
          .orderByAsc(TourismVenueImage::getId);
        java.util.List<TourismVenueImage> rels = venueImageMapper.selectList(qw);
        if (rels.isEmpty()) return java.util.Collections.emptyList();
        java.util.List<Long> imageIds = rels.stream().map(TourismVenueImage::getImageId).collect(Collectors.toList());
        Map<Long, TourismImage> imageMap = imageService.getImageMap(imageIds);
        return imageIds.stream().map(imageMap::get).filter(Objects::nonNull).collect(Collectors.toList());
    }

    @Override
    @org.springframework.transaction.annotation.Transactional(rollbackFor = Exception.class)
    public boolean setImagesForVenue(Long venueId, java.util.List<Long> imageIds) {
        LambdaQueryWrapper<TourismVenueImage> del = new LambdaQueryWrapper<>();
        del.eq(TourismVenueImage::getVenueId, venueId);
        venueImageMapper.delete(del);
        if (imageIds != null) {
            int sort = 0;
            for (Long imgId : imageIds) {
                TourismVenueImage rel = new TourismVenueImage();
                rel.setVenueId(venueId);
                rel.setImageId(imgId);
                rel.setSortOrder(sort);
                rel.setIsCover(sort == 0 ? "1" : "0");
                venueImageMapper.insert(rel);
                sort++;
            }
        }
        return true;
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量删除场馆
     * 步骤：删除图片与设施的关联；将关联活动的 venue_id 置为 NULL；批量逻辑删除主表
     * 注意：不删除关联的活动记录，仅解除关联（与数据库 ON DELETE SET NULL 约束一致）
     */
    public boolean removeVenueByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) return false; // 校验：至少一个 id
        LambdaQueryWrapper<TourismVenueImage> del1 = new LambdaQueryWrapper<>(); // 删除图片关联
        del1.in(TourismVenueImage::getVenueId, ids);
        venueImageMapper.delete(del1);

        LambdaQueryWrapper<TourismVenueFacilities> del2 = new LambdaQueryWrapper<>(); // 删除设施关联
        del2.in(TourismVenueFacilities::getVenueId, ids);
        venueFacilitiesMapper.delete(del2);
        
        // 将该场馆关联的所有活动的 venue_id 置为 NULL（不删除活动，保持与数据库 ON DELETE SET NULL 约束一致）
        com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper<TourismActivity> clearVenue = new com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper<>();
        clearVenue.in("venue_id", ids).set("venue_id", null);
        activityMapper.update(null, clearVenue);

        return tourismVenueMapper.deleteBatchIds(ids) > 0; // 删除主表并返回结果
    }

    private void resolveCoverImageReference(TourismVenue venue) {
        if (venue == null) {
            return;
        }
        if (StringUtils.hasText(venue.getCoverImage())) {
            TourismImage image = imageService.ensureByUrl(venue.getCoverImage());
            venue.setCoverImageId(image != null ? image.getId() : null);
        } else if (venue.getCoverImageId() == null) {
            venue.setCoverImageId(null);
        }
    }

    private void hydrateCoverImages(Collection<TourismVenue> venues) {
        if (venues == null || venues.isEmpty()) {
            return;
        }
        List<Long> coverImageIds = venues.stream()
                .map(TourismVenue::getCoverImageId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        if (coverImageIds.isEmpty()) {
            return;
        }
        Map<Long, TourismImage> imageMap = imageService.getImageMap(coverImageIds);
        for (TourismVenue venue : venues) {
            if (venue.getCoverImageId() == null) {
                continue;
            }
            TourismImage image = imageMap.get(venue.getCoverImageId());
            if (image != null && StringUtils.hasText(image.getUrl())) {
                venue.setCoverImage(image.getUrl());
            }
        }
    }

    private void hydrateActivityCoverImages(Collection<TourismActivity> activities) {
        if (activities == null || activities.isEmpty()) {
            return;
        }
        List<Long> coverImageIds = activities.stream()
                .map(TourismActivity::getCoverImageId)
                .filter(Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        if (coverImageIds.isEmpty()) {
            return;
        }
        Map<Long, TourismImage> imageMap = imageService.getImageMap(coverImageIds);
        for (TourismActivity activity : activities) {
            if (activity.getCoverImageId() == null) {
                continue;
            }
            TourismImage image = imageMap.get(activity.getCoverImageId());
            if (image != null && StringUtils.hasText(image.getUrl())) {
                activity.setCoverImage(image.getUrl());
            }
        }
    }
}
