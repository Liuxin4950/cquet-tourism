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
/**
 * 景区服务实现
 *
 * 说明：
 * - 继承 MyBatis-Plus `ServiceImpl`，封装了基础的 CRUD 能力；同时实现 `TourismScenicSpotService` 自定义方法。
 * - 使用 `LambdaQueryWrapper` 构造类型安全的查询条件。
 * - 通过 `@Transactional` 保证新增/修改/删除的原子性（含多表关联关系维护）。
 */
public class TourismScenicSpotServiceImpl extends ServiceImpl<TourismScenicSpotMapper, TourismScenicSpot> implements TourismScenicSpotService {

    @Autowired
    private TourismScenicSpotMapper tourismScenicSpotMapper; // 景区主表 Mapper

    @Autowired
    private TourismScenicSpotImageMapper scenicSpotImageMapper; // 景区-图片关联表

    @Autowired
    private TourismImageMapper imageMapper; // 图片表


    @Override
    /**
     * 按条件分页查询景区列表
     * 条件：名称模糊、城市精确、等级精确、票价区间、状态、未删除；按创建时间倒序
     */
    public List<TourismScenicSpot> getScenicSpotList(TourismScenicSpotQueryVo queryVo) {
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>(); // 创建类型安全查询构造器
        // 名称模糊匹配（仅当 name 非空）
        queryWrapper.like(queryVo.getName() != null && !queryVo.getName().isBlank(), TourismScenicSpot::getName, queryVo.getName())
                // 城市模糊匹配（仅当 city 非空），支持输入“成都”匹配“四川省成都市”
                .like(queryVo.getCity() != null && !queryVo.getCity().isBlank(), TourismScenicSpot::getCity, queryVo.getCity())
                // 景区等级精确匹配（仅当 level 非空）
                .eq(queryVo.getLevel() != null && !queryVo.getLevel().isBlank(), TourismScenicSpot::getLevel, queryVo.getLevel())
                // 票价下限（仅当 minTicketPrice 非空）
                .ge(queryVo.getMinTicketPrice() != null, TourismScenicSpot::getTicketPrice, queryVo.getMinTicketPrice())
                // 票价上限（仅当 maxTicketPrice 非空）
                .le(queryVo.getMaxTicketPrice() != null, TourismScenicSpot::getTicketPrice, queryVo.getMaxTicketPrice())
                // 状态精确匹配（仅当 status 非空）
                .eq(queryVo.getStatus() != null && !queryVo.getStatus().isBlank(), TourismScenicSpot::getStatus, queryVo.getStatus())
                // 只查询未删除的数据（del_flag=0）
                .eq(TourismScenicSpot::getDelFlag, "0")
                // 创建时间倒序，保证最新记录优先
                .orderByDesc(TourismScenicSpot::getCreateTime);
        return tourismScenicSpotMapper.selectList(queryWrapper); // 执行查询并返回列表
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 新增景区
     * 规则：名称唯一；保存主表后根据 `imageIds` 建立关联关系
     */
    public boolean addScenicSpot(TourismScenicSpot scenicSpot) {
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>(); // 构造唯一性校验条件
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName()); // 以名称为唯一约束
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper); // 执行查询
        if (!list.isEmpty()) { // 若存在同名记录
            log.error("该景区已存在"); // 记录错误日志
            return false; // 返回失败
        }
        int inserted = tourismScenicSpotMapper.insert(scenicSpot); // 插入主表数据
        if (inserted <= 0) return false; // 插入失败直接返回
        // 处理图片关联：若前端传递 imageIds，则建立关联关系
        if (scenicSpot.getImageIds() != null && !scenicSpot.getImageIds().isEmpty()) {
            for (Integer imageId : scenicSpot.getImageIds()) { // 遍历图片ID列表
                TourismScenicSpotImage rel = new TourismScenicSpotImage(); // 创建关联实体
                rel.setScenicSpotId(scenicSpot.getId().intValue()); // 绑定景区ID
                rel.setImageId(imageId); // 绑定图片ID
                scenicSpotImageMapper.insert(rel); // 插入关联记录
            }
        }
        return true; // 成功
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 更新景区
     * 规则：排除自身后名称唯一；更新主表；若携带 `imageIds`，先清理旧关联再批量建立新关联
     */
    public boolean updateScenicSpot(TourismScenicSpot scenicSpot) {
        if (scenicSpot.getId() == null) { // 基本校验：更新必须携带主键
            log.error("修改时，id不能为空");
            return false;
        }
        // 名称唯一性校验：排除当前记录 id
        LambdaQueryWrapper<TourismScenicSpot> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TourismScenicSpot::getName, scenicSpot.getName()) // 同名
                .ne(TourismScenicSpot::getId, scenicSpot.getId()); // 排除自身
        List<TourismScenicSpot> list = tourismScenicSpotMapper.selectList(queryWrapper); // 执行查询
        if (!list.isEmpty()) { // 有冲突则失败
            log.error("该景区已存在");
            return false;
        }
        int updated = tourismScenicSpotMapper.updateById(scenicSpot); // 更新主表
        if (updated <= 0) return false; // 更新失败
        // 处理图片关联：若提供 imageIds，则重建关联（先删后插）
        if (scenicSpot.getImageIds() != null) {
            LambdaQueryWrapper<TourismScenicSpotImage> del = new LambdaQueryWrapper<>(); // 删除条件
            del.eq(TourismScenicSpotImage::getScenicSpotId, scenicSpot.getId().intValue()); // 关联景区ID
            scenicSpotImageMapper.delete(del); // 删除旧关联
            for (Integer imageId : scenicSpot.getImageIds()) { // 重建关联
                TourismScenicSpotImage rel = new TourismScenicSpotImage();
                rel.setScenicSpotId(scenicSpot.getId().intValue());
                rel.setImageId(imageId);
                scenicSpotImageMapper.insert(rel);
            }
        }
        return true; // 成功
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    /**
     * 批量删除景区
     * 步骤：删除图片关联；批量逻辑删除主表
     */
    public boolean removeScenicSpotByIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) { // 基本校验：必须传递至少一个 id
            log.error("删除时，id不能为空");
            return false;
        }
        // 删除图片关联（中间表）
        LambdaQueryWrapper<TourismScenicSpotImage> del = new LambdaQueryWrapper<>();
        del.in(TourismScenicSpotImage::getScenicSpotId, ids.stream().map(Long::intValue).collect(java.util.stream.Collectors.toList())); // scenic_spot_id IN (ids)
        scenicSpotImageMapper.delete(del); // 执行删除
        // 删除主表（批量按主键）
        boolean ok = tourismScenicSpotMapper.deleteBatchIds(ids) > 0; // 返回是否删除成功
        if (!ok) return false;
        return true;
    }

    @Override
    /**
     * 按主键查询景区
     */
    public TourismScenicSpot getScenicSpotById(Long id) {
        if (id == null) { // 基本校验
            log.error("查询时，id不能为空");
            return null;
        }
        return tourismScenicSpotMapper.selectById(id); // 主键查询
    }

    @Override
    /**
     * 景区详情
     * 内容：主表信息 + 关联图片列表
     */
    public ScenicSpotDetailVo getDetail(Long id) {
        TourismScenicSpot spot = getScenicSpotById(id); // 查询主表
        if (spot == null) return null; // 不存在直接返回
        ScenicSpotDetailVo vo = new ScenicSpotDetailVo(); // 创建详情 VO
        BeanUtils.copyProperties(spot, vo); // 复制主表字段到 VO

        // TourismScenicSpotImage：图片关联表
        LambdaQueryWrapper<TourismScenicSpotImage> q = new LambdaQueryWrapper<>(); // 查询关联关系
        // intValue() 强转成 int
        q.eq(TourismScenicSpotImage::getScenicSpotId, spot.getId().intValue()); // scenic_spot_id=当前ID
        List<TourismScenicSpotImage> rels = scenicSpotImageMapper.selectList(q); // 取出所有关联记录
        if (!rels.isEmpty()) { // 若存在关联
            // 将获取的rels数组转换为流，映射为图片ID存储到imageIds中
            List<Integer> imageIds = rels.stream().map(TourismScenicSpotImage::getImageId).collect(java.util.stream.Collectors.toList()); // 提取图片ID列表
            List<TourismImage> images = imageMapper.selectBatchIds(imageIds); // 批量查询图片
            vo.setImages(images); // 设置到 VO
        }
        return vo; // 返回详情
    }

    // 说明：
    // - 按景区ID查询关联图片，返回图片列表。
    // - 若不存在关联记录，返回空列表。
    @Override
    public List<TourismImage> getImagesByScenicSpot(Long scenicSpotId) {
        LambdaQueryWrapper<TourismScenicSpotImage> qw = new LambdaQueryWrapper<>();
        qw.eq(TourismScenicSpotImage::getScenicSpotId, scenicSpotId.intValue());
        List<TourismScenicSpotImage> rels = scenicSpotImageMapper.selectList(qw);
        if (rels.isEmpty()) return java.util.Collections.emptyList();
        java.util.List<Integer> imageIds = rels.stream().map(TourismScenicSpotImage::getImageId).collect(java.util.stream.Collectors.toList());
        return imageMapper.selectBatchIds(imageIds);
    }
    // 说明：
    // - 按景区ID查询关联图片，返回图片列表。
    // - 若不存在关联记录，返回空列表。
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean setImagesForScenicSpot(Long scenicSpotId, java.util.List<Integer> imageIds) {
        if (scenicSpotId == null || imageIds == null) { // 基本校验
            log.error("设置关联图片时，景区ID或图片ID不能为空");
            return false;
        }
        LambdaQueryWrapper<TourismScenicSpotImage> del = new LambdaQueryWrapper<>();
        del.eq(TourismScenicSpotImage::getScenicSpotId, scenicSpotId.intValue());
        scenicSpotImageMapper.delete(del);
        if (imageIds != null) {
            int sort = 0;
            for (Integer imgId : imageIds) {
                TourismScenicSpotImage rel = new TourismScenicSpotImage();
                rel.setScenicSpotId(scenicSpotId.intValue());
                rel.setImageId(imgId);
                rel.setSort(sort++);
                scenicSpotImageMapper.insert(rel);
            }
        }
        return true;
    }
}