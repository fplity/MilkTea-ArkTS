import { productList, ProductInfo } from './ProductData'

export interface CartItemInfo {
  id: number
  count: number
  temperature: string
  sugar: string
}

export interface CartProductInfo extends ProductInfo {
  count: number
  temperature: string
  sugar: string
}

// 购物车总数和总价的类型（避免匿名对象类型）
export interface CartTotal {
  count: number
  total: number
}

// 根据购物车条目获取完整商品信息列表
export function getCartProducts(cartItems: CartItemInfo[]): CartProductInfo[] {
  const result: CartProductInfo[] = []
  cartItems.forEach((cartItem: CartItemInfo) => {
    // 查找商品
    const product: ProductInfo | undefined = productList.find((item: ProductInfo) => item.id === cartItem.id)
    // 商品存在且数量大于 0，则加入购物车列表
    if (product !== undefined && cartItem.count > 0) {
      const cartProduct: CartProductInfo = {
        id: product.id,
        name: product.name,
        category: product.category,
        categoryCode: product.categoryCode,
        price: product.price,
        image: product.image,
        desc: product.desc,
        tag: product.tag,
        detail: product.detail,
        count: cartItem.count,
        temperature: cartItem.temperature,
        sugar: cartItem.sugar
      }
      result.push(cartProduct)
    }
  })
  return result
}

// 计算购物车中商品的总数和总金额
export function getCartTotal(cartItems: CartItemInfo[]): CartTotal {
  let totalCount: number = 0
  let totalMoney: number = 0
  cartItems.forEach((cartItem: CartItemInfo) => {
    const product: ProductInfo | undefined = productList.find((item: ProductInfo) => item.id === cartItem.id)
    if (product !== undefined && cartItem.count > 0) {
      totalCount += cartItem.count
      totalMoney += product.price * cartItem.count
    }
  })
  return { count: totalCount, total: totalMoney }
}

// 根据类别和规格组合文字：甜品没有冷热甜度选择
export function getSpecText(category: string, temperature: string, sugar: string): string {
  if (category === '甜品') {
    return '默认规格'
  }
  return `${temperature} / ${sugar}`
}