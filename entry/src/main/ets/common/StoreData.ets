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

function createStore(id: number, name: string, address: string, distance: number, latitude: number, longitude: number, openTime: string, phone: string, mapImage: Resource): StoreInfo {
  return { id, name, address, distance, latitude, longitude, openTime, phone, mapImage }
}

export const storeList: StoreInfo[] = [
  createStore(1, '星野奶茶 松山湖校区店', '广东科技学院松山湖校区南门附近', 0.8, 22.9021, 113.8806, '09:00-22:00', '18800010001', $r('app.media.map_store1')),
  createStore(2, '星野奶茶 大岭山店', '东莞市大岭山镇教育路88号', 2.4, 22.9125, 113.8632, '10:00-22:30', '18800010002', $r('app.media.map_store2')),
  createStore(3, '星野奶茶 松湖万科店', '东莞松山湖万科生活广场一楼', 4.6, 22.9288, 113.8915, '09:30-23:00', '18800010003', $r('app.media.map_store3'))
]

export function getStoreById(id: number): StoreInfo | undefined {
  return storeList.find((item: StoreInfo) => item.id === id)
}

export function getStoreByIdOrFirst(id: number): StoreInfo {
  const store: StoreInfo | undefined = getStoreById(id)
  return store !== undefined ? store : storeList[0]
}

export function getNearestStore(): StoreInfo {
  let nearest = storeList[0]
  storeList.forEach((item: StoreInfo) => {
    if (item.distance < nearest.distance) {
      nearest = item
    }
  })
  return nearest
}

export function getStoreByIdOrNearest(id: number): StoreInfo {
  const store: StoreInfo | undefined = getStoreById(id)
  return store !== undefined ? store : getNearestStore()
}
