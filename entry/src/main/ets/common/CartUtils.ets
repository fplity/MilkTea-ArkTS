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

export interface CartTotal {
  count: number
  total: number
}

function buildCartItem(id: number, count: number, temperature: string, sugar: string): CartItemInfo {
  return { id, count, temperature, sugar }
}

export function getCartProducts(cartItems: CartItemInfo[]): CartProductInfo[] {
  const result: CartProductInfo[] = []
  cartItems.forEach((cartItem: CartItemInfo) => {
    const product: ProductInfo | undefined = getProductById(cartItem.id)

    if (product !== undefined && cartItem.count > 0) {
      result.push({
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
      })
    }
  })
  return result
}

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

export function isSameCartItem(cartItem: CartItemInfo, item: CartProductInfo): boolean {
  return isSameCartSpec(cartItem, item.id, item.temperature, item.sugar)
}

export function getCartProductKey(item: CartProductInfo): string {
  return item.id.toString() + '_' + item.temperature + '_' + item.sugar + '_' + item.count.toString()
}

export function getProductTotalCount(cartItems: CartItemInfo[], id: number): number {
  let count: number = 0

  cartItems.forEach((item: CartItemInfo) => {
    if (item.id === id && item.count > 0) {
      count += item.count
    }
  })

  return count
}

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

export function updateCartItemCount(cartItems: CartItemInfo[], item: CartProductInfo, type: string): CartItemInfo[] {
  const offset: number = type === 'add' ? 1 : -1
  const newCartItems: CartItemInfo[] = []

  cartItems.forEach((cartItem: CartItemInfo) => {
    if (isSameCartItem(cartItem, item)) {
      const nextCount: number = cartItem.count + offset
      if (nextCount > 0) {
        newCartItems.push(buildCartItem(cartItem.id, nextCount, cartItem.temperature, cartItem.sugar))
      }
    } else {
      newCartItems.push(cartItem)
    }
  })

  return newCartItems
}

export function deleteCartItem(cartItems: CartItemInfo[], item: CartProductInfo): CartItemInfo[] {
  return cartItems.filter((cartItem: CartItemInfo) => !isSameCartItem(cartItem, item))
}

export function getSpecText(category: string, temperature: string, sugar: string): string {
  if (category === '甜品') {
    return '默认规格'
  }
  return `${temperature} / ${sugar}`
}
