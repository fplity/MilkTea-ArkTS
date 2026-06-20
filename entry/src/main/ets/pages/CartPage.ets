import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

interface ProductInfo {
  id: number
  name: string
  category: string
  price: number
  image: Resource
  desc: string
}

interface CartItemInfo {
  id: number
  count: number
}

interface CartProductInfo {
  id: number
  name: string
  category: string
  price: number
  image: Resource
  desc: string
  count: number
}

const productList: ProductInfo[] = [
  { id: 1, name: '珍珠奶茶', category: '奶茶', price: 18, image: $r('app.media.product1'), desc: '经典奶茶，香浓顺滑' },
  { id: 2, name: '鲜果百香绿茶', category: '果茶', price: 20, image: $r('app.media.product2'), desc: '百香果香，绿茶清爽' },
  { id: 3, name: '草莓奶油蛋糕', category: '甜品', price: 22, image: $r('app.media.product3'), desc: '草莓香甜，奶油细腻' },
  { id: 4, name: '生椰拿铁', category: '咖啡', price: 20, image: $r('app.media.product4'), desc: '椰香浓郁，咖啡顺滑' },
  { id: 5, name: '冰美式', category: '咖啡', price: 16, image: $r('app.media.product5'), desc: '冰爽提神，口感清爽' },
  { id: 6, name: '葡萄多多', category: '果茶', price: 22, image: $r('app.media.product6'), desc: '葡萄香甜，酸甜清爽' },
  { id: 7, name: '芋泥波波奶茶', category: '奶茶', price: 21, image: $r('app.media.product7'), desc: '芋泥绵密，波波Q弹' },
  { id: 8, name: '茉莉奶绿', category: '奶茶', price: 19, image: $r('app.media.product8'), desc: '茉莉清香，奶绿顺滑' },
  { id: 9, name: '黑糖珍珠奶茶', category: '奶茶', price: 20, image: $r('app.media.product9'), desc: '黑糖香甜，奶茶顺滑' },
  { id: 10, name: '奥利奥奶茶', category: '奶茶', price: 19, image: $r('app.media.product10'), desc: '奥利奥碎，奶香浓郁' },
  { id: 11, name: '抹茶红豆奶茶', category: '奶茶', price: 21, image: $r('app.media.product11'), desc: '抹茶清香，红豆软糯' },
  { id: 12, name: '经典拿铁', category: '咖啡', price: 18, image: $r('app.media.product12'), desc: '经典拿铁，奶香柔和' },
  { id: 13, name: '卡布奇诺', category: '咖啡', price: 19, image: $r('app.media.product13'), desc: '奶泡绵密，咖啡香浓' },
  { id: 14, name: '摩卡咖啡', category: '咖啡', price: 21, image: $r('app.media.product14'), desc: '摩卡香浓，巧克力味' },
  { id: 15, name: '焦糖玛奇朵', category: '咖啡', price: 22, image: $r('app.media.product15'), desc: '焦糖香甜，咖啡顺滑' },
  { id: 16, name: '提拉米苏', category: '甜品', price: 28, image: $r('app.media.product16'), desc: '咖啡奶香，入口绵密' },
  { id: 17, name: '芒果布丁', category: '甜品', price: 18, image: $r('app.media.product17'), desc: '芒果香甜，布丁嫩滑' },
  { id: 18, name: '巧克力慕斯', category: '甜品', price: 24, image: $r('app.media.product18'), desc: '慕斯丝滑，巧克力香' },
  { id: 19, name: '原味芝士蛋糕', category: '甜品', price: 22, image: $r('app.media.product19'), desc: '芝士香浓，入口细腻' },
  { id: 20, name: '奶油泡芙', category: '甜品', price: 16, image: $r('app.media.product20'), desc: '外皮酥香，奶油顺滑' },
  { id: 21, name: '满杯百香果', category: '果茶', price: 22, image: $r('app.media.product21'), desc: '百香果香，酸甜清爽' },
  { id: 22, name: '蜜桃乌龙茶', category: '果茶', price: 20, image: $r('app.media.product22'), desc: '蜜桃清甜，乌龙茶香' },
  { id: 23, name: '柠檬茉莉茶', category: '果茶', price: 18, image: $r('app.media.product23'), desc: '柠檬清爽，茉莉清香' },
  { id: 24, name: '葡萄芝士茶', category: '果茶', price: 24, image: $r('app.media.product24'), desc: '葡萄香甜，芝士浓郁' },
  { id: 25, name: '西瓜冰茶', category: '果茶', price: 19, image: $r('app.media.product25'), desc: '西瓜清甜，冰爽解渴' },
  { id: 26, name: '杨枝甘露', category: '果茶', price: 20, image: $r('app.media.product26'), desc: '芒果清甜，椰香浓郁' }
]

@Entry
@Component
struct CartPage {
  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  aboutToAppear(): void {
    this.refreshCartMoney()
  }

  private goBack(): void {
    router.back()
  }

  private goMenu(): void {
    router.replaceUrl({
      url: 'pages/MenuPage'
    })
  }

  private getProductById(id: number): ProductInfo | undefined {
    return productList.find((item: ProductInfo) => item.id === id)
  }

  private getCartProducts(): CartProductInfo[] {
    const result: CartProductInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      const product = this.getProductById(cartItem.id)

      if (product !== undefined && cartItem.count > 0) {
        result.push({
          id: product.id,
          name: product.name,
          category: product.category,
          price: product.price,
          image: product.image,
          desc: product.desc,
          count: cartItem.count
        })
      }
    })

    return result
  }

  private refreshCartMoney(): void {
    let count: number = 0
    let total: number = 0

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      const product = this.getProductById(cartItem.id)

      if (product !== undefined && cartItem.count > 0) {
        count += cartItem.count
        total += product.price * cartItem.count
      }
    })

    this.cartCount = count
    this.cartTotal = total
  }

  private addItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (cartItem.id === item.id) {
        newCartItems.push({
          id: cartItem.id,
          count: cartItem.count + 1
        })
      } else {
        newCartItems.push(cartItem)
      }
    })

    this.cartItems = newCartItems
    this.refreshCartMoney()
  }

  private reduceItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (cartItem.id === item.id) {
        if (cartItem.count > 1) {
          newCartItems.push({
            id: cartItem.id,
            count: cartItem.count - 1
          })
        }
      } else {
        newCartItems.push(cartItem)
      }
    })

    this.cartItems = newCartItems
    this.refreshCartMoney()
  }

  private deleteItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (cartItem.id !== item.id) {
        newCartItems.push(cartItem)
      }
    })

    this.cartItems = newCartItems
    this.refreshCartMoney()

    promptAction.showToast({
      message: item.name + ' 已删除'
    })
  }

  private clearCart(): void {
    if (this.cartCount === 0) {
      promptAction.showToast({
        message: '购物车已经是空的'
      })
      return
    }

    this.cartItems = []
    this.cartCount = 0
    this.cartTotal = 0

    promptAction.showToast({
      message: '购物车已清空'
    })
  }

  private checkout(): void {
    if (this.cartCount === 0) {
      promptAction.showToast({
        message: '请先选择商品'
      })
      return
    }

    router.pushUrl({
      url: 'pages/OrderPage'
    })
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text('←')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B2A1A')
        }
        .width(46)
        .height(46)
        .borderRadius(23)
        .backgroundColor('#FFFFFF')
        .border({
          width: 1,
          color: '#E8D3BD'
        })
        .shadow({
          radius: 14,
          color: '#22000000',
          offsetX: 0,
          offsetY: 5
        })
        .onClick(() => {
          this.goBack()
        })

        Column() {
          Text('购物车')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text('确认你的点单')
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 2 })
        }
        .margin({ left: 14 })
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('共' + this.cartCount.toString() + '件')
          .fontSize(14)
          .fontColor('#8B5E3C')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#F6E5D2')
          .borderRadius(16)
      }
      .width('100%')
      .height(82)
      .padding({ left: 18, right: 18 })
      .backgroundColor('#FFF7EC')

      Scroll() {
        Column() {
          if (this.getCartProducts().length === 0) {
            this.EmptyCart()
          } else {
            this.TakeWayCard()
            this.CartTitle()

            ForEach(this.getCartProducts(), (item: CartProductInfo) => {
              this.CartCard(item)
            }, (item: CartProductInfo) => item.id.toString() + '_' + item.count.toString())

            this.PriceCard()

            Blank()
              .height(120)
          }
        }
        .width('100%')
        .padding({ left: 18, right: 18, top: 14 })
      }
      .layoutWeight(1)
      .backgroundColor('#FFF7EC')

      if (this.getCartProducts().length > 0) {
        this.BottomPayBar()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  EmptyCart() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('🛒')
          .fontSize(48)
      }
      .width(110)
      .height(110)
      .borderRadius(55)
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 14,
        color: '#14000000',
        offsetX: 0,
        offsetY: 6
      })

      Text('购物车空空的')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .margin({ top: 26 })

      Text('快去挑选喜欢的奶茶、咖啡和甜品吧')
        .fontSize(14)
        .fontColor('#9A7B60')
        .margin({ top: 10 })

      Button('去点单')
        .width(150)
        .height(48)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#8B5E3C')
        .borderRadius(24)
        .margin({ top: 30 })
        .onClick(() => {
          this.goMenu()
        })
    }
    .width('100%')
    .height(520)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  TakeWayCard() {
    Row() {
      Column() {
        Text('温馨提示')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ bottom: 6 })

        Text('饮品现点现做，请尽快取餐')
          .fontSize(14)
          .fontColor('#8B6F58')

        Text('预计 10-15 分钟完成制作')
          .fontSize(13)
          .fontColor('#9A7B60')
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('推荐')
        .fontSize(13)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .backgroundColor('#8B5E3C')
        .borderRadius(16)
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#FFFFFF')
    .borderRadius(26)
    .shadow({
      radius: 12,
      color: '#12000000',
      offsetX: 0,
      offsetY: 5
    })
  }

  @Builder
  CartTitle() {
    Row() {
      Text('已选商品')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .layoutWeight(1)

      Text('清空')
        .fontSize(14)
        .fontColor('#A36A3C')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .backgroundColor('#F6E5D2')
        .borderRadius(15)
        .onClick(() => {
          this.clearCart()
        })
    }
    .width('100%')
    .margin({ top: 26, bottom: 14 })
  }

  @Builder
  CartCard(item: CartProductInfo) {
    Row() {
      Image(item.image)
        .width(88)
        .height(88)
        .objectFit(ImageFit.Cover)
        .borderRadius(20)
        .backgroundColor('#F2E6DA')

      Column() {
        Row() {
          Text(item.name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(item.category)
            .fontSize(12)
            .fontColor('#8B5E3C')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor('#F6E5D2')
            .borderRadius(12)
        }
        .width('100%')

        Text(item.desc)
          .fontSize(12)
          .fontColor('#7A6251')
          .margin({ top: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Row() {
          Text('￥' + item.price.toString())
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')

          Blank()

          Stack({ alignContent: Alignment.Center }) {
            Text('-')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8B5E3C')
          }
          .width(32)
          .height(32)
          .borderRadius(16)
          .backgroundColor('#F6E5D2')
          .onClick(() => {
            this.reduceItem(item)
          })

          Text(item.count.toString())
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .margin({ left: 12, right: 12 })

          Stack({ alignContent: Alignment.Center }) {
            Text('＋')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(32)
          .height(32)
          .borderRadius(16)
          .backgroundColor('#8B5E3C')
          .onClick(() => {
            this.addItem(item)
          })
        }
        .width('100%')
        .margin({ top: 10 })

        Text('删除')
          .fontSize(12)
          .fontColor('#B65A3A')
          .margin({ top: 8 })
          .onClick(() => {
            this.deleteItem(item)
          })
      }
      .layoutWeight(1)
      .margin({ left: 14 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(14)
    .margin({ bottom: 14 })
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  PriceCard() {
    Column() {
      Row() {
        Text('商品数量')
          .fontSize(15)
          .fontColor('#7A6251')
          .layoutWeight(1)

        Text(this.cartCount.toString() + ' 件')
          .fontSize(15)
          .fontColor('#2E2118')
      }
      .width('100%')

      Row() {
        Text('商品金额')
          .fontSize(15)
          .fontColor('#7A6251')
          .layoutWeight(1)

        Text('￥' + this.cartTotal.toString())
          .fontSize(15)
          .fontColor('#2E2118')
      }
      .width('100%')
      .margin({ top: 12 })

      Row() {
        Text('优惠金额')
          .fontSize(15)
          .fontColor('#7A6251')
          .layoutWeight(1)

        Text('￥0')
          .fontSize(15)
          .fontColor('#2E2118')
      }
      .width('100%')
      .margin({ top: 12 })

      Row() {
        Text('实付合计')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text('￥' + this.cartTotal.toString())
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
      }
      .width('100%')
      .margin({ top: 18 })
    }
    .width('100%')
    .padding(18)
    .margin({ top: 10 })
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  BottomPayBar() {
    Row() {
      Column() {
        Text('合计')
          .fontSize(14)
          .fontColor('#8B6F58')

        Text('￥' + this.cartTotal.toString())
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('去结算')
        .width(132)
        .height(50)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.cartCount === 0 ? '#C9B8A6' : '#8B5E3C')
        .borderRadius(25)
        .onClick(() => {
          this.checkout()
        })
    }
    .width('100%')
    .height(88)
    .padding({ left: 18, right: 18 })
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 14,
      color: '#18000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}