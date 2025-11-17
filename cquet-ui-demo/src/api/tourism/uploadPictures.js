import request from '@/utils/request'

// 上传图片地址
// 修正：批量上传图片 URL 列表（JSON 数组格式）
export function batchUploadImageUrls(urls) {
  return request({
    url: '/tourism/images/batch',
    method: 'post',
    data: urls // 直接传数组，如 ["1.jpg", "2.jpg"]
  });
}