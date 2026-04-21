export const spotListMock = {
  typeOptions: [
    { label: '全部类型', value: '' },
    { label: '5A 景区', value: 'AAAAA' },
    { label: '4A 景区', value: 'AAAA' },
    { label: '3A 景区', value: 'AAA' },
  ],
  sortOptions: [
    { label: '综合推荐', value: 'recommended' },
    { label: '名称排序', value: 'nameAsc' },
    { label: '等级优先', value: 'levelDesc' },
  ],
  cards: [
    {
      category: '历史文化',
      rating: '4.8',
      chips: ['山城夜景', '吊脚楼建筑', '巴渝文化'],
      duration: '2-3小时',
      distance: '2.3km',
    },
    {
      category: '城市地标',
      rating: '4.6',
      chips: ['购物天堂', '美食街区', '城市中心'],
      duration: '1-2小时',
      distance: '1.8km',
    },
    {
      category: '特色体验',
      rating: '4.7',
      chips: ['空中观景', '山城特色', '网红打卡'],
      duration: '30分钟',
      distance: '3.1km',
    },
    {
      category: '古镇古村',
      rating: '4.5',
      chips: ['古镇风情', '传统美食', '手工艺品'],
      duration: '3-4小时',
      distance: '8.6km',
    },
  ],
  fallbackDescription: '探索重庆代表性的自然与人文景观，感受山城独特的地貌、历史与城市生活气息。',
}

