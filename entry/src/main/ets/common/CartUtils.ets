import { ProductInfo, getProductById } from './ProductData'

export const DESSERT_CATEGORY: string = '甜品'
export const DEFAULT_SPEC: string = '默认'
export const DEFAULT_TEMPERATURE: string = '正常冰'
export const DEFAULT_SUGAR: string = '正常糖'
export const temperatureList: string[] = [DEFAULT_TEMPERATURE, '少冰', '去冰', '常温', '热']
export const sugarList: string[] = [DEFAULT_SUGAR, '七分糖', '五分糖', '三分糖', '无糖']

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

export interface SpecInfo {
  temperature: string
  sugar: string
}

export interface CartState {
  cartCount: number
  cartTotal: number
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
  const total: CartTotal = { count: 0, total: 0 }
  getCartProducts(cartItems).forEach((item: CartProductInfo) => {
    total.count += item.count
    total.total += item.price * item.count
  })
  return total
}

export function refreshCartState(state: CartState, cartItems: CartItemInfo[]): void {
  const total: CartTotal = getCartTotal(cartItems)
  state.cartCount = total.count
  state.cartTotal = total.total
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
  return `${item.id}_${item.temperature}_${item.sugar}_${item.count}`
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
  if (!cartItems.some((cartItem: CartItemInfo) => isSameCartSpec(cartItem, id, temperature, sugar))) {
    return cartItems.concat(buildCartItem(id, count, temperature, sugar))
  }

  return cartItems.map((cartItem: CartItemInfo) => isSameCartSpec(cartItem, id, temperature, sugar)
    ? buildCartItem(cartItem.id, cartItem.count + count, cartItem.temperature, cartItem.sugar)
    : cartItem)
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
  return isDessertCategory(category) ? '默认规格' : `${temperature} / ${sugar}`
}

export function isDessertCategory(category: string): boolean {
  return category === DESSERT_CATEGORY
}

export function getDefaultSpec(category: string): SpecInfo {
  return isDessertCategory(category)
    ? { temperature: DEFAULT_SPEC, sugar: DEFAULT_SPEC }
    : { temperature: DEFAULT_TEMPERATURE, sugar: DEFAULT_SUGAR }
}
