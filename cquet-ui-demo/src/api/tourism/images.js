import request from '@/utils/request'

// 获取图片列表
export function listImages(query) {
  return request({
    url: '/tourism/images/list',
    method: 'get',
    params: query
  })
}

// 根据id获取图片信息
export function getImage(id) {
  return request({
    url: '/tourism/images/' + id,
    method: 'get'
  })
}

// 新增图片
export function addImage(data) {
  return request({
    url: '/tourism/images',
    method: 'post',
    data: data
  })
}

// 批量新增图片
export function addImagesBatch(urls) {
  return request({
    url: '/tourism/images/batch',
    method: 'post',
    data: urls
  })
}

// 删除图片
export function delImage(id) {
  return request({
    url: '/tourism/images/' + id,
    method: 'delete'
  })
}
