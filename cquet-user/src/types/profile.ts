export type ProfileTab = 'info' | 'applications' | 'collections' | 'comments'

export interface ProfileTabItem {
  key: ProfileTab
  label: string
}

export type ApplicationStatus = 'pending' | 'approved' | 'rejected'

export interface ActivityApplication {
  id: number
  activityId: number
  activityName: string
  venueName: string
  category: string
  startTime: string
  endTime: string
  coverImage: string
  appliedAt: string
  status: ApplicationStatus
  reason?: string
}

export interface UserCollectionItem {
  id: number
  targetId: number
  title: string
  type: 'spot' | 'venue' | 'activity'
  image: string
  description: string
  collectedAt: string
}

export interface UserCommentItem {
  id: number
  activityId: number
  activityName: string
  content: string
  createdAt: string
  replyCount: number
}
