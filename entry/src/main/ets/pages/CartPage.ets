import router from '@ohos.router'
import {
  CartItemInfo,
  CartProductInfo,
  CartTotal,
  deleteCartItem as removeCartItem,
  getCartProductKey,
  getCartProducts as buildCartProducts,
  getCartTotal as calcCartTotal,
  getSpecText as buildSpecText,
  updateCartItemCount
} from '../common/CartUtils'
import { showToast } from '../common/AppToast'


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

  private getCartProducts(): CartProductInfo[] {
    return buildCartProducts(this.cartItems)
  }

  private refreshCartMoney(): void {
    const cartTotalInfo: CartTotal = calcCartTotal(this.cartItems)

    this.cartCount = cartTotalInfo.count
    this.cartTotal = cartTotalInfo.total
  }

  private updateItem(item: CartProductInfo, type: string): void {
    this.cartItems = updateCartItemCount(this.cartItems, item, type)
    this.refreshCartMoney()
  }

  private deleteItem(item: CartProductInfo): void {
    this.cartItems = removeCartItem(this.cartItems, item)
    this.refreshCartMoney()

    showToast(item.name + ' 已删除')
  }

  private clearCart(): void {
    if (this.cartCount === 0) {
      showToast('购物车已经是空的')
      return
    }

    this.cartItems = []
    this.cartCount = 0
    this.cartTotal = 0

    showToast('购物车已清空')
  }

  private checkout(): void {
    if (this.cartCount === 0) {
      showToast('请先选择商品')
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
            }, (item: CartProductInfo) => getCartProductKey(item))

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

        Text(buildSpecText(item.category, item.temperature, item.sugar))
          .fontSize(12)
          .fontColor('#B08A68')
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
            this.updateItem(item, 'reduce')
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
            this.updateItem(item, 'add')
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
