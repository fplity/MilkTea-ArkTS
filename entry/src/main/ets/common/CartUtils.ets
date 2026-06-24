import { ProductInfo, getProductById } from './ProductData'

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

function buildCartItem(id: number, count: number, temperature: string, sugar: string): CartItemInfo {
  return {
    id: id,
    count: count,
    temperature: temperature,
    sugar: sugar
  }
}

// 根据购物车条目获取完整商品信息列表
export function getCartProducts(cartItems: CartItemInfo[]): CartProductInfo[] {
  const result: CartProductInfo[] = []
  cartItems.forEach((cartItem: CartItemInfo) => {
    const product: ProductInfo | undefined = getProductById(cartItem.id)

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
    const product: ProductInfo | undefined = getProductById(cartItem.id)
    if (product !== undefined && cartItem.count > 0) {
      totalCount += cartItem.count
      totalMoney += product.price * cartItem.count
    }
  })
  return { count: totalCount, total: totalMoney }
}

function isSameCartSpec(cartItem: CartItemInfo, id: number, temperature: string, sugar: string): boolean {
  return cartItem.id === id &&
    cartItem.temperature === temperature &&
    cartItem.sugar === sugar
}

// 判断两个购物车条目是否为同一商品、同一规格
export function isSameCartItem(cartItem: CartItemInfo, item: CartProductInfo): boolean {
  return isSameCartSpec(cartItem, item.id, item.temperature, item.sugar)
}

// 生成购物车渲染 key，保持页面原有 key 规则
export function getCartProductKey(item: CartProductInfo): string {
  return item.id.toString() + '_' + item.temperature + '_' + item.sugar + '_' + item.count.toString()
}

// 获取某个商品在购物车里的总数量
export function getProductTotalCount(cartItems: CartItemInfo[], id: number): number {
  let count: number = 0

  cartItems.forEach((item: CartItemInfo) => {
    if (item.id === id && item.count > 0) {
      count += item.count
    }
  })

  return count
}

// 将指定规格加入购物车；已有相同规格时合并数量
export function addCartItem(
  cartItems: CartItemInfo[],
  id: number,
  temperature: string,
  sugar: string,
  count: number
): CartItemInfo[] {
  let hasItem: boolean = false
  const newCartItems: CartItemInfo[] = []

  cartItems.forEach((cartItem: CartItemInfo) => {
    if (isSameCartSpec(cartItem, id, temperature, sugar)) {
      hasItem = true
      newCartItems.push(buildCartItem(cartItem.id, cartItem.count + count, cartItem.temperature, cartItem.sugar))
    } else {
      newCartItems.push(cartItem)
    }
  })

  if (!hasItem) {
    newCartItems.push(buildCartItem(id, count, temperature, sugar))
  }

  return newCartItems
}

// 增减购物车条目；减到 0 时移除该规格
export function updateCartItemCount(cartItems: CartItemInfo[], item: CartProductInfo, type: string): CartItemInfo[] {
  const newCartItems: CartItemInfo[] = []

  cartItems.forEach((cartItem: CartItemInfo) => {
    if (isSameCartItem(cartItem, item)) {
      if (type === 'add') {
        newCartItems.push(buildCartItem(cartItem.id, cartItem.count + 1, cartItem.temperature, cartItem.sugar))
      } else if (cartItem.count > 1) {
        newCartItems.push(buildCartItem(cartItem.id, cartItem.count - 1, cartItem.temperature, cartItem.sugar))
      }
    } else {
      newCartItems.push(cartItem)
    }
  })

  return newCartItems
}

// 删除购物车中的指定规格
export function deleteCartItem(cartItems: CartItemInfo[], item: CartProductInfo): CartItemInfo[] {
  return cartItems.filter((cartItem: CartItemInfo) => !isSameCartItem(cartItem, item))
}

// 根据类别和规格组合文字：甜品没有冷热甜度选择
export function getSpecText(category: string, temperature: string, sugar: string): string {
  if (category === '甜品') {
    return '默认规格'
  }
  return `${temperature} / ${sugar}`
}
