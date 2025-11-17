import request from '@/utils/request'

// 获取特色活动列表
export function listScenicActivity(query) {
  return request({
    url: '/tourism/activity/list',
    method: 'get',
    params: query
  })
}

// 根据id获取特色活动信息
export function getScenicActivity(scenicActivityId) {
  return request({
    url: '/tourism/activity/' + scenicActivityId,
    method: 'get'
  })
}

// 新增特色活动
export function addScenicActivity(data) {
  return request({
    url: '/tourism/activity',            
    method: 'post',
    data: data
  })
}

// 特色活动状态管理，暂停 / 启动
export function updateScenicActivityStatus(scenicActivityId, status) {
  return request({
    url: '/tourism/activity/' + scenicActivityId + '/status/' + status,
    method: 'put'
  })
}

// 修改特色活动
export function updateScenicActivity(data) {
  return request({
    url: '/tourism/activity',
    method: 'put',
    data: data
  })
}

// 特色活动申报管理

// 查询特色活动申报列表（含待审核/通过/不通过）
export function listScenicActivityApplication(query) {
  return request({
    url: '/tourism/activity-application/list',
    method: 'get',
    params: query
  })
}

// 特色活动申报，审核通过
export function passScenicActivityApplication(scenicActivityApplicationId, opinion) {
  const hasQuery = opinion && typeof opinion === 'string' && opinion.length > 0
  return request({
    url: '/tourism/activity-application/' + scenicActivityApplicationId + '/approve' + (hasQuery ? ('?opinion=' + encodeURIComponent(opinion)) : ''),
    method: 'post',
    data: hasQuery ? undefined : (opinion ? { opinion } : undefined)
  })
}

// 特色活动申报，审核不通过（reason 可作为 query 或 body 传）
export function rejectScenicActivityApplication(scenicActivityApplicationId, reason) {
  const hasQuery = reason && typeof reason === 'string' && reason.length > 0
  return request({
    url: '/tourism/activity-application/' + scenicActivityApplicationId + '/reject' + (hasQuery ? ('?reason=' + encodeURIComponent(reason)) : ''),
    method: 'post',
    data: hasQuery ? undefined : { reason }
  })
}