export interface StoreInfo {
  id: number
  name: string
  address: string
  distance: number
  latitude: number
  longitude: number
  openTime: string
  phone: string
  mapImage: Resource
}

export const storeList: StoreInfo[] = [
  {
    id: 1,
    name: '星野奶茶 松山湖校区店',
    address: '广东科技学院松山湖校区南门附近',
    distance: 0.8,
    latitude: 22.9021,
    longitude: 113.8806,
    openTime: '09:00-22:00',
    phone: '18800010001',
    mapImage: $r('app.media.map_store1')
  },
  {
    id: 2,
    name: '星野奶茶 大岭山店',
    address: '东莞市大岭山镇教育路88号',
    distance: 2.4,
    latitude: 22.9125,
    longitude: 113.8632,
    openTime: '10:00-22:30',
    phone: '18800010002',
    mapImage: $r('app.media.map_store2')
  },
  {
    id: 3,
    name: '星野奶茶 松湖万科店',
    address: '东莞松山湖万科生活广场一楼',
    distance: 4.6,
    latitude: 22.9288,
    longitude: 113.8915,
    openTime: '09:30-23:00',
    phone: '18800010003',
    mapImage: $r('app.media.map_store3')
  }
]

// 根据 id 获取门店
export function getStoreById(id: number): StoreInfo | undefined {
  return storeList.find((item) => item.id === id)
}

// 根据 id 获取门店，找不到时回到第一个门店
export function getStoreByIdOrFirst(id: number): StoreInfo {
  const store: StoreInfo | undefined = getStoreById(id)
  return store !== undefined ? store : storeList[0]
}

// 获取距离最近的门店
export function getNearestStore(): StoreInfo {
  let nearest = storeList[0]
  storeList.forEach((item) => {
    if (item.distance < nearest.distance) {
      nearest = item
    }
  })
  return nearest
}

// 根据 id 获取门店，找不到时回到最近门店
export function getStoreByIdOrNearest(id: number): StoreInfo {
  const store: StoreInfo | undefined = getStoreById(id)
  return store !== undefined ? store : getNearestStore()
}
