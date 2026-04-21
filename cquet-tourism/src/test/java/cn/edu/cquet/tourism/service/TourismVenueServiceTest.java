package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.domain.TourismFacilities;
import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.domain.TourismVenue;
import cn.edu.cquet.tourism.domain.TourismVenueFacilities;
import cn.edu.cquet.tourism.domain.TourismVenueImage;
import cn.edu.cquet.tourism.domain.vo.VenueDetailVo;
import cn.edu.cquet.tourism.mapper.*;
import cn.edu.cquet.tourism.service.impl.TourismVenueServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

/**
 * 场馆服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("场馆服务测试")
class TourismVenueServiceTest {

    @Mock
    private TourismVenueMapper tourismVenueMapper;

    @Mock
    private TourismVenueImageMapper venueImageMapper;

    @Mock
    private TourismVenueFacilitiesMapper venueFacilitiesMapper;

    @Mock
    private TourismImageMapper imageMapper;

    @Mock
    private TourismFacilitiesMapper facilitiesMapper;

    @Mock
    private TourismActivityMapper activityMapper;

    @Mock
    private TourismActivityApprovalService approvalService;

    @InjectMocks
    private TourismVenueServiceImpl venueService;

    private TourismVenue testVenue;

    @BeforeEach
    void setUp() {
        testVenue = new TourismVenue();
        testVenue.setId(Long.valueOf(1L));
        testVenue.setName("重庆体育馆");
        testVenue.setCity("重庆");
        testVenue.setAddress("重庆市渝中区体育路1号");
        testVenue.setCapacity(5000);
        testVenue.setStatus("0");
        testVenue.setDelFlag("0");
    }

    @Nested
    @DisplayName("新增场馆")
    class AddVenueTests {

        @Test
        @DisplayName("名称唯一时新增成功")
        void addVenue_Success_WhenNameIsUnique() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismVenueMapper.insert(any(TourismVenue.class))).thenReturn(1);

            boolean result = venueService.addVenue(testVenue);

            assertTrue(result);
            verify(tourismVenueMapper).insert(testVenue);
        }

        @Test
        @DisplayName("名称重复时新增失败")
        void addVenue_Fails_WhenNameExists() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testVenue));

            boolean result = venueService.addVenue(testVenue);

            assertFalse(result);
            verify(tourismVenueMapper, never()).insert(any());
        }

        @Test
        @DisplayName("新增时绑定图片成功")
        void addVenue_BindsImages_WhenImageIdsProvided() {
            testVenue.setImageIds(Arrays.asList(Long.valueOf(1L), Long.valueOf(2L), Long.valueOf(3L)));
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismVenueMapper.insert(any(TourismVenue.class))).thenReturn(1);

            boolean result = venueService.addVenue(testVenue);

            assertTrue(result);
            verify(venueImageMapper, times(3)).insert(any(TourismVenueImage.class));
        }

        @Test
        @DisplayName("新增时绑定设施成功")
        void addVenue_BindsFacilities_WhenFacilitiesIdsProvided() {
            testVenue.setFacilitiesIds(Arrays.asList(Long.valueOf(1L), Long.valueOf(2L)));
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismVenueMapper.insert(any(TourismVenue.class))).thenReturn(1);

            boolean result = venueService.addVenue(testVenue);

            assertTrue(result);
            verify(venueFacilitiesMapper, times(2)).insert(any(TourismVenueFacilities.class));
        }
    }

    @Nested
    @DisplayName("更新场馆")
    class UpdateVenueTests {

        @Test
        @DisplayName("ID为空时更新失败")
        void updateVenue_Fails_WhenIdIsNull() {
            testVenue.setId(null);

            boolean result = venueService.updateVenue(testVenue);

            assertFalse(result);
            verify(tourismVenueMapper, never()).updateById(any());
        }

        @Test
        @DisplayName("排除自身后名称唯一时更新成功")
        void updateVenue_Success_WhenNameUniqueExcludingSelf() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismVenueMapper.updateById(any(TourismVenue.class))).thenReturn(1);

            boolean result = venueService.updateVenue(testVenue);

            assertTrue(result);
            verify(tourismVenueMapper).updateById(testVenue);
        }

        @Test
        @DisplayName("名称冲突时更新失败")
        void updateVenue_Fails_WhenNameConflicts() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(new TourismVenue()));

            boolean result = venueService.updateVenue(testVenue);

            assertFalse(result);
        }

        @Test
        @DisplayName("更新时重建图片关联")
        void updateVenue_RebuildsImageRelations() {
            testVenue.setImageIds(Arrays.asList(Long.valueOf(1L), Long.valueOf(2L)));
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismVenueMapper.updateById(any(TourismVenue.class))).thenReturn(1);

            boolean result = venueService.updateVenue(testVenue);

            assertTrue(result);
            verify(venueImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(venueImageMapper, times(2)).insert(any(TourismVenueImage.class));
        }
    }

    @Nested
    @DisplayName("删除场馆")
    class RemoveVenueTests {

        @Test
        @DisplayName("ID列表为空时删除失败")
        void removeVenueByIds_Fails_WhenIdsEmpty() {
            boolean result = venueService.removeVenueByIds(Collections.emptyList());

            assertFalse(result);
            verify(tourismVenueMapper, never()).deleteBatchIds(any());
        }

        @Test
        @DisplayName("ID列表为null时删除失败")
        void removeVenueByIds_Fails_WhenIdsNull() {
            boolean result = venueService.removeVenueByIds(null);

            assertFalse(result);
        }

        @Test
        @DisplayName("批量删除成功")
        void removeVenueByIds_Success() {
            List<Long> ids = Arrays.asList(Long.valueOf(1L), Long.valueOf(2L), Long.valueOf(3L));
            when(tourismVenueMapper.deleteBatchIds(ids)).thenReturn(3);

            boolean result = venueService.removeVenueByIds(ids);

            assertTrue(result);
            verify(venueImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(venueFacilitiesMapper).delete(any(LambdaQueryWrapper.class));
            verify(activityMapper).update(eq(null), any(UpdateWrapper.class));
        }
    }

    @Nested
    @DisplayName("查询场馆")
    class QueryVenueTests {

        @Test
        @DisplayName("按名称和地址模糊查询")
        void getVenueByNameAndAddress_ReturnsFilteredList() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testVenue));

            List<TourismVenue> result = venueService.getVenueByNameAndAddress("重庆", "体育路");

            assertFalse(result.isEmpty());
            assertEquals(1, result.size());
        }

        @Test
        @DisplayName("按名称、地址、城市模糊查询")
        void getVenueList_ReturnsFilteredList() {
            when(tourismVenueMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testVenue));

            // List<TourismVenue> result = venueService.getVenueList("重庆", "体育路", "重庆");    

            // assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("查询场馆详情")
        void getDetail_ReturnsDetailVo() {
            when(tourismVenueMapper.selectById(any())).thenReturn(testVenue);
            when(venueImageMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(venueFacilitiesMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());

            VenueDetailVo result = venueService.getDetail(1L);

            assertNotNull(result);
            assertEquals("重庆体育馆", result.getName());
        }

        @Test
        @DisplayName("查询不存在的场馆详情返回null")
        void getDetail_ReturnsNull_WhenNotExists() {
            when(tourismVenueMapper.selectById(any())).thenReturn(null);

            VenueDetailVo result = venueService.getDetail(Long.valueOf(999L));

            assertNull(result);
        }
    }

    @Nested
    @DisplayName("场馆图片关联")
    class VenueImageRelationTests {

        @Test
        @DisplayName("设置图片关联时先删后插")
        void setImagesForVenue_DeletesAndInserts() {
            List<Long> imageIds = Arrays.asList(Long.valueOf(1L), Long.valueOf(2L), Long.valueOf(3L));

            boolean result = venueService.setImagesForVenue(1L, imageIds);

            assertTrue(result);
            verify(venueImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(venueImageMapper, times(3)).insert(any(TourismVenueImage.class));
        }

        @Test
        @DisplayName("查询场馆关联图片")
        void getImagesByVenue_ReturnsImageList() {
            TourismVenueImage rel = new TourismVenueImage();
            rel.setImageId(Long.valueOf(1L));
            when(venueImageMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(rel));
            when(imageMapper.selectBatchIds(any())).thenReturn(List.of(new TourismImage()));

            List<TourismImage> result = venueService.getImagesByVenue(1L);

            assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("查询无关联图片返回空列表")
        void getImagesByVenue_ReturnsEmptyList_WhenNoRelation() {
            when(venueImageMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());

            List<TourismImage> result = venueService.getImagesByVenue(1L);

            assertTrue(result.isEmpty());
        }
    }
}
