import request from '@/utils/request'

// 获取仪表盘统计数据
export function getDashboardStatistics() {
  return request({
    url: '/tourism/dashboard/statistics',
    method: 'get'
  })
}

// 获取各区县景区分布
export function getDistrictDistribution() {
  return request({
    url: '/tourism/dashboard/district-distribution',
    method: 'get'
  })
}

// 获取景区热度排行
export function getHotSpotRanking() {
  return request({
    url: '/tourism/dashboard/hotspot-ranking',
    method: 'get'
  })
}

// 获取活动趋势数据
export function getActivityTrend() {
  return request({
    url: '/tourism/dashboard/activity-trend',
    method: 'get'
  })
}

// 获取景区地图分布数据
export function getMapDistribution() {
  return request({
    url: '/tourism/dashboard/map-distribution',
    method: 'get'
  })
}
