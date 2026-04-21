package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismNews;
import cn.edu.cquet.tourism.mapper.TourismNewsMapper;
import cn.edu.cquet.tourism.service.impl.TourismNewsServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 新闻服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("新闻服务测试")
class TourismNewsServiceTest {

    @Mock
    private TourismNewsMapper tourismNewsMapper;

    @InjectMocks
    private TourismNewsServiceImpl newsService;

    private TourismNews testNews;

    @BeforeEach
    void setUp() {
        testNews = new TourismNews();
        testNews.setId(Long.valueOf(1L));
        testNews.setTitle("重庆旅游新政策发布");
        testNews.setContent("近日，重庆发布了新的旅游政策...");
        testNews.setAuthor("旅游局");
    }

    @Nested
    @DisplayName("新增新闻")
    class AddNewsTests {

        @Test
        @DisplayName("标题唯一时新增成功")
        void addNews_Success_WhenTitleIsUnique() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(tourismNewsMapper.insert(any(TourismNews.class))).thenReturn(1);

            boolean result = newsService.addNews(testNews);

            assertTrue(result);
            verify(tourismNewsMapper).insert(testNews);
        }

        @Test
        @DisplayName("标题重复时新增失败")
        void addNews_Fails_WhenTitleExists() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNews));

            boolean result = newsService.addNews(testNews);

            assertFalse(result);
            verify(tourismNewsMapper, never()).insert(any());
        }
    }

    @Nested
    @DisplayName("查询新闻")
    class QueryNewsTests {

        @Test
        @DisplayName("按标题模糊查询")
        void getNewsByTitleAndTime_ByTitle() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNews));

            List<TourismNews> result = newsService.getNewsByTitleAndTime("旅游", null, null);

            assertFalse(result.isEmpty());
            assertEquals(1, result.size());
        }

        @Test
        @DisplayName("按时间范围查询")
        void getNewsByTitleAndTime_ByTimeRange() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNews));

            List<TourismNews> result = newsService.getNewsByTitleAndTime(null, "2024-01-01", "2024-12-31");

            assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("按标题和时间范围查询")
        void getNewsByTitleAndTime_ByTitleAndTimeRange() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNews));

            List<TourismNews> result = newsService.getNewsByTitleAndTime("旅游", "2024-01-01", "2024-12-31");

            assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("无条件时返回所有未删除新闻")
        void getNewsByTitleAndTime_NoCondition() {
            when(tourismNewsMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNews));

            List<TourismNews> result = newsService.getNewsByTitleAndTime(null, null, null);

            assertFalse(result.isEmpty());
        }
    }
}
