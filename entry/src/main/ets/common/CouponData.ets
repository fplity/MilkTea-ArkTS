export interface CouponInfo {
  id: string        // 唯一标识符
  money: number     // 面值
  title: string     // 优惠券名称
  desc: string      // 使用描述
  limitMoney: number // 满减条件
}

export const couponList: CouponInfo[] = [
  {
    id: 'new-user',
    money: 8,
    title: '新人下单立减券',
    desc: '满 20 元可用',
    limitMoney: 20
  },
  {
    id: 'milk-tea',
    money: 5,
    title: '奶茶专区优惠券',
    desc: '购买奶茶类商品可用，满 20 元可用',
    limitMoney: 20
  },
  {
    id: 'fruit-tea',
    money: 6,
    title: '果茶清爽券',
    desc: '购买果茶类商品可用，满 20 元可用',
    limitMoney: 20
  }
]

// 根据 id 获取优惠券
export function getCouponById(id: string): CouponInfo | undefined {
  return couponList.find((item) => item.id === id)
}