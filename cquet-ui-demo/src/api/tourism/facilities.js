import request from '@/utils/request'

export function listFacilities(query) {
  return request({
    url: '/tourism/facilities/list',
    method: 'get',
    params: query
  })
}

export function getFacilities(id) {
  return request({
    url: '/tourism/facilities/' + id,
    method: 'get'
  })
}

export function addFacilities(data) {
  return request({
    url: '/tourism/facilities',
    method: 'post',
    data
  })
}

export function updateFacilities(data) {
  return request({
    url: '/tourism/facilities',
    method: 'put',
    data
  })
}

export function delFacilities(ids) {
  return request({
    url: '/tourism/facilities/' + ids,
    method: 'delete'
  })
}