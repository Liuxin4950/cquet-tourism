import request from '@/utils/request'

export function listNotice(query) {
  return request({
    url: '/tourism/notice/list',
    method: 'get',
    params: query
  })
}

export function getNotice(id) {
  return request({
    url: '/tourism/notice/' + id,
    method: 'get'
  })
}

export function addNotice(data) {
  return request({
    url: '/tourism/notice',
    method: 'post',
    data
  })
}

export function updateNotice(data) {
  return request({
    url: '/tourism/notice',
    method: 'put',
    data
  })
}

export function delNotice(id) {
  return request({
    url: '/tourism/notice/' + id,
    method: 'delete'
  })
}