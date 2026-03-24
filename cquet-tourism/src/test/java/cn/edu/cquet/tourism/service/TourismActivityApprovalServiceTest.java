package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismActivity;
import cn.edu.cquet.tourism.domain.TourismActivityApproval;
import cn.edu.cquet.tourism.mapper.TourismActivityApprovalMapper;
import cn.edu.cquet.tourism.mapper.TourismActivityMapper;
import cn.edu.cquet.tourism.service.impl.TourismActivityApprovalServiceImpl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
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
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import cn.edu.cquet.common.core.domain.model.LoginUser;
import cn.edu.cquet.common.core.domain.entity.SysUser;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 活动审批服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("活动审批服务测试")
class TourismActivityApprovalServiceTest {

    @Mock
    private TourismActivityApprovalMapper approvalMapper;

    @Mock
    private TourismActivityMapper activityMapper;

    @InjectMocks
    private TourismActivityApprovalServiceImpl approvalService;

    private TourismActivity testActivity;

    @BeforeEach
    void setUp() {
        testActivity = new TourismActivity();
        testActivity.setId(1L);
        testActivity.setName("川剧变脸表演");
        testActivity.setStatus("0");

        // 设置 Security Context
        SysUser user = new SysUser();
        user.setUserId(1L);
        user.setUserName("admin");
        LoginUser loginUser = new LoginUser(user, null);
        UsernamePasswordAuthenticationToken auth =
            new UsernamePasswordAuthenticationToken(loginUser, null, Collections.emptyList());
        SecurityContextHolder.getContext().setAuthentication(auth);
    }

    @Nested
    @DisplayName("记录审批")
    class RecordApprovalTests {

        @Test
        @DisplayName("参数有效时记录成功")
        void recordApproval_Success() {
            when(approvalMapper.insert(any(TourismActivityApproval.class))).thenReturn(1);

            boolean result = approvalService.recordApproval(1L, "1", "同意", "admin");

            assertTrue(result);
            verify(approvalMapper).insert(any(TourismActivityApproval.class));
        }

        @Test
        @DisplayName("activityId为null时记录失败")
        void recordApproval_Fails_WhenActivityIdNull() {
            boolean result = approvalService.recordApproval(null, "1", "同意", "admin");

            assertFalse(result);
            verify(approvalMapper, never()).insert(any());
        }

        @Test
        @DisplayName("auditStatus为null时记录失败")
        void recordApproval_Fails_WhenAuditStatusNull() {
            boolean result = approvalService.recordApproval(1L, null, "同意", "admin");

            assertFalse(result);
            verify(approvalMapper, never()).insert(any());
        }

        @Test
        @DisplayName("auditor为null时使用当前用户名")
        void recordApproval_UsesCurrentUsername_WhenAuditorNull() {
            when(approvalMapper.insert(any(TourismActivityApproval.class))).thenReturn(1);

            boolean result = approvalService.recordApproval(1L, "1", "同意", null);

            assertTrue(result);
            verify(approvalMapper).insert(any(TourismActivityApproval.class));
        }
    }

    @Nested
    @DisplayName("查询审批历史")
    class HistoryTests {

        @Test
        @DisplayName("查询返回审批记录列表")
        void history_ReturnsApprovalList() {
            TourismActivityApproval approval = new TourismActivityApproval();
            approval.setId(1L);
            approval.setActivityId(1L);
            approval.setAuditStatus("1");
            when(approvalMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(List.of(approval));

            List<TourismActivityApproval> result = approvalService.history(1L);

            assertFalse(result.isEmpty());
            assertEquals(1, result.size());
        }

        @Test
        @DisplayName("activityId为null时返回空列表")
        void history_ReturnsEmptyList_WhenActivityIdNull() {
            List<TourismActivityApproval> result = approvalService.history(null);

            assertTrue(result.isEmpty());
            verify(approvalMapper, never()).selectList(any());
        }

        @Test
        @DisplayName("无审批记录时返回空列表")
        void history_ReturnsEmptyList_WhenNoApprovals() {
            when(approvalMapper.selectList(any(LambdaQueryWrapper.class)))
                    .thenReturn(Collections.emptyList());

            List<TourismActivityApproval> result = approvalService.history(1L);

            assertTrue(result.isEmpty());
        }
    }

    @Nested
    @DisplayName("审批通过")
    class ApproveTests {

        @Test
        @DisplayName("活动存在时审批通过")
        void approve_Success_WhenActivityExists() {
            when(activityMapper.selectById(1L)).thenReturn(testActivity);
            when(approvalMapper.insert(any(TourismActivityApproval.class))).thenReturn(1);

            boolean result = approvalService.approve(1L, "材料完整，同意");

            assertTrue(result);
            verify(approvalMapper).insert(any(TourismActivityApproval.class));
        }

        @Test
        @DisplayName("活动不存在时审批失败")
        void approve_Fails_WhenActivityNotExists() {
            when(activityMapper.selectById(999L)).thenReturn(null);

            boolean result = approvalService.approve(999L, "同意");

            assertFalse(result);
            verify(approvalMapper, never()).insert(any());
        }

        @Test
        @DisplayName("id为null时审批失败")
        void approve_Fails_WhenIdIsNull() {
            boolean result = approvalService.approve(null, "同意");

            assertFalse(result);
        }
    }

    @Nested
    @DisplayName("审批拒绝")
    class RejectTests {

        @Test
        @DisplayName("活动存在且原因有效时拒绝成功")
        void reject_Success_WhenActivityExistsAndReasonValid() {
            when(activityMapper.selectById(1L)).thenReturn(testActivity);
            when(approvalMapper.insert(any(TourismActivityApproval.class))).thenReturn(1);

            boolean result = approvalService.reject(1L, "材料不完整");

            assertTrue(result);
            verify(approvalMapper).insert(any(TourismActivityApproval.class));
        }

        @Test
        @DisplayName("活动不存在时拒绝失败")
        void reject_Fails_WhenActivityNotExists() {
            when(activityMapper.selectById(999L)).thenReturn(null);

            boolean result = approvalService.reject(999L, "材料不完整");

            assertFalse(result);
            verify(approvalMapper, never()).insert(any());
        }

        @Test
        @DisplayName("id为null时拒绝失败")
        void reject_Fails_WhenIdIsNull() {
            boolean result = approvalService.reject(null, "材料不完整");

            assertFalse(result);
        }

        @Test
        @DisplayName("原因为空时拒绝失败")
        void reject_Fails_WhenReasonIsBlank() {
            boolean result = approvalService.reject(1L, "");

            assertFalse(result);
        }
    }
}
