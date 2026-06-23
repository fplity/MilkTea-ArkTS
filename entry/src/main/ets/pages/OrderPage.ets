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
  temperature: string
  sugar: string
}

interface OrderProductInfo {
  id: number
  name: string
  category: string
  price: number
  image: Resource
  desc: string
  count: number
  temperature: string
  sugar: string
}

interface PaidOrderInfo {
  orderNo: string
  takeWay: string
  payWay: string
  totalCount: number
  goodsMoney: number
  couponMoney: number
  finalMoney: number
  pickupNo: string
  expressNo: string
  productText: string
  createTime: string
}

interface OrderParams {
  orderType?: string
  selectedStoreId?: number
  deliveryAddress?: string
  deliveryStoreId?: number
}

interface StoreInfo {
  id: number
  name: string
  address: string
  distance: number
  latitude: number
  longitude: number
  openTime: string
  phone: string
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

const storeList: StoreInfo[] = [
  {
    id: 1,
    name: '星野奶茶 松山湖校区店',
    address: '广东科技学院松山湖校区南门附近',
    distance: 0.8,
    latitude: 22.9021,
    longitude: 113.8806,
    openTime: '09:00-22:00',
    phone: '18800010001'
  },
  {
    id: 2,
    name: '星野奶茶 大岭山店',
    address: '东莞市大岭山镇教育路88号',
    distance: 2.4,
    latitude: 22.9125,
    longitude: 113.8632,
    openTime: '10:00-22:30',
    phone: '18800010002'
  },
  {
    id: 3,
    name: '星野奶茶 松湖万科店',
    address: '东莞松山湖万科生活广场一楼',
    distance: 4.6,
    latitude: 22.9288,
    longitude: 113.8915,
    openTime: '09:30-23:00',
    phone: '18800010003'
  }
]

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
  @State takeWay: string = '到店自取'
  @State payWay: string = '微信支付'
  @State orderNo: string = 'MT20260608'

  aboutToAppear(): void {
    this.syncOrderParams()
    this.refreshOrderMoney()
    this.orderNo = 'MT' + Date.now().toString()
  }

  private goBack(): void {
    router.back()
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

    if (params !== undefined && params.orderType !== undefined) {
      this.orderType = params.orderType
    }

    if (params !== undefined && params.selectedStoreId !== undefined) {
      this.selectedStoreId = Number(params.selectedStoreId)
    }

    if (params !== undefined && params.deliveryAddress !== undefined) {
      this.deliveryAddress = params.deliveryAddress
    }

    if (params !== undefined && params.deliveryStoreId !== undefined) {
      this.deliveryStoreId = Number(params.deliveryStoreId)
    }

    if (this.orderType === '外卖') {
      this.takeWay = '外卖配送'
    } else {
      this.takeWay = '到店自取'
    }
  }

  private getStoreById(id: number): StoreInfo | undefined {
    return storeList.find((item: StoreInfo) => item.id === id)
  }

  private getSelectedStore(): StoreInfo {
    const store = this.getStoreById(this.selectedStoreId)
    if (store !== undefined) {
      return store
    }

    return storeList[0]
  }

  private getDeliveryStore(): StoreInfo {
    const store = this.getStoreById(this.deliveryStoreId)
    if (store !== undefined) {
      return store
    }

    return storeList[0]
  }

  private getCurrentTakeWayText(): string {
    if (this.orderType === '外卖') {
      return '外卖配送'
    }

    return '到店自取'
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

  private getProductById(id: number): ProductInfo | undefined {
    return productList.find((item: ProductInfo) => item.id === id)
  }

  private getSpecText(item: OrderProductInfo): string {
    if (item.category === '甜品') {
      return '默认规格'
    }

    return item.temperature + ' / ' + item.sugar
  }

  private getOrderProducts(): OrderProductInfo[] {
    const result: OrderProductInfo[] = []

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
          count: cartItem.count,
          temperature: cartItem.temperature,
          sugar: cartItem.sugar
        })
      }
    })

    return result
  }

  private refreshOrderMoney(): void {
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
    let finalPrice: number = this.cartTotal - this.getRealCouponMoney()

    if (finalPrice < 0) {
      return 0
    }

    return finalPrice
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
    const products: OrderProductInfo[] = this.getOrderProducts()
    let text: string = ''

    products.forEach((item: OrderProductInfo, index: number) => {
      if (index < 2) {
        if (text !== '') {
          text += '，'
        }

        text += item.name + ' x' + item.count.toString()
      }
    })

    if (products.length > 2) {
      text += ' 等' + this.cartCount.toString() + '件'
    }

    return text
  }

  private submitOrder(): void {
    if (this.orderType === '外卖') {
      this.takeWay = '外卖配送'
    } else {
      this.takeWay = '到店自取'
    }

    if (this.cartCount === 0) {
      promptAction.showToast({
        message: '请先选择商品'
      })
      return
    }

    if (this.orderType === '外卖' && this.deliveryAddress.trim().length === 0) {
      promptAction.showToast({
        message: '请先填写配送地址'
      })
      return
    }

    const pickupNo: string = this.takeWay === '到店自取' ? this.getPickupNo() : ''
    const expressNo: string = this.takeWay === '外卖配送' ? this.getExpressNo() : ''

    const newOrder: PaidOrderInfo = {
      orderNo: this.orderNo,
      takeWay: this.takeWay,
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

    const newPaidOrders: PaidOrderInfo[] = [newOrder]

    this.paidOrders.forEach((item: PaidOrderInfo) => {
      newPaidOrders.push(item)
    })

    this.paidOrders = newPaidOrders

    if (this.takeWay === '到店自取') {
      promptAction.showToast({
        message: '支付成功，取餐号：' + pickupNo
      })
    } else {
      promptAction.showToast({
        message: '支付成功，快递号：' + expressNo
      })
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
          Text('确认订单')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text('请确认取餐与商品信息')
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
          if (this.getOrderProducts().length === 0) {
            this.EmptyOrder()
          } else {
            this.StoreCard()
            this.TakeWayCard()
            this.OrderProductTitle()

            ForEach(this.getOrderProducts(), (item: OrderProductInfo) => {
              this.OrderProductCard(item)
            }, (item: OrderProductInfo) => {
              return item.id.toString() + '_' + item.temperature + '_' + item.sugar + '_' + item.count.toString()
            })

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
  TakeWayItem(title: string, desc: string) {
    Column() {
      Text(title)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.takeWay === title ? '#FFFFFF' : '#2E2118')

      Text(desc)
        .fontSize(11)
        .fontColor(this.takeWay === title ? '#F7E6D3' : '#9A7B60')
        .margin({ top: 6 })
        .maxLines(2)
    }
    .layoutWeight(1)
    .height(90)
    .padding(14)
    .margin({ right: title === '到店自取' ? 10 : 0 })
    .backgroundColor(this.takeWay === title ? '#8B5E3C' : '#F8F4EF')
    .borderRadius(22)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .onClick(() => {
      this.takeWay = title
    })
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
  OrderProductCard(item: OrderProductInfo) {
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