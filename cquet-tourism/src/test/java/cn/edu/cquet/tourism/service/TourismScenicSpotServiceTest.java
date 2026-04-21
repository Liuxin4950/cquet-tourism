package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismScenicSpot;
import cn.edu.cquet.tourism.domain.TourismScenicSpotImage;
import cn.edu.cquet.tourism.domain.vo.TourismScenicSpotQueryVo;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotImageMapper;
import cn.edu.cquet.tourism.mapper.TourismScenicSpotMapper;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import cn.edu.cquet.tourism.service.impl.TourismScenicSpotServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import cn.edu.cquet.common.exception.ServiceException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 景区服务单元测试
 *
 * 测试策略：
 * - 使用 Mockito 模拟 Mapper 层
 * - 专注测试 Service 层业务逻辑
 * - 覆盖：CRUD、名称唯一性校验、图片关联管理
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("景区服务测试")
class TourismScenicSpotServiceTest {

    @Mock
    private TourismScenicSpotMapper tourismScenicSpotMapper;

    @Mock
    private TourismScenicSpotImageMapper scenicSpotImageMapper;

    @Mock
    private TourismImageMapper imageMapper;

    @InjectMocks
    private TourismScenicSpotServiceImpl scenicSpotService;

    private TourismScenicSpot testSpot;

    @BeforeEach
    void setUp() {
        testSpot = new TourismScenicSpot();
        testSpot.setId(1L);
        testSpot.setName("洪崖洞");
        testSpot.setLevel("4A");
        testSpot.setCity("重庆");
        testSpot.setTicketPrice(new BigDecimal("80.00"));
        testSpot.setDelFlag("0");
    }

    @Nested
    @DisplayName("新增景区")
    class AddScenicSpotTests {

        @Test
        @DisplayName("名称唯一时新增成功")
        void addScenicSpot_Success_WhenNameIsUnique() {
            // given
            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismScenicSpotMapper.insert(any(TourismScenicSpot.class))).thenReturn(1);

            // when
            boolean result = scenicSpotService.addScenicSpot(testSpot);

            // then
            assertTrue(result);
            verify(tourismScenicSpotMapper).insert(testSpot);
        }

        @Test
        @DisplayName("名称重复时抛出异常")
        void addScenicSpot_ThrowsServiceException_WhenNameExists() {
            // given
            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testSpot));

            // when & then
            ServiceException e = assertThrows(ServiceException.class,
                    () -> scenicSpotService.addScenicSpot(testSpot));
            assertEquals("景区名称已存在", e.getMessage());
            verify(tourismScenicSpotMapper, never()).insert(any());
        }

        @Test
        @DisplayName("新增时绑定图片成功")
        void addScenicSpot_BindsImages_WhenImageIdsProvided() {
            // given
            testSpot.setImageIds(Arrays.asList(Long.valueOf(1L), Long.valueOf(2L), Long.valueOf(3L)));
            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismScenicSpotMapper.insert(any(TourismScenicSpot.class))).thenReturn(1);

            // when
            boolean result = scenicSpotService.addScenicSpot(testSpot);

            // then
            assertTrue(result);
            verify(scenicSpotImageMapper, times(3)).insert(any(TourismScenicSpotImage.class));
        }
    }

    @Nested
    @DisplayName("更新景区")
    class UpdateScenicSpotTests {

        @Test
        @DisplayName("ID为空时更新失败")
        void updateScenicSpot_Fails_WhenIdIsNull() {
            // given
            testSpot.setId(null);

            // when
            boolean result = scenicSpotService.updateScenicSpot(testSpot);

            // then
            assertFalse(result);
            verify(tourismScenicSpotMapper, never()).updateById(any());
        }

        @Test
        @DisplayName("排除自身后名称唯一时更新成功")
        void updateScenicSpot_Success_WhenNameUniqueExcludingSelf() {
            // given
            TourismScenicSpot existingSpot = new TourismScenicSpot();
            existingSpot.setId(2L);
            existingSpot.setName("洪崖洞");

            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismScenicSpotMapper.updateById(any(TourismScenicSpot.class))).thenReturn(1);

            // when
            boolean result = scenicSpotService.updateScenicSpot(testSpot);

            // then
            assertTrue(result);
            verify(tourismScenicSpotMapper).updateById(testSpot);
        }

        @Test
        @DisplayName("更新时重建图片关联")
        void updateScenicSpot_RebuildsImageRelations() {
            // given
            testSpot.setImageIds(Arrays.asList(Long.valueOf(1L), Long.valueOf(2L)));
            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismScenicSpotMapper.updateById(any(TourismScenicSpot.class))).thenReturn(1);

            // when
            boolean result = scenicSpotService.updateScenicSpot(testSpot);

            // then
            assertTrue(result);
            verify(scenicSpotImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(scenicSpotImageMapper, times(2)).insert(any(TourismScenicSpotImage.class));
        }
    }

    @Nested
    @DisplayName("删除景区")
    class RemoveScenicSpotTests {

        @Test
        @DisplayName("ID列表为空时删除失败")
        void removeScenicSpotByIds_Fails_WhenIdsEmpty() {
            // when
            boolean result = scenicSpotService.removeScenicSpotByIds(Collections.emptyList());

            // then
            assertFalse(result);
            verify(tourismScenicSpotMapper, never()).deleteBatchIds(any());
        }

        @Test
        @DisplayName("批量删除成功")
        void removeScenicSpotByIds_Success() {
            // given
            List<Long> ids = Arrays.asList(1L, 2L, 3L);
            when(tourismScenicSpotMapper.deleteBatchIds(ids)).thenReturn(3);

            // when
            boolean result = scenicSpotService.removeScenicSpotByIds(ids);

            // then
            assertTrue(result);
            verify(scenicSpotImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(tourismScenicSpotMapper).deleteBatchIds(ids);
        }
    }

    @Nested
    @DisplayName("查询景区")
    class QueryScenicSpotTests {

        @Test
        @DisplayName("按ID查询返回景区对象")
        void getScenicSpotById_ReturnsSpot() {
            // given
            when(tourismScenicSpotMapper.selectById(1L)).thenReturn(testSpot);

            // when
            TourismScenicSpot result = scenicSpotService.getScenicSpotById(1L);

            // then
            assertNotNull(result);
            assertEquals("洪崖洞", result.getName());
        }

        @Test
        @DisplayName("ID为null时返回null")
        void getScenicSpotById_ReturnsNull_WhenIdIsNull() {
            // when
            TourismScenicSpot result = scenicSpotService.getScenicSpotById(null);

            // then
            assertNull(result);
        }

        @Test
        @DisplayName("按条件查询返回列表")
        void getScenicSpotList_ReturnsFilteredList() {
            // given
            TourismScenicSpotQueryVo queryVo = new TourismScenicSpotQueryVo();
            queryVo.setName("洪崖");
            queryVo.setCity("重庆");
            queryVo.setLevel("4A");

            when(tourismScenicSpotMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testSpot));

            // when
            List<TourismScenicSpot> result = scenicSpotService.getScenicSpotList(queryVo);

            // then
            assertFalse(result.isEmpty());
            assertEquals(1, result.size());
        }
    }

    @Nested
    @DisplayName("图片关联管理")
    class ImageRelationTests {

        @Test
        @DisplayName("设置图片关联时先删后插")
        void setImagesForScenicSpot_DeletesAndInserts() {
            // given
            List<Long> imageIds = Arrays.asList(Long.valueOf(1L), Long.valueOf(2L), Long.valueOf(3L));

            // when
            boolean result = scenicSpotService.setImagesForScenicSpot(1L, imageIds);

            // then
            assertTrue(result);
            verify(scenicSpotImageMapper).delete(any(LambdaQueryWrapper.class));
            verify(scenicSpotImageMapper, times(3)).insert(any(TourismScenicSpotImage.class));
        }

        @Test
        @DisplayName("景区ID或图片ID为null时失败")
        void setImagesForScenicSpot_Fails_WhenParamsNull() {
            // when & then
            assertFalse(scenicSpotService.setImagesForScenicSpot(null, Arrays.asList(Long.valueOf(1L), Long.valueOf(2L))));
            assertFalse(scenicSpotService.setImagesForScenicSpot(1L, null));
        }
    }
}
