import router from '@ohos.router'
import { AppTopBar } from '../common/AppTopBar'
import { StoreInfo, getStoreByIdOrFirst } from '../common/StoreData'
import {
  CartItemInfo,
  CartProductInfo,
  CartTotal,
  getCartProducts as buildCartProducts,
  getCartTotal as calcCartTotal,
  getSpecText as buildSpecText
} from '../common/CartUtils'
import { PaidOrderInfo } from '../common/OrderModel'
import { showToast } from '../common/AppToast'

interface OrderParams {
  orderType?: string
  selectedStoreId?: number
  deliveryAddress?: string
  deliveryStoreId?: number
}

@Entry
@Component
struct OrderPage {
  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  @StorageLink('selectedCouponMoney') selectedCouponMoney: number = 0
  @StorageLink('selectedCouponTitle') selectedCouponTitle: string = ''
  @StorageLink('selectedCouponLimit') selectedCouponLimit: number = 0

  @StorageLink('paidOrders') paidOrders: PaidOrderInfo[] = []
  @StorageLink('orderType') orderType: string = '自取'
  @StorageLink('selectedStoreId') selectedStoreId: number = 1
  @StorageLink('deliveryAddress') deliveryAddress: string = ''
  @StorageLink('deliveryStoreId') deliveryStoreId: number = 1

  @State remark: string = ''
  @State payWay: string = '微信支付'
  @State orderNo: string = 'MT20260608'

  aboutToAppear(): void {
    this.syncOrderParams()
    this.refreshOrderMoney()
    this.orderNo = 'MT' + Date.now().toString()
  }

  private goMenu(): void {
    router.replaceUrl({
      url: 'pages/MenuPage'
    })
  }

  private goCoupon(): void {
    router.pushUrl({
      url: 'pages/CouponPage'
    })
  }

  private syncOrderParams(): void {
    const params = router.getParams() as OrderParams

    if (params === undefined) {
      return
    }

    if (params.orderType !== undefined) {
      this.orderType = params.orderType
    }

    if (params.selectedStoreId !== undefined) {
      this.selectedStoreId = Number(params.selectedStoreId)
    }

    if (params.deliveryAddress !== undefined) {
      this.deliveryAddress = params.deliveryAddress
    }

    if (params.deliveryStoreId !== undefined) {
      this.deliveryStoreId = Number(params.deliveryStoreId)
    }
  }

  private getSelectedStore(): StoreInfo {
    return getStoreByIdOrFirst(this.selectedStoreId)
  }

  private getDeliveryStore(): StoreInfo {
    return getStoreByIdOrFirst(this.deliveryStoreId)
  }

  private getCurrentTakeWayText(): string {
    return this.orderType === '外卖' ? '外卖配送' : '到店自取'
  }

  private getReceiveMainText(): string {
    if (this.orderType === '外卖') {
      if (this.deliveryAddress.trim().length > 0) {
        return this.deliveryAddress
      }

      return '未填写配送地址'
    }

    return this.getSelectedStore().name
  }

  private getReceiveSubText(): string {
    if (this.orderType === '外卖') {
      return '由 ' + this.getDeliveryStore().name + ' 配送，预计距离 ' + this.getDeliveryStore().distance.toString() + 'km'
    }

    return this.getSelectedStore().address
  }

  private getSpecText(item: CartProductInfo): string {
    return buildSpecText(item.category, item.temperature, item.sugar)
  }

  private getOrderProducts(): CartProductInfo[] {
    return buildCartProducts(this.cartItems)
  }

  private refreshOrderMoney(): void {
    const cartTotalInfo: CartTotal = calcCartTotal(this.cartItems)

    this.cartCount = cartTotalInfo.count
    this.cartTotal = cartTotalInfo.total
  }

  private getRealCouponMoney(): number {
    if (this.selectedCouponMoney <= 0) {
      return 0
    }

    if (this.selectedCouponLimit > 0 && this.cartTotal < this.selectedCouponLimit) {
      return 0
    }

    return this.selectedCouponMoney
  }

  private getFinalPrice(): number {
    return Math.max(this.cartTotal - this.getRealCouponMoney(), 0)
  }

  private getPickupNo(): string {
    const num: number = Date.now() % 900 + 100
    return 'A' + num.toString()
  }

  private getExpressNo(): string {
    return 'MTKD' + Date.now().toString()
  }

  private getCreateTime(): string {
    const now = new Date()
    const minuteText: string = now.getMinutes() < 10 ? '0' + now.getMinutes().toString() : now.getMinutes().toString()

    return (now.getMonth() + 1).toString() + '月' +
    now.getDate().toString() + '日 ' +
    now.getHours().toString() + ':' +
      minuteText
  }

  private getOrderProductText(): string {
    const products: CartProductInfo[] = this.getOrderProducts()
    const texts: string[] = []

    products.forEach((item: CartProductInfo) => {
      texts.push(item.name + '（' + this.getSpecText(item) + '）×' + item.count.toString())
    })

    return texts.join(' ')
  }

  private submitOrder(): void {
    if (this.cartCount === 0) {
      showToast('请先选择商品')
      return
    }

    if (this.orderType === '外卖' && this.deliveryAddress.trim().length === 0) {
      showToast('请先填写配送地址')
      return
    }

    const takeWay: string = this.getCurrentTakeWayText()
    const pickupNo: string = takeWay === '到店自取' ? this.getPickupNo() : ''
    const expressNo: string = takeWay === '外卖配送' ? this.getExpressNo() : ''

    const newOrder: PaidOrderInfo = {
      orderNo: this.orderNo,
      takeWay: takeWay,
      payWay: this.payWay,
      totalCount: this.cartCount,
      goodsMoney: this.cartTotal,
      couponMoney: this.getRealCouponMoney(),
      finalMoney: this.getFinalPrice(),
      pickupNo: pickupNo,
      expressNo: expressNo,
      productText: this.getOrderProductText(),
      createTime: this.getCreateTime()
    }

    this.paidOrders = [newOrder].concat(this.paidOrders)

    if (takeWay === '到店自取') {
      showToast('支付成功，取餐号：' + pickupNo)
    } else {
      showToast('支付成功，快递号：' + expressNo)
    }

    this.cartItems = []
    this.cartCount = 0
    this.cartTotal = 0

    this.selectedCouponMoney = 0
    this.selectedCouponTitle = ''
    this.selectedCouponLimit = 0

    router.replaceUrl({
      url: 'pages/MinePage'
    })
  }

  build() {
    Column() {
      AppTopBar({ title: '确认订单', subtitle: '请确认取餐与商品信息', rightText: '共' + this.cartCount.toString() + '件' })

      Scroll() {
        Column() {
          if (this.getOrderProducts().length === 0) {
            this.EmptyOrder()
          } else {
            this.StoreCard()
            this.TakeWayCard()
            this.OrderProductTitle()

            ForEach(this.getOrderProducts(), (item: CartProductInfo) => {
              this.OrderProductCard(item)
            }, (item: CartProductInfo) => item.id.toString() + '_' + item.temperature + '_' + item.sugar + '_' + item.count.toString())

            this.RemarkCard()
            this.PayWayCard()
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

      this.BottomSubmitBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  EmptyOrder() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('🧾')
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

      Text('暂无订单商品')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .margin({ top: 26 })

      Text('请先去菜单选择你喜欢的商品')
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
  StoreCard() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('☕')
          .fontSize(26)
      }
      .width(54)
      .height(54)
      .borderRadius(27)
      .backgroundColor('#F6E5D2')

      Column() {
        Text('Milk Tea 高级奶茶店')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text('订单编号：' + this.orderNo)
          .fontSize(13)
          .fontColor('#9A7B60')
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .margin({ left: 14 })
      .alignItems(HorizontalAlign.Start)

      Text('待支付')
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
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
  TakeWayCard() {
    Column() {
      Row() {
        Text('取餐信息')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text(this.getCurrentTakeWayText())
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#8B5E3C')
          .borderRadius(16)
      }
      .width('100%')

      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.orderType === '外卖' ? '🚚' : '🏬')
            .fontSize(24)
        }
        .width(52)
        .height(52)
        .borderRadius(26)
        .backgroundColor('#F6E5D2')

        Column() {
          Text(this.getReceiveMainText())
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.getReceiveSubText())
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 6 })
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(14)
      .margin({ top: 14 })
      .backgroundColor('#F8F4EF')
      .borderRadius(22)

      if (this.orderType === '自取') {
        this.ReceiveInfoRow('营业时间', this.getSelectedStore().openTime)
        this.ReceiveInfoRow('门店电话', this.getSelectedStore().phone)
        this.ReceiveInfoRow('距离门店', this.getSelectedStore().distance.toString() + 'km')
      } else {
        this.ReceiveInfoRow('配送地址', this.deliveryAddress.trim().length > 0 ? this.deliveryAddress : '未填写配送地址')
        this.ReceiveInfoRow('配送门店', this.getDeliveryStore().name)
        this.ReceiveInfoRow('门店地址', this.getDeliveryStore().address)
        this.ReceiveInfoRow('预计距离', this.getDeliveryStore().distance.toString() + 'km')
      }

      Text('如需修改，请返回菜单页重新选择')
        .fontSize(12)
        .fontColor('#8B5E3C')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 8, bottom: 8 })
        .margin({ top: 12 })
        .backgroundColor('#F6E5D2')
        .borderRadius(16)
        .onClick(() => {
          this.goMenu()
        })
    }
    .width('100%')
    .padding(18)
    .margin({ top: 16 })
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
  ReceiveInfoRow(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(13)
        .fontColor('#9A7B60')
        .width(72)

      Text(value)
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .margin({ top: 10 })
  }

  @Builder
  OrderProductTitle() {
    Row() {
      Text('商品明细')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .layoutWeight(1)

      Text(this.cartCount.toString() + ' 件商品')
        .fontSize(14)
        .fontColor('#8B5E3C')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .backgroundColor('#F6E5D2')
        .borderRadius(15)
    }
    .width('100%')
    .margin({ top: 26, bottom: 14 })
  }

  @Builder
  OrderProductCard(item: CartProductInfo) {
    Row() {
      Image(item.image)
        .width(76)
        .height(76)
        .objectFit(ImageFit.Cover)
        .borderRadius(18)

      Column() {
        Row() {
          Text(item.name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text('￥' + item.price.toString())
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')
        }
        .width('100%')

        Text(this.getSpecText(item))
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text(item.category)
            .fontSize(12)
            .fontColor('#8B5E3C')
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
            .backgroundColor('#F6E5D2')
            .borderRadius(12)

          Blank()

          Text('x' + item.count.toString())
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
        }
        .width('100%')
        .margin({ top: 8 })
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
  RemarkCard() {
    Column() {
      Text('订单备注')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')

      TextInput({
        placeholder: '例如：不要吸管、分开打包、加一份餐具',
        text: this.remark
      })
        .width('100%')
        .height(52)
        .fontSize(15)
        .fontColor('#2E2118')
        .placeholderColor('#B9A38F')
        .backgroundColor('#F8F4EF')
        .borderRadius(18)
        .padding({ left: 14, right: 14 })
        .margin({ top: 14 })
        .onChange((value: string) => {
          this.remark = value
        })
    }
    .width('100%')
    .padding(18)
    .margin({ top: 10 })
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
  PayWayCard() {
    Column() {
      Text('支付方式')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')

      this.PayWayItem('微信支付', '推荐使用，方便快捷')
      this.PayWayItem('支付宝支付', '安全支付，快速完成')
      this.PayWayItem('到店支付', '到店后再进行付款')
    }
    .width('100%')
    .padding(18)
    .margin({ top: 16 })
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
  PayWayItem(title: string, desc: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text(desc)
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 5 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        if (this.payWay === title) {
          Text('✓')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
      }
      .width(26)
      .height(26)
      .borderRadius(13)
      .backgroundColor(this.payWay === title ? '#8B5E3C' : '#F6E5D2')
    }
    .width('100%')
    .padding(14)
    .margin({ top: 12 })
    .backgroundColor('#F8F4EF')
    .borderRadius(20)
    .onClick(() => {
      this.payWay = title
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
        Column() {
          Text('优惠券')
            .fontSize(15)
            .fontColor('#7A6251')

          if (this.selectedCouponTitle !== '') {
            Text(this.selectedCouponTitle)
              .fontSize(12)
              .fontColor('#9A7B60')
              .margin({ top: 4 })
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        if (this.getRealCouponMoney() > 0) {
          Text('-￥' + this.getRealCouponMoney().toString())
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E9D52')
        } else {
          Text(this.selectedCouponMoney > 0 ? '暂不可用' : '去选择')
            .fontSize(14)
            .fontColor('#8B5E3C')
            .padding({ left: 12, right: 12, top: 5, bottom: 5 })
            .backgroundColor('#F6E5D2')
            .borderRadius(14)
        }
      }
      .width('100%')
      .margin({ top: 12 })
      .onClick(() => {
        this.goCoupon()
      })

      if (this.selectedCouponMoney > 0 && this.cartTotal < this.selectedCouponLimit) {
        Text('当前商品金额不足，满 ' + this.selectedCouponLimit.toString() + ' 元才可使用该优惠券')
          .fontSize(12)
          .fontColor('#D35400')
          .margin({ top: 8 })
          .width('100%')
      }

      Divider()
        .color('#EFE1D2')
        .margin({ top: 16, bottom: 16 })

      Row() {
        Text('实付合计')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text('￥' + this.getFinalPrice().toString())
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
      }
      .width('100%')
    }
    .width('100%')
    .padding(18)
    .margin({ top: 16 })
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
  BottomSubmitBar() {
    Row() {
      Column() {
        Text('实付')
          .fontSize(14)
          .fontColor('#8B6F58')

        Text('￥' + this.getFinalPrice().toString())
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('提交订单')
        .width(140)
        .height(50)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.cartCount === 0 ? '#C9B8A6' : '#8B5E3C')
        .borderRadius(25)
        .onClick(() => {
          this.submitOrder()
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
