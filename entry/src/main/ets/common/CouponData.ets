export interface CouponInfo {
  id: string
  money: number
  title: string
  desc: string
  limitMoney: number
}

function createCoupon(id: string, money: number, title: string, desc: string, limitMoney: number): CouponInfo {
  return { id, money, title, desc, limitMoney }
}

export const couponList: CouponInfo[] = [
  createCoupon('new-user', 8, '新人下单立减券', '满 20 元可用', 20),
  createCoupon('milk-tea', 5, '奶茶专区优惠券', '购买奶茶类商品可用，满 20 元可用', 20),
  createCoupon('fruit-tea', 6, '果茶清爽券', '购买果茶类商品可用，满 20 元可用', 20)
]
