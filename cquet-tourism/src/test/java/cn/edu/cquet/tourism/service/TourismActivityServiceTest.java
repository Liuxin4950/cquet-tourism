package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;
import cn.edu.cquet.tourism.service.impl.TourismActivityServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import cn.edu.cquet.common.core.domain.model.LoginUser;
import cn.edu.cquet.common.core.domain.entity.SysUser;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

import cn.edu.cquet.common.exception.ServiceException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 活动服务单元测试
 *
 * 测试策略：
 * - 使用 Mockito 模拟 Mapper 和 ApprovalService 依赖
 * - 专注测试活动创建、状态更新、时间冲突检测等核心业务
 * - create() 测试需要设置 Spring Security 上下文，使用 @BeforeEach 在每个测试前设置
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("活动服务测试")
class TourismActivityServiceTest {

    @Mock
    private TourismActivityMapper activityMapper;

    @Mock
    private TourismActivityApprovalService approvalService;

    @InjectMocks
    private TourismActivityServiceImpl activityService;

    private TourismActivity testActivity;

    @BeforeEach
    void setUp() {
        testActivity = new TourismActivity();
        testActivity.setId(1L);
        testActivity.setName("川剧变脸表演");
        testActivity.setCategory("文艺演出");
        testActivity.setVenueId(Long.valueOf(1L));
        testActivity.setStartTime(LocalDateTime.of(2026, 4, 1, 10, 0));
        testActivity.setEndTime(LocalDateTime.of(2026, 4, 1, 12, 0));
        testActivity.setStatus("0");
        testActivity.setDelFlag("0");

        // 设置 Spring Security 上下文（解决 SecurityUtils.getUserId() 的依赖）
        SysUser user = new SysUser();
        user.setUserId(1L);
        user.setUserName("admin");
        LoginUser loginUser = new LoginUser(user, null);
        UsernamePasswordAuthenticationToken authentication =
            new UsernamePasswordAuthenticationToken(loginUser, null, Collections.emptyList());
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    @Nested
    @DisplayName("活动创建")
    class CreateActivityTests {

        @Test
        @DisplayName("活动信息完整时创建成功")
        void create_Success_WhenActivityIsValid() {
            // given
            when(activityMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(0L);
            when(activityMapper.insert(any(TourismActivity.class))).thenReturn(1);

            // when
            boolean result = activityService.create(testActivity);

            // then
            assertTrue(result);
            verify(activityMapper).insert(any(TourismActivity.class));
        }

        @Test
        @DisplayName("活动为null时创建失败")
        void create_Fails_WhenActivityIsNull() {
            // when
            boolean result = activityService.create(null);

            // then
            assertFalse(result);
            verify(activityMapper, never()).insert(any());
        }

        @Test
        @DisplayName("同名活动已存在时抛出异常")
        void create_ThrowsServiceException_WhenNameExists() {
            // given: 名称检查返回 1（有重复）
            when(activityMapper.selectCount(any(LambdaQueryWrapper.class))).thenReturn(1L);

            // when & then: 应抛出 ServiceException
            ServiceException e = assertThrows(ServiceException.class,
                    () -> activityService.create(testActivity));
            assertEquals("活动名称已存在", e.getMessage());
            verify(activityMapper, never()).insert(any());
        }

        @Test
        @DisplayName("同场馆同时间段冲突时抛出异常")
        void create_ThrowsServiceException_WhenTimeSlotConflicts() {
            // given
            when(activityMapper.selectCount(any(LambdaQueryWrapper.class)))
                    .thenReturn(0L)  // 名称检查通过
                    .thenReturn(1L); // 时间冲突检查

            // when & then: 应抛出 ServiceException
            ServiceException e = assertThrows(ServiceException.class,
                    () -> activityService.create(testActivity));
            assertEquals("该场馆在所选时间段已有其他活动安排", e.getMessage());
            verify(activityMapper, never()).insert(any());
        }
    }

    @Nested
    @DisplayName("时间冲突边界测试")
    class TimeConflictBoundaryTests {

        /**
         * 冲突判定规则：
         * - 冲突：existing.startTime < new.endTime AND existing.endTime > new.startTime
         * - 不冲突：existing.endTime <= new.startTime OR existing.startTime >= new.endTime
         *
         * 边界用例：
         * 1. 相邻时间段（09:00-10:00 vs 10:00-11:00）→ 不冲突（endTime = startTime，首尾相接）
         * 2. 部分重叠（09:00-11:00 vs 10:00-12:00）→ 冲突
         * 3. 完全包含（09:00-12:00 vs 10:00-11:00）→ 冲突
         * 4. 不同场馆（10:00-12:00，venueId=2）→ 不冲突
         */

        @Test
        @DisplayName("相邻时间段不冲突：09:00-10:00 与 10:00-11:00 首尾相接")
        void create_Success_WhenTimeSlotsAreAdjacent() {
            // given: 已有 10:00-11:00 的活动(testActivity 是 10:00-12:00)
            // 条件：existing.startTime(10) < new.endTime(11) → 10 < 11 ✓
            //       existing.endTime(11) > new.startTime(10) → 11 > 10 ✓ → 冲突！
            // 但我们要测试"不冲突"场景，需要换个数据：
            // 新活动: 10:00-11:00，已有: 09:00-10:00
            // 条件：existing.startTime(9) < new.endTime(11) → 9 < 11 ✓
            //       existing.endTime(10) > new.startTime(10) → 10 > 10 ✗ → 不冲突 ✓
            testActivity.setStartTime(LocalDateTime.of(2026, 4, 1, 10, 0));
            testActivity.setEndTime(LocalDateTime.of(2026, 4, 1, 11, 0));

            // 第一次 selectCount：名称检查返回 0
            // 第二次 selectCount：时间冲突检查也返回 0（无冲突）
            when(activityMapper.selectCount(any(LambdaQueryWrapper.class)))
                    .thenReturn(0L)
                    .thenReturn(0L);
            when(activityMapper.insert(any(TourismActivity.class))).thenReturn(1);

            // when
            boolean result = activityService.create(testActivity);

            // then
            assertTrue(result);
            verify(activityMapper).insert(any(TourismActivity.class));
        }

        @Test
        @DisplayName("不同场馆时间段重叠不冲突：venueId=1 vs venueId=2")
        void create_Success_WhenDifferentVenue() {
            // given: 场馆 2，10:00-12:00（与 testActivity 相同时间段）
            testActivity.setVenueId(Long.valueOf(2L));

            when(activityMapper.selectCount(any(LambdaQueryWrapper.class)))
                    .thenReturn(0L)   // 名称检查
                    .thenReturn(0L); // venueId=2 与 venueId=1 不匹配，时间冲突检查返回 0
            when(activityMapper.insert(any(TourismActivity.class))).thenReturn(1);

            // when
            boolean result = activityService.create(testActivity);

            // then
            assertTrue(result);
            verify(activityMapper).insert(any(TourismActivity.class));
        }

        @Test
        @DisplayName("部分重叠时冲突：09:00-11:00 与 10:00-12:00 有交集")
        void create_Fails_WhenPartiallyOverlapping() {
            // given: 已有 10:00-12:00 的活动
            // 新活动: 09:00-11:00
            // existing.startTime(10) < new.endTime(11) → 10 < 11 ✓
            // existing.endTime(12) > new.startTime(9)  → 12 > 9  ✓ → 冲突
            testActivity.setStartTime(LocalDateTime.of(2026, 4, 1, 9, 0));
            testActivity.setEndTime(LocalDateTime.of(2026, 4, 1, 11, 0));

            when(activityMapper.selectCount(any(LambdaQueryWrapper.class)))
                    .thenReturn(0L)   // 名称检查
                    .thenReturn(1L); // 时间冲突

            // when & then
            ServiceException e = assertThrows(ServiceException.class,
                    () -> activityService.create(testActivity));
            assertEquals("该场馆在所选时间段已有其他活动安排", e.getMessage());
        }

        @Test
        @DisplayName("完全包含时冲突：大时间段包含小时间段")
        void create_Fails_WhenContained() {
            // given: 已有 09:00-12:00 的活动
            // 新活动: 10:00-11:00（被包含）
            // existing.startTime(9) < new.endTime(11)  → 9 < 11  ✓
            // existing.endTime(12) > new.startTime(10) → 12 > 10 ✓ → 冲突
            testActivity.setStartTime(LocalDateTime.of(2026, 4, 1, 10, 0));
            testActivity.setEndTime(LocalDateTime.of(2026, 4, 1, 11, 0));

            when(activityMapper.selectCount(any(LambdaQueryWrapper.class)))
                    .thenReturn(0L)   // 名称检查
                    .thenReturn(1L); // 时间冲突

            // when & then
            ServiceException e = assertThrows(ServiceException.class,
                    () -> activityService.create(testActivity));
            assertEquals("该场馆在所选时间段已有其他活动安排", e.getMessage());
        }
    }

    @Nested
    @DisplayName("活动状态更新")
    class UpdateStatusTests {

        @Test
        @DisplayName("ID和状态都有效时更新成功")
        void updateStatus_Success() {
            // given
            when(activityMapper.updateById(any(TourismActivity.class))).thenReturn(1);

            // when
            boolean result = activityService.updateStatus(1L, "1");

            // then
            assertTrue(result);
        }

        @Test
        @DisplayName("ID为null时更新失败")
        void updateStatus_Fails_WhenIdIsNull() {
            // when
            boolean result = activityService.updateStatus(null, "1");

            // then
            assertFalse(result);
        }

        @Test
        @DisplayName("状态为空时更新失败")
        void updateStatus_Fails_WhenStatusIsBlank() {
            // when
            boolean result = activityService.updateStatus(1L, "");

            // then
            assertFalse(result);
        }
    }

    @Nested
    @DisplayName("活动删除")
    class RemoveActivityTests {

        @Test
        @DisplayName("ID列表为空时删除失败")
        void removeByIds_Fails_WhenIdsEmpty() {
            // when
            boolean result = activityService.removeByIds(Collections.emptyList());

            // then
            assertFalse(result);
        }

        @Test
        @DisplayName("ID列表为null时删除失败")
        void removeByIds_Fails_WhenIdsNull() {
            // when
            boolean result = activityService.removeByIds(null);

            // then
            assertFalse(result);
        }

        @Test
        @DisplayName("批量删除成功")
        void removeByIds_Success() {
            // given
            List<Long> ids = List.of(1L, 2L, 3L);
            when(activityMapper.deleteBatchIds(ids)).thenReturn(3);

            // when
            boolean result = activityService.removeByIds(ids);

            // then
            assertTrue(result);
        }
    }

    @Nested
    @DisplayName("活动查询")
    class QueryActivityTests {

        @Test
        @DisplayName("按ID查询返回活动对象")
        void detail_ReturnsActivity() {
            // given
            when(activityMapper.selectById(1L)).thenReturn(testActivity);

            // when
            TourismActivity result = activityService.detail(1L);

            // then
            assertNotNull(result);
            assertEquals("川剧变脸表演", result.getName());
        }

        @Test
        @DisplayName("ID为null时返回null")
        void detail_ReturnsNull_WhenIdIsNull() {
            // when
            TourismActivity result = activityService.detail(null);

            // then
            assertNull(result);
        }

        @Test
        @DisplayName("按名称模糊查询返回列表")
        void list_ReturnsFilteredList() {
            // given
            when(activityMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testActivity));

            // when
            List<TourismActivity> result = activityService.list("川剧", null, null);

            // then
            assertFalse(result.isEmpty());
        }
    }

    @Nested
    @DisplayName("审核状态归一化")
    class AuditStatusNormalizationTests {

        @Test
        @DisplayName("支持数字审核状态")
        void list_SupportsNumericAuditStatus() {
            // given
            when(activityMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testActivity));

            // when - 使用数字状态
            List<TourismActivity> result = activityService.list(null, null, "0");

            // then
            assertNotNull(result);
        }

        @Test
        @DisplayName("支持英文审核状态")
        void list_SupportsEnglishAuditStatus() {
            // given
            when(activityMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(testActivity));
            when(approvalService.history(any())).thenReturn(Collections.emptyList());

            // when - 使用英文状态
            List<TourismActivity> result = activityService.list(null, null, "pending");

            // then
            assertNotNull(result);
        }
    }
}
