import request from '@/utils/request'

// 获取景区列表
export function listScenicSpot(query) {
  return request({
    url: '/tourism/scenic-spot/list',
    method: 'get',
    params: query
  })
}

// 根据id获取景区信息
export function getScenicSpot(scenicSpotId) {
  return request({
    url: '/tourism/scenic-spot/' + scenicSpotId,
    method: 'get'
  })
}

// 新增景区
export function addScenicSpot(data) {
  return request({
    url: '/tourism/scenic-spot',            
    method: 'post',
    data: data
  })
}

// 修改景区
export function updateScenicSpot(data) {
  return request({
    url: '/tourism/scenic-spot',
    method: 'put',
    data: data
  })
}

// 删除景区
export function delScenicSpot(scenicSpotId) {
  return request({
    url: '/tourism/scenic-spot/' + scenicSpotId,
    method: 'delete'
  })
}

// 上传图片
export function uploadImage(file) {
  const formData = new FormData()
  formData.append('file', file) // 必须命名为 'file'

  return request({
    url: '/common/upload',
    method: 'post',
    data: formData
  })
}
