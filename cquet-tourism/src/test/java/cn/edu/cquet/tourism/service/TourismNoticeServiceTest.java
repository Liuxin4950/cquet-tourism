package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismNotice;
import cn.edu.cquet.tourism.mapper.TourismNoticeMapper;
import cn.edu.cquet.tourism.service.impl.TourismNoticeServiceImpl;
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
 * 公告服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("公告服务测试")
class TourismNoticeServiceTest {

    @Mock
    private TourismNoticeMapper noticeMapper;

    @InjectMocks
    private TourismNoticeServiceImpl noticeService;

    private TourismNotice testNotice;

    @BeforeEach
    void setUp() {
        testNotice = new TourismNotice();
        testNotice.setId(1L);
        testNotice.setTitle("春节期间景区开放通知");
        testNotice.setContent("春节期间，我市各大景区正常开放...");
    }

    @Nested
    @DisplayName("新增公告")
    class AddNoticeTests {

        @Test
        @DisplayName("标题唯一时新增成功")
        void addNotice_Success_WhenTitleIsUnique() {
            when(noticeMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());
            when(noticeMapper.insert(any(TourismNotice.class))).thenReturn(1);

            boolean result = noticeService.addNotice(testNotice);

            assertTrue(result);
            verify(noticeMapper).insert(testNotice);
        }

        @Test
        @DisplayName("标题重复时新增失败")
        void addNotice_Fails_WhenTitleExists() {
            when(noticeMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNotice));

            boolean result = noticeService.addNotice(testNotice);

            assertFalse(result);
            verify(noticeMapper, never()).insert(any());
        }
    }

    @Nested
    @DisplayName("查询公告")
    class QueryNoticeTests {

        @Test
        @DisplayName("按标题模糊查询")
        void getByTitleAndTime_ByTitle() {
            when(noticeMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNotice));

            List<TourismNotice> result = noticeService.getByTitleAndTime("春节", null, null);

            assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("按时间范围查询")
        void getByTitleAndTime_ByTimeRange() {
            when(noticeMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNotice));

            List<TourismNotice> result = noticeService.getByTitleAndTime(null, "2024-01-01", "2024-12-31");

            assertFalse(result.isEmpty());
        }

        @Test
        @DisplayName("无条件时返回所有公告")
        void getByTitleAndTime_NoCondition() {
            when(noticeMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testNotice));

            List<TourismNotice> result = noticeService.getByTitleAndTime(null, null, null);

            assertFalse(result.isEmpty());
        }
    }
}
