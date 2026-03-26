import request from '@/utils/request'

// 获取场馆列表
export function listScenicVenue(query) {
  return request({
    url: '/tourism/venue/list',
    method: 'get',
    params: query
  })
}

// 根据id获取场馆信息
export function getScenicVenue(scenicVenueId) {
  return request({
    url: '/tourism/venue/' + scenicVenueId,
    method: 'get'
  })
}

// 新增场馆
export function addScenicVenue(data) {
  return request({
    url: '/tourism/venue',            
    method: 'post',
    data: data
  })
}

// 修改场馆
export function updateScenicVenue(data) {
  return request({
    url: '/tourism/venue',
    method: 'put',
    data: data
  })
}

// 删除场馆
export function delScenicVenue(scenicVenueId) {
  return request({
    url: '/tourism/venue/' + scenicVenueId,
    method: 'delete'
  })
}

// 查看当前场馆活动列表
export function listScenicVenueActivity(scenicVenueId) {
  return request({
    url: '/tourism/venue/' + scenicVenueId + '/activities',
    method: 'get'
  })
}