import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

interface MenuParams {
  category?: string
  productId?: number
}

interface CategoryInfo {
  id: number
  name: string
}

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

interface CartProductInfo {
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

interface StoreInfo {
  id: number
  name: string
  address: string
  distance: number
  latitude: number
  longitude: number
  openTime: string
  phone: string
  mapImage: Resource
}

const categoryList: CategoryInfo[] = [
  { id: 1, name: '奶茶' },
  { id: 2, name: '咖啡' },
  { id: 3, name: '甜品' },
  { id: 4, name: '果茶' }
]

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
    phone: '18800010001',
    mapImage: $r('app.media.map_store1')
  },
  {
    id: 2,
    name: '星野奶茶 大岭山店',
    address: '东莞市大岭山镇教育路88号',
    distance: 2.4,
    latitude: 22.9125,
    longitude: 113.8632,
    openTime: '10:00-22:30',
    phone: '18800010002',
    mapImage: $r('app.media.map_store2')
  },
  {
    id: 3,
    name: '星野奶茶 松湖万科店',
    address: '东莞松山湖万科生活广场一楼',
    distance: 4.6,
    latitude: 22.9288,
    longitude: 113.8915,
    openTime: '09:30-23:00',
    phone: '18800010003',
    mapImage: $r('app.media.map_store3')
  }
]

@Entry
@Component
struct MenuPage {
  @State currentCategory: string = '奶茶'
  @State showCartSheet: boolean = false
  @State showSpecSheet: boolean = false
  @State showStoreSheet: boolean = false
  @State orderPanelCollapsed: boolean = false
  @State selectedProductId: number = 1
  @State selectedCount: number = 1
  @State selectedTemperature: string = '正常冰'
  @State selectedSugar: string = '正常糖'

  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  @StorageLink('orderType') orderType: string = '自取'
  @StorageLink('selectedStoreId') selectedStoreId: number = 1
  @StorageLink('deliveryAddress') deliveryAddress: string = ''
  @StorageLink('deliveryStoreId') deliveryStoreId: number = 1

  private temperatureList: string[] = ['正常冰', '少冰', '去冰', '常温', '热']
  private sugarList: string[] = ['正常糖', '七分糖', '五分糖', '三分糖', '无糖']

  aboutToAppear(): void {
    const params = router.getParams() as MenuParams

    if (params && params.category !== undefined) {
      if (params.category === 'milkTea') {
        this.currentCategory = '奶茶'
      } else if (params.category === 'coffee') {
        this.currentCategory = '咖啡'
      } else if (params.category === 'dessert') {
        this.currentCategory = '甜品'
      } else if (params.category === 'fruitTea') {
        this.currentCategory = '果茶'
      }
    }

    if (params && params.productId !== undefined) {
      const product = this.getProductById(Number(params.productId))

      if (product !== undefined) {
        this.currentCategory = product.category
        this.openSpecSheet(product)
      }
    }

    this.deliveryStoreId = this.getNearestStore().id
    this.refreshCartMoney()
  }

  private getCurrentProducts(): ProductInfo[] {
    return productList.filter((item: ProductInfo) => item.category === this.currentCategory)
  }

  private getProductById(id: number): ProductInfo | undefined {
    return productList.find((item: ProductInfo) => item.id === id)
  }

  private getSelectedProduct(): ProductInfo {
    const product = this.getProductById(this.selectedProductId)
    if (product !== undefined) {
      return product
    }
    return productList[0]
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
    return this.getNearestStore()
  }

  private getNearestStore(): StoreInfo {
    let nearestStore: StoreInfo = storeList[0]

    storeList.forEach((item: StoreInfo) => {
      if (item.distance < nearestStore.distance) {
        nearestStore = item
      }
    })

    return nearestStore
  }

  private getCompactDeliveryText(): string {
    if (this.deliveryAddress.trim().length > 0) {
      return this.deliveryAddress
    }

    return '填写配送地址'
  }

  private changeOrderType(type: string): void {
    this.orderType = type

    if (type === '外卖') {
      this.deliveryStoreId = this.getNearestStore().id
      this.orderPanelCollapsed = false
    } else {
      this.orderPanelCollapsed = true
    }
  }
  private chooseStore(item: StoreInfo): void {
    this.selectedStoreId = item.id
    this.orderPanelCollapsed = true

    promptAction.showToast({
      message: '已选择 ' + item.name
    })
  }

  private closeStoreSheet(): void {
    this.showStoreSheet = false
    this.orderPanelCollapsed = true
  }

  private isDessert(item: ProductInfo): boolean {
    return item.category === '甜品'
  }

  private goHome(): void {
    router.replaceUrl({
      url: 'pages/HomePage'
    })
  }

  private goDetail(item: ProductInfo): void {
    this.orderPanelCollapsed = true
    this.showSpecSheet = false

    router.pushUrl({
      url: 'pages/DetailPage',
      params: {
        id: item.id
      }
    }).catch(() => {
      promptAction.showToast({
        message: '详情页跳转失败，请检查 DetailPage 是否注册'
      })
    })
  }

  private openSpecSheet(item: ProductInfo): void {
    this.orderPanelCollapsed = true
    this.selectedProductId = item.id
    this.selectedCount = 1

    if (this.isDessert(item)) {
      this.selectedTemperature = '默认'
      this.selectedSugar = '默认'
    } else {
      this.selectedTemperature = '正常冰'
      this.selectedSugar = '正常糖'
    }

    this.showSpecSheet = true
  }

  private closeSpecSheet(): void {
    this.showSpecSheet = false
  }

  private addSelectedCount(): void {
    this.selectedCount++
  }

  private reduceSelectedCount(): void {
    if (this.selectedCount > 1) {
      this.selectedCount--
    }
  }

  private getProductTotalCount(id: number): number {
    let count: number = 0

    this.cartItems.forEach((item: CartItemInfo) => {
      if (item.id === id && item.count > 0) {
        count += item.count
      }
    })

    return count
  }

  private getSpecText(item: CartProductInfo): string {
    if (item.category === '甜品') {
      return '默认规格'
    }
    return item.temperature + ' / ' + item.sugar
  }

  private getSelectedSpecText(): string {
    const product = this.getSelectedProduct()

    if (product.category === '甜品') {
      return '默认规格'
    }

    return this.selectedTemperature + ' / ' + this.selectedSugar
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
          count: cartItem.count,
          temperature: cartItem.temperature,
          sugar: cartItem.sugar
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

  private addCartWithSpec(): void {
    const product = this.getSelectedProduct()
    let hasItem: boolean = false
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((item: CartItemInfo) => {
      if (
        item.id === product.id &&
          item.temperature === this.selectedTemperature &&
          item.sugar === this.selectedSugar
      ) {
        hasItem = true
        newCartItems.push({
          id: item.id,
          count: item.count + this.selectedCount,
          temperature: item.temperature,
          sugar: item.sugar
        })
      } else {
        newCartItems.push(item)
      }
    })

    if (!hasItem) {
      newCartItems.push({
        id: product.id,
        count: this.selectedCount,
        temperature: this.selectedTemperature,
        sugar: this.selectedSugar
      })
    }

    this.cartItems = newCartItems
    this.refreshCartMoney()
    this.showSpecSheet = false
    this.orderPanelCollapsed = true

    promptAction.showToast({
      message: product.name + ' 已加入购物车'
    })
  }

  private addCartItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (
        cartItem.id === item.id &&
          cartItem.temperature === item.temperature &&
          cartItem.sugar === item.sugar
      ) {
        newCartItems.push({
          id: cartItem.id,
          count: cartItem.count + 1,
          temperature: cartItem.temperature,
          sugar: cartItem.sugar
        })
      } else {
        newCartItems.push(cartItem)
      }
    })

    this.cartItems = newCartItems
    this.refreshCartMoney()
  }

  private reduceCartItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (
        cartItem.id === item.id &&
          cartItem.temperature === item.temperature &&
          cartItem.sugar === item.sugar
      ) {
        if (cartItem.count > 1) {
          newCartItems.push({
            id: cartItem.id,
            count: cartItem.count - 1,
            temperature: cartItem.temperature,
            sugar: cartItem.sugar
          })
        }
      } else {
        newCartItems.push(cartItem)
      }
    })

    this.cartItems = newCartItems
    this.refreshCartMoney()
  }

  private deleteCartItem(item: CartProductInfo): void {
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((cartItem: CartItemInfo) => {
      if (
        cartItem.id !== item.id ||
          cartItem.temperature !== item.temperature ||
          cartItem.sugar !== item.sugar
      ) {
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

  private getCartSheetHeight(): string {
    const typeCount: number = this.getCartProducts().length

    if (typeCount <= 0) {
      return '34%'
    }

    if (typeCount === 1) {
      return '42%'
    }

    if (typeCount === 2) {
      return '52%'
    }

    if (typeCount === 3) {
      return '62%'
    }

    return '75%'
  }

  private checkout(): void {
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

    if (this.orderType === '外卖') {
      this.deliveryStoreId = this.getNearestStore().id
    }

    router.pushUrl({
      url: 'pages/OrderPage',
      params: {
        orderType: this.orderType,
        selectedStoreId: this.selectedStoreId,
        deliveryAddress: this.deliveryAddress,
        deliveryStoreId: this.deliveryStoreId
      }
    })
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        this.OrderTypePanel()

        Row() {
          this.CategoryList()
          this.ProductList()
        }
        .layoutWeight(1)
        .width('100%')

        this.BottomCartBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF7EC')

      if (this.showCartSheet) {
        this.CartSheetMask()
      }

      if (this.showSpecSheet) {
        this.SpecSheetMask()
      }

      if (this.showStoreSheet) {
        this.StoreSheetMask()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  TopBar() {
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
        this.goHome()
      })

      Column() {
        Text('商品菜单')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text('选择取餐方式，点击 + 选择规格')
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 2 })
      }
      .margin({ left: 14 })
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('共' + productList.length.toString() + '件')
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
  }

  @Builder
  OrderTypePanel() {
    Column() {
      if (this.orderPanelCollapsed) {
        this.CollapsedOrderPanel()
      } else {
        Row() {
          this.OrderTypeButton('自取')
          this.OrderTypeButton('外卖')
        }
        .width('100%')
        .height(44)
        .padding({ left: 18, right: 18 })

        if (this.orderType === '自取') {
          this.PickupCard()
        } else {
          this.DeliveryCard()
        }
      }
    }
    .width('100%')
    .padding({ bottom: this.orderPanelCollapsed ? 2 : 10 })
    .backgroundColor('#FFF7EC')
  }

  @Builder
  CollapsedOrderPanel() {
    Column() {
      Row() {
        Row() {
          this.CompactOrderTypeButton('自取')
          this.CompactOrderTypeButton('外卖')
        }
        .width(126)
        .height(36)
        .padding(3)
        .backgroundColor('#F6E5D2')
        .borderRadius(18)

        Blank()

        Text(this.orderType === '自取' ? this.getSelectedStore().distance.toString() + 'km' : '修改地址')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8B5E3C')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#F6E5D2')
          .borderRadius(14)
      }
      .width('100%')
      .height(38)

      Row() {
        Text('▣')
          .fontSize(15)
          .fontColor('#8B5E3C')
          .margin({ right: 8 })

        Column() {
          Text(this.orderType === '自取' ? this.getSelectedStore().name : this.getCompactDeliveryText())
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.orderType === '自取' ? this.getSelectedStore().address : '由最近门店配送')
            .fontSize(11)
            .fontColor('#9A7B60')
            .margin({ top: 2 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('›')
          .fontSize(22)
          .fontColor('#8B5E3C')
          .margin({ left: 8 })
      }
      .width('100%')
      .height(46)
      .padding({ left: 12, right: 10 })
      .margin({ top: 6 })
      .backgroundColor('#FFFFFF')
      .borderRadius(18)
      .shadow({
        radius: 8,
        color: '#10000000',
        offsetX: 0,
        offsetY: 3
      })
      .onClick(() => {
        this.orderPanelCollapsed = false
      })
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 4, bottom: 6 })
    .backgroundColor('#FFF7EC')
  }
  @Builder
  CompactOrderTypeButton(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(this.orderType === title ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.orderType === title ? '#FFFFFF' : '#8B5E3C')
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height(30)
      .backgroundColor(this.orderType === title ? '#8B5E3C' : '#00FFFFFF')
      .borderRadius(15)
      .onClick(() => {
        this.changeOrderType(title)
      })
  }

  @Builder
  OrderTypeButton(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(this.orderType === title ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.orderType === title ? '#FFFFFF' : '#8B5E3C')
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height(40)
      .backgroundColor(this.orderType === title ? '#8B5E3C' : '#F6E5D2')
      .borderRadius(20)
      .margin({ right: title === '自取' ? 10 : 0 })
      .onClick(() => {
        this.changeOrderType(title)
      })
  }

  @Builder
  PickupCard() {
    Column() {
      Row() {
        Column() {
          Text('到店自取')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text(this.getSelectedStore().name)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B5E3C')
            .margin({ top: 5 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.getSelectedStore().address)
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 4 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('切换门店')
          .fontSize(13)
          .fontColor('#FFFFFF')
          .padding({ left: 12, right: 12, top: 7, bottom: 7 })
          .backgroundColor('#8B5E3C')
          .borderRadius(16)
          .onClick(() => {
            this.showStoreSheet = true
          })
      }
      .width('100%')

      this.MapPreview(this.getSelectedStore())
    }
    .width('100%')
    .padding(14)
    .margin({ left: 18, right: 18, top: 10 })
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  DeliveryCard() {
    Column() {
      Text('外卖配送')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .width('100%')

      TextInput({
        placeholder: '请输入配送地址，例如：广东科技学院宿舍区',
        text: this.deliveryAddress
      })
        .width('100%')
        .height(46)
        .fontSize(14)
        .fontColor('#2E2118')
        .placeholderColor('#B8A28C')
        .backgroundColor('#F8F4EF')
        .borderRadius(18)
        .margin({ top: 10 })
        .onChange((value: string) => {
          this.deliveryAddress = value
          this.deliveryStoreId = this.getNearestStore().id
        })

      Row() {
        Column() {
          Text('最近配送门店')
            .fontSize(13)
            .fontColor('#9A7B60')

          Text(this.getDeliveryStore().name)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B5E3C')
            .margin({ top: 4 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text('预计距离 ' + this.getDeliveryStore().distance.toString() + 'km，由最近门店配送')
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('>')
          .fontSize(22)
          .fontColor('#8B5E3C')
      }
      .width('100%')
      .margin({ top: 12 })

      this.MapPreview(this.getDeliveryStore())
    }
    .width('100%')
    .padding(14)
    .margin({ left: 18, right: 18, top: 10 })
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  MapPreview(store: StoreInfo) {
    Column() {
      Row() {
        Text('地图预览')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text(store.distance.toString() + 'km')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#D35400')
          .borderRadius(12)
      }
      .width('100%')

      Stack() {
        Image(store.mapImage)
          .width('100%')
          .height(112)
          .objectFit(ImageFit.Cover)
          .borderRadius(18)

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(26)
            .height(26)
            .fill('#F7E7D6')
            .opacity(0.9)
            .shadow({
              radius: 8,
              color: '#22000000',
              offsetX: 0,
              offsetY: 3
            })

          Circle()
            .width(16)
            .height(16)
            .fill('#A35F2D')
        }
        .width(30)
        .height(30)
        .position({ x: 145, y: 30 })

        Text(store.name)
          .fontSize(12)
          .fontColor('#6B4F3A')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#FDF7EF')
          .borderRadius(12)
          .position({ x: 82, y: 70 })

        Text(store.distance.toString() + 'km')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor('#8B5E3C')
          .borderRadius(14)
          .position({ x: 260, y: 76 })
      }
      .width('100%')
      .height(112)
      .margin({ top: 8 })
      .borderRadius(18)
      .clip(true)
    }
    .width('100%')
    .margin({ top: 12 })
  }

  @Builder
  CategoryList() {
    Column() {
      ForEach(categoryList, (item: CategoryInfo) => {
        Column() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(this.currentCategory === item.name ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentCategory === item.name ? '#FFFFFF' : '#6B4F3A')
        }
        .width('100%')
        .height(58)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.currentCategory === item.name ? '#8B5E3C' : '#F6E5D2')
        .borderRadius(18)
        .margin({ bottom: 12 })
        .onClick(() => {
          this.orderPanelCollapsed = true
          this.currentCategory = item.name
        })
      }, (item: CategoryInfo) => item.id.toString())
    }
    .width(98)
    .height('100%')
    .padding({ left: 12, right: 10, top: 14 })
    .backgroundColor('#FFF7EC')
  }

  @Builder
  ProductList() {
    Scroll() {
      Column() {
        ForEach(this.getCurrentProducts(), (item: ProductInfo) => {
          this.ProductCard(item)
        }, (item: ProductInfo) => item.id.toString())

        Blank()
          .height(20)
      }
      .width('100%')
      .padding({ left: 8, right: 14, top: 14 })
    }
    .layoutWeight(1)
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  ProductCard(item: ProductInfo) {
    Row() {
      Image(item.image)
        .width(92)
        .height(92)
        .objectFit(ImageFit.Cover)
        .borderRadius(18)
        .onClick(() => {
          this.goDetail(item)
        })

      Column() {
        Row() {
          Text(item.name)
            .fontSize(17)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)

          if (this.getProductTotalCount(item.id) > 0) {
            Text('已选' + this.getProductTotalCount(item.id).toString())
              .fontSize(11)
              .fontColor('#FFFFFF')
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor('#8B5E3C')
              .borderRadius(12)
          }
        }
        .width('100%')

        Text(item.desc)
          .fontSize(12)
          .fontColor('#7A6251')
          .margin({ top: 5 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Text('￥' + item.price.toString())
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')
            .layoutWeight(1)

          Stack({ alignContent: Alignment.Center }) {
            Text('+')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#8B5E3C')
          .onClick(() => {
            this.openSpecSheet(item)
          })
        }
        .width('100%')
        .margin({ top: 14 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        this.goDetail(item)
      })
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    .margin({ bottom: 14 })
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 10,
      color: '#14000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  BottomCartBar() {
    Row() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.shopping'))
            .width(30)
            .height(30)
            .objectFit(ImageFit.Contain)

          if (this.cartCount > 0) {
            Text(this.cartCount.toString())
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .width(18)
              .height(18)
              .textAlign(TextAlign.Center)
              .backgroundColor('#D35400')
              .borderRadius(9)
              .position({ x: 28, y: -4 })
          }
        }
        .width(50)
        .height(50)
        .borderRadius(25)
        .backgroundColor('#F6E5D2')

        Column() {
          Text('购物车')
            .fontSize(13)
            .fontColor('#6B4F3A')

          Text('已选 ' + this.cartCount.toString() + ' 件')
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .margin({ top: 3 })
        }
        .margin({ left: 10 })
        .alignItems(HorizontalAlign.Start)
      }
      .onClick(() => {
        this.showCartSheet = true
      })

      Blank()

      Column() {
        Text('合计')
          .fontSize(12)
          .fontColor('#8B6F58')

        Text('￥' + this.cartTotal.toString())
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.End)
      .margin({ right: 12 })

      Button('去结算')
        .width(112)
        .height(46)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.cartCount === 0 ? '#C9B8A6' : '#8B5E3C')
        .borderRadius(23)
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

  @Builder
  StoreSheetMask() {
    Column() {
      Blank()
        .layoutWeight(1)
        .onClick(() => {
          this.closeStoreSheet()
        })

      this.StoreSheet()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#66000000')
  }

  @Builder
  StoreSheet() {
    Column() {
      Row() {
        Text('选择自取门店')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text('×')
          .fontSize(26)
          .fontColor('#8B6F58')
          .onClick(() => {
            this.closeStoreSheet()
          })
      }
      .width('100%')
      .margin({ bottom: 14 })

      Scroll() {
        Column() {
          ForEach(storeList, (item: StoreInfo) => {
            this.StoreItem(item)
          }, (item: StoreInfo) => item.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('72%')
    .padding({ left: 18, right: 18, top: 20, bottom: 18 })
    .backgroundColor('#FFF7EC')
    .borderRadius({ topLeft: 30, topRight: 30 })
  }

  @Builder
  StoreItem(item: StoreInfo) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          if (this.selectedStoreId === item.id) {
            Circle()
              .width(20)
              .height(20)
              .fill('#F7E7D6')
              .border({
                width: 1,
                color: '#8B5E3C'
              })

            Circle()
              .width(10)
              .height(10)
              .fill('#8B5E3C')
          } else {
            Circle()
              .width(20)
              .height(20)
              .fill('#FFFFFF')
              .border({
                width: 1,
                color: '#C9B8A6'
              })
          }
        }
        .width(30)
        .height(30)
        .margin({ right: 8 })
        .onClick(() => {
          this.chooseStore(item)
        })

        Column() {
          Row() {
            Text(item.name)
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E2118')
              .layoutWeight(1)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            if (this.selectedStoreId === item.id) {
              Text('已选')
                .fontSize(11)
                .fontColor('#FFFFFF')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .backgroundColor('#8B5E3C')
                .borderRadius(12)
            }
          }
          .width('100%')

          Text(item.address)
            .fontSize(13)
            .fontColor('#9A7B60')
            .margin({ top: 6 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text('营业时间：' + item.openTime + ' ｜ 距离 ' + item.distance.toString() + 'km')
            .fontSize(12)
            .fontColor('#8B6F58')
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      this.MapPreview(item)

      Text(this.selectedStoreId === item.id ? '当前门店' : '选择该门店')
        .width('100%')
        .height(42)
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.selectedStoreId === item.id ? '#C9B8A6' : '#8B5E3C')
        .borderRadius(21)
        .margin({ top: 12 })
        .onClick(() => {
          this.chooseStore(item)
        })
    }
    .width('100%')
    .padding(14)
    .margin({ bottom: 14 })
    .backgroundColor(this.selectedStoreId === item.id ? '#FFF3E5' : '#FFFFFF')
    .borderRadius(22)
    .border({
      width: 1,
      color: this.selectedStoreId === item.id ? '#E0B98E' : '#00FFFFFF'
    })
    .shadow({
      radius: 8,
      color: '#10000000',
      offsetX: 0,
      offsetY: 3
    })
    .onClick(() => {
      this.chooseStore(item)
    })
  }

  @Builder
  SpecSheetMask() {
    Column() {
      Blank()
        .layoutWeight(1)
        .onClick(() => {
          this.closeSpecSheet()
        })

      this.SpecSheet()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#66000000')
  }

  @Builder
  SpecSheet() {
    Column() {
      Row() {
        Text('选择规格')
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text('×')
          .fontSize(26)
          .fontColor('#8B6F58')
          .onClick(() => {
            this.closeSpecSheet()
          })
      }
      .width('100%')
      .margin({ bottom: 16 })

      Row() {
        Image(this.getSelectedProduct().image)
          .width(88)
          .height(88)
          .objectFit(ImageFit.Cover)
          .borderRadius(20)

        Column() {
          Text(this.getSelectedProduct().name)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.getSelectedProduct().desc)
            .fontSize(13)
            .fontColor('#9A7B60')
            .margin({ top: 6 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Row() {
            Text('￥' + this.getSelectedProduct().price.toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#D35400')
              .layoutWeight(1)

            Text('查看详情 >')
              .fontSize(12)
              .fontColor('#8B5E3C')
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
      .backgroundColor('#F8F4EF')
      .borderRadius(22)
      .onClick(() => {
        this.goDetail(this.getSelectedProduct())
      })

      if (this.getSelectedProduct().category !== '甜品') {
        Text('温度')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ top: 18 })
          .width('100%')

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.temperatureList, (item: string) => {
            this.TemperatureChip(item)
          }, (item: string) => item)
        }
        .width('100%')
        .margin({ top: 10 })

        Text('糖度')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ top: 18 })
          .width('100%')

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.sugarList, (item: string) => {
            this.SugarChip(item)
          }, (item: string) => item)
        }
        .width('100%')
        .margin({ top: 10 })
      } else {
        Text('甜品无需选择温度和糖度')
          .fontSize(14)
          .fontColor('#9A7B60')
          .width('100%')
          .padding(14)
          .margin({ top: 18 })
          .backgroundColor('#F8F4EF')
          .borderRadius(18)
      }

      Row() {
        Column() {
          Text('数量')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text(this.getSelectedSpecText())
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 5 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Stack({ alignContent: Alignment.Center }) {
          Text('－')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B5E3C')
        }
        .width(34)
        .height(34)
        .borderRadius(17)
        .backgroundColor('#F6E5D2')
        .onClick(() => {
          this.reduceSelectedCount()
        })

        Text(this.selectedCount.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ left: 14, right: 14 })

        Stack({ alignContent: Alignment.Center }) {
          Text('＋')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(34)
        .height(34)
        .borderRadius(17)
        .backgroundColor('#8B5E3C')
        .onClick(() => {
          this.addSelectedCount()
        })
      }
      .width('100%')
      .margin({ top: 20 })

      Button('加入购物车')
        .width('100%')
        .height(52)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#8B5E3C')
        .borderRadius(26)
        .margin({ top: 22 })
        .onClick(() => {
          this.addCartWithSpec()
        })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 22, bottom: 22 })
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 30, topRight: 30 })
  }

  @Builder
  TemperatureChip(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(this.selectedTemperature === title ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.selectedTemperature === title ? '#FFFFFF' : '#6B4F3A')
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
      .margin({ right: 10, bottom: 10 })
      .backgroundColor(this.selectedTemperature === title ? '#8B5E3C' : '#F6E5D2')
      .borderRadius(18)
      .onClick(() => {
        this.selectedTemperature = title
      })
  }

  @Builder
  SugarChip(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(this.selectedSugar === title ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.selectedSugar === title ? '#FFFFFF' : '#6B4F3A')
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
      .margin({ right: 10, bottom: 10 })
      .backgroundColor(this.selectedSugar === title ? '#8B5E3C' : '#F6E5D2')
      .borderRadius(18)
      .onClick(() => {
        this.selectedSugar = title
      })
  }

  @Builder
  CartSheetMask() {
    Column() {
      Blank()
        .layoutWeight(1)
        .onClick(() => {
          this.showCartSheet = false
        })

      this.CartSheet()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#66000000')
  }

  @Builder
  CartSheet() {
    Column() {
      Row() {
        Text('购物车')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        if (this.cartCount > 0) {
          Text('清空')
            .fontSize(14)
            .fontColor('#A36A3C')
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor('#F6E5D2')
            .borderRadius(15)
            .margin({ right: 12 })
            .onClick(() => {
              this.clearCart()
            })
        }

        Text('×')
          .fontSize(26)
          .fontColor('#8B6F58')
          .onClick(() => {
            this.showCartSheet = false
          })
      }
      .width('100%')
      .margin({ bottom: 14 })

      if (this.getCartProducts().length === 0) {
        this.EmptyCartInSheet()
      } else {
        Scroll() {
          Column() {
            ForEach(this.getCartProducts(), (item: CartProductInfo) => {
              this.CartSheetItem(item)
            }, (item: CartProductInfo) => {
              return item.id.toString() + '_' + item.temperature + '_' + item.sugar + '_' + item.count.toString()
            })
          }
          .width('100%')
        }
        .layoutWeight(1)

        this.CartSheetBottom()
      }
    }
    .width('100%')
    .height(this.getCartSheetHeight())
    .padding({ left: 18, right: 18, top: 20, bottom: 18 })
    .backgroundColor('#FFF7EC')
    .borderRadius({ topLeft: 30, topRight: 30 })
  }

  @Builder
  EmptyCartInSheet() {
    Column() {
      Text('🛒')
        .fontSize(44)

      Text('购物车空空的')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .margin({ top: 16 })

      Text('先选择喜欢的奶茶、咖啡或甜品吧')
        .fontSize(13)
        .fontColor('#9A7B60')
        .margin({ top: 8 })
    }
    .width('100%')
    .height(190)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  CartSheetItem(item: CartProductInfo) {
    Row() {
      Image(item.image)
        .width(72)
        .height(72)
        .objectFit(ImageFit.Cover)
        .borderRadius(18)

      Column() {
        Row() {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text('￥' + item.price.toString())
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')
        }
        .width('100%')

        Text(this.getSpecText(item))
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 5 })

        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Text('－')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8B5E3C')
          }
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#F6E5D2')
          .onClick(() => {
            this.reduceCartItem(item)
          })

          Text(item.count.toString())
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .margin({ left: 12, right: 12 })

          Stack({ alignContent: Alignment.Center }) {
            Text('＋')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .width(30)
          .height(30)
          .borderRadius(15)
          .backgroundColor('#8B5E3C')
          .onClick(() => {
            this.addCartItem(item)
          })

          Blank()

          Text('删除')
            .fontSize(12)
            .fontColor('#B65A3A')
            .onClick(() => {
              this.deleteCartItem(item)
            })
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(12)
    .margin({ bottom: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .shadow({
      radius: 8,
      color: '#10000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  CartSheetBottom() {
    Row() {
      Column() {
        Text('合计 ' + this.cartCount.toString() + ' 件')
          .fontSize(13)
          .fontColor('#8B6F58')

        Text('￥' + this.cartTotal.toString())
          .fontSize(27)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('去结算')
        .width(132)
        .height(48)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor(this.cartCount === 0 ? '#C9B8A6' : '#8B5E3C')
        .borderRadius(24)
        .onClick(() => {
          this.checkout()
        })
    }
    .width('100%')
    .height(72)
    .margin({ top: 10 })
  }
}