package cn.edu.cquet.tourism.service;

import cn.edu.cquet.tourism.domain.TourismImage;
import cn.edu.cquet.tourism.mapper.TourismImageMapper;
import cn.edu.cquet.tourism.service.impl.TourismImageServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 图片服务单元测试
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("图片服务测试")
class TourismImageServiceTest {

    @Mock
    private TourismImageMapper imageMapper;

    @InjectMocks
    private TourismImageServiceImpl imageService;

    private TourismImage testImage;

    @BeforeEach
    void setUp() {
        testImage = new TourismImage();
        testImage.setId(1);
        testImage.setUrl("https://example.com/image.jpg");
    }

    @Nested
    @DisplayName("创建图片")
    class CreateImageTests {

        @Test
        @DisplayName("URL有效时创建成功")
        void create_Success_WhenUrlIsValid() {
            when(imageMapper.insert(any(TourismImage.class))).thenReturn(1);

            TourismImage result = imageService.create(testImage);

            assertNotNull(result);
            assertEquals("https://example.com/image.jpg", result.getUrl());
            verify(imageMapper).insert(testImage);
        }

        @Test
        @DisplayName("URL为空时创建失败返回null")
        void create_Fails_WhenUrlIsBlank() {
            testImage.setUrl("");

            TourismImage result = imageService.create(testImage);

            assertNull(result);
            verify(imageMapper, never()).insert(any());
        }

        @Test
        @DisplayName("URL为null时创建失败返回null")
        void create_Fails_WhenUrlIsNull() {
            testImage.setUrl(null);

            TourismImage result = imageService.create(testImage);

            assertNull(result);
            verify(imageMapper, never()).insert(any());
        }

        @Test
        @DisplayName("image为null时创建失败返回null")
        void create_Fails_WhenImageIsNull() {
            TourismImage result = imageService.create(null);

            assertNull(result);
            verify(imageMapper, never()).insert(any());
        }

        @Test
        @DisplayName("批量创建成功")
        void createBatch_Success() {
            List<String> urls = Arrays.asList(
                    "https://example.com/image1.jpg",
                    "https://example.com/image2.jpg",
                    "https://example.com/image3.jpg"
            );
            when(imageMapper.insert(any(TourismImage.class))).thenReturn(1);

            List<TourismImage> result = imageService.createBatch(urls);

            assertEquals(3, result.size());
            verify(imageMapper, times(3)).insert(any(TourismImage.class));
        }

        @Test
        @DisplayName("批量创建时忽略空URL")
        void createBatch_SkipsBlankUrls() {
            List<String> urls = Arrays.asList(
                    "https://example.com/image1.jpg",
                    "",
                    null,
                    "https://example.com/image2.jpg"
            );
            when(imageMapper.insert(any(TourismImage.class))).thenReturn(1);

            List<TourismImage> result = imageService.createBatch(urls);

            assertEquals(2, result.size());
            verify(imageMapper, times(2)).insert(any(TourismImage.class));
        }

        @Test
        @DisplayName("批量创建空列表返回空列表")
        void createBatch_ReturnsEmptyList_WhenUrlsEmpty() {
            List<TourismImage> result = imageService.createBatch(Collections.emptyList());

            assertTrue(result.isEmpty());
            verify(imageMapper, never()).insert(any());
        }

        @Test
        @DisplayName("批量创建null返回空列表")
        void createBatch_ReturnsEmptyList_WhenUrlsNull() {
            List<TourismImage> result = imageService.createBatch(null);

            assertTrue(result.isEmpty());
            verify(imageMapper, never()).insert(any());
        }
    }

    @Nested
    @DisplayName("查询图片")
    class QueryImageTests {

        @Test
        @DisplayName("按ID查询返回图片对象")
        void getById_ReturnsImage() {
            when(imageMapper.selectById(1)).thenReturn(testImage);

            TourismImage result = imageService.getById(1);

            assertNotNull(result);
            assertEquals("https://example.com/image.jpg", result.getUrl());
        }

        @Test
        @DisplayName("ID为null时返回null")
        void getById_ReturnsNull_WhenIdIsNull() {
            TourismImage result = imageService.getById(null);

            assertNull(result);
        }
    }

    @Nested
    @DisplayName("删除图片")
    class RemoveImageTests {

        @Test
        @DisplayName("ID列表不为空时删除成功")
        void removeByIds_Success() {
            List<Integer> ids = Arrays.asList(1, 2, 3);
            when(imageMapper.deleteBatchIds(ids)).thenReturn(3);

            boolean result = imageService.removeByIds(ids);

            assertTrue(result);
            verify(imageMapper).deleteBatchIds(ids);
        }

        @Test
        @DisplayName("ID列表为空时删除失败")
        void removeByIds_Fails_WhenIdsEmpty() {
            boolean result = imageService.removeByIds(Collections.emptyList());

            assertFalse(result);
            verify(imageMapper, never()).deleteBatchIds(any());
        }

        @Test
        @DisplayName("ID列表为null时删除失败")
        void removeByIds_Fails_WhenIdsNull() {
            boolean result = imageService.removeByIds(null);

            assertFalse(result);
            verify(imageMapper, never()).deleteBatchIds(any());
        }
    }
}
