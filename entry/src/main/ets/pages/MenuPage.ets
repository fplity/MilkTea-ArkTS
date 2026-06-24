import router from '@ohos.router'
import { AppTopBar } from '../common/AppTopBar'
import {
  ProductInfo,
  productList,
  getCategoryName,
  getProductById,
  getProductByIdOrFirst,
  getProductsByCategory
} from '../common/ProductData'
import { StoreInfo, storeList, getNearestStore, getStoreByIdOrFirst, getStoreByIdOrNearest } from '../common/StoreData'
import {
  addCartItem,
  CartItemInfo,
  CartProductInfo,
  DEFAULT_SUGAR,
  DEFAULT_TEMPERATURE,
  deleteCartItem as removeCartItem,
  getDefaultSpec,
  getCartProductKey,
  getCartProducts as buildCartProducts,
  getProductTotalCount as calcProductTotalCount,
  refreshCartState,
  updateCartItemCount,
  getSpecText,
  isDessertCategory,
  sugarList,
  temperatureList
} from '../common/CartUtils'
import { showToast } from '../common/AppToast'

interface MenuParams {
  category?: string
  productId?: number
}

const categoryList: string[] = ['奶茶', '咖啡', '甜品', '果茶']

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
  @State selectedTemperature: string = DEFAULT_TEMPERATURE
  @State selectedSugar: string = DEFAULT_SUGAR

  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  @StorageLink('orderType') orderType: string = '自取'
  @StorageLink('selectedStoreId') selectedStoreId: number = 1
  @StorageLink('deliveryAddress') deliveryAddress: string = ''
  @StorageLink('deliveryStoreId') deliveryStoreId: number = 1

  aboutToAppear(): void {
    const params = router.getParams() as MenuParams

    if (params !== undefined) {
      if (params.category !== undefined) {
        this.currentCategory = getCategoryName(params.category)
      }

      if (params.productId !== undefined) {
        const product: ProductInfo | undefined = getProductById(Number(params.productId))
        if (product !== undefined) {
          this.currentCategory = product.category
          this.openSpecSheet(product)
        }
      }
    }

    this.deliveryStoreId = getNearestStore().id
    refreshCartState(this, this.cartItems)
  }

  private getCurrentProducts(): ProductInfo[] {
    return getProductsByCategory(this.currentCategory)
  }

  private getSelectedProduct(): ProductInfo {
    return getProductByIdOrFirst(this.selectedProductId)
  }

  private getSelectedStore(): StoreInfo {
    return getStoreByIdOrFirst(this.selectedStoreId)
  }

  private getDeliveryStore(): StoreInfo {
    return getStoreByIdOrNearest(this.deliveryStoreId)
  }

  private getCompactDeliveryText(): string {
    return this.deliveryAddress.trim().length > 0 ? this.deliveryAddress : '填写配送地址'
  }

  private getCartProducts(): CartProductInfo[] {
    return buildCartProducts(this.cartItems)
  }

  private getSelectedSpecText(): string {
    const product = this.getSelectedProduct()
    return getSpecText(product.category, this.selectedTemperature, this.selectedSugar)
  }

  private getProductTotalCount(id: number): number {
    return calcProductTotalCount(this.cartItems, id)
  }

  private changeOrderType(type: string): void {
    this.orderType = type

    if (type === '外卖') {
      this.deliveryStoreId = getNearestStore().id
      this.orderPanelCollapsed = false
    } else {
      this.orderPanelCollapsed = true
    }
  }

  private chooseStore(item: StoreInfo): void {
    this.selectedStoreId = item.id
    this.showStoreSheet = false
    this.orderPanelCollapsed = true

    showToast('已选择 ' + item.name)
  }

  private closeSheet(type: string): void {
    if (type === 'cart') {
      this.showCartSheet = false
    } else if (type === 'spec') {
      this.showSpecSheet = false
    } else if (type === 'store') {
      this.showStoreSheet = false
      this.orderPanelCollapsed = true
    }
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
      showToast('详情页跳转失败，请检查 DetailPage 是否注册')
    })
  }

  private openSpecSheet(item: ProductInfo): void {
    this.orderPanelCollapsed = true
    this.selectedProductId = item.id
    this.selectedCount = 1
    const spec = getDefaultSpec(item.category)
    this.selectedTemperature = spec.temperature
    this.selectedSugar = spec.sugar

    this.showSpecSheet = true
  }

  private changeSelectedCount(type: string): void {
    this.selectedCount = Math.max(1, this.selectedCount + (type === 'add' ? 1 : -1))
  }

  private addCartWithSpec(): void {
    const product = this.getSelectedProduct()
    this.cartItems = addCartItem(
      this.cartItems,
      product.id,
      this.selectedTemperature,
      this.selectedSugar,
      this.selectedCount
    )
    refreshCartState(this, this.cartItems)
    this.showSpecSheet = false
    this.orderPanelCollapsed = true

    showToast(product.name + ' 已加入购物车')
  }

  private updateCartItem(item: CartProductInfo, type: string): void {
    this.cartItems = updateCartItemCount(this.cartItems, item, type)
    refreshCartState(this, this.cartItems)
  }

  private deleteCartItem(item: CartProductInfo): void {
    this.cartItems = removeCartItem(this.cartItems, item)
    refreshCartState(this, this.cartItems)

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

  private getCartSheetHeight(): string {
    const typeCount: number = this.getCartProducts().length
    const heights: string[] = ['34%', '42%', '52%', '62%']
    return typeCount < heights.length ? heights[typeCount] : '75%'
  }

  private isSpecSelected(title: string, type: string): boolean {
    return type === 'temperature' ? this.selectedTemperature === title : this.selectedSugar === title
  }

  private setSpecValue(title: string, type: string): void {
    if (type === 'temperature') {
      this.selectedTemperature = title
    } else {
      this.selectedSugar = title
    }
  }

  private getOrderTypeButtonBg(title: string, compact: boolean): string {
    return this.orderType === title ? '#8B5E3C' : compact ? '#00FFFFFF' : '#F6E5D2'
  }

  private checkout(): void {
    if (this.cartCount === 0) {
      showToast('请先选择商品')
      return
    }

    if (this.orderType === '外卖' && this.deliveryAddress.trim().length === 0) {
      showToast('请先填写配送地址')
      return
    }

    if (this.orderType === '外卖') {
      this.deliveryStoreId = getNearestStore().id
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
        AppTopBar({
          title: '商品菜单',
          subtitle: '选择取餐方式，点击 + 选择规格',
          rightText: '共' + productList.length.toString() + '件',
          backUrl: 'pages/HomePage'
        })

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
        this.SheetMask('cart')
      }

      if (this.showSpecSheet) {
        this.SheetMask('spec')
      }

      if (this.showStoreSheet) {
        this.SheetMask('store')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  OrderTypePanel() {
    Column() {
      if (this.orderPanelCollapsed) {
        this.CollapsedOrderPanel()
      } else {
        Row() {
          this.OrderTypeButton('自取', false)
          this.OrderTypeButton('外卖', false)
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
          this.OrderTypeButton('自取', true)
          this.OrderTypeButton('外卖', true)
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
  OrderTypeButton(title: string, compact: boolean) {
    Text(title)
      .fontSize(compact ? 14 : 16)
      .fontWeight(this.orderType === title ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.orderType === title ? '#FFFFFF' : '#8B5E3C')
      .textAlign(TextAlign.Center)
      .layoutWeight(1)
      .height(compact ? 30 : 40)
      .backgroundColor(this.getOrderTypeButtonBg(title, compact))
      .borderRadius(compact ? 15 : 20)
      .margin({ right: !compact && title === '自取' ? 10 : 0 })
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
          this.deliveryStoreId = getNearestStore().id
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
      ForEach(categoryList, (item: string) => {
        Column() {
          Text(item)
            .fontSize(16)
            .fontWeight(this.currentCategory === item ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentCategory === item ? '#FFFFFF' : '#6B4F3A')
        }
        .width('100%')
        .height(58)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.currentCategory === item ? '#8B5E3C' : '#F6E5D2')
        .borderRadius(18)
        .margin({ bottom: 12 })
        .onClick(() => {
          this.orderPanelCollapsed = true
          this.currentCategory = item
        })
      }, (item: string) => item)
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
  SheetMask(type: string) {
    Column() {
      Blank()
        .layoutWeight(1)
        .onClick(() => {
          this.closeSheet(type)
        })

      if (type === 'cart') {
        this.CartSheet()
      } else if (type === 'spec') {
        this.SpecSheet()
      } else {
        this.StoreSheet()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#66000000')
  }

  @Builder
  SheetHeader(title: string, type: string) {
    Row() {
      Text(title)
        .fontSize(type === 'spec' ? 23 : 24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .layoutWeight(1)

      if (type === 'cart' && this.cartCount > 0) {
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
          this.closeSheet(type)
        })
    }
    .width('100%')
    .margin({ bottom: 14 })
  }

  @Builder
  StoreSheet() {
    Column() {
      this.SheetHeader('选择自取门店', 'store')

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
  StoreRadio(item: StoreInfo) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(20)
        .height(20)
        .fill(this.selectedStoreId === item.id ? '#F7E7D6' : '#FFFFFF')
        .border({
          width: 1,
          color: this.selectedStoreId === item.id ? '#8B5E3C' : '#C9B8A6'
        })

      if (this.selectedStoreId === item.id) {
        Circle()
          .width(10)
          .height(10)
          .fill('#8B5E3C')
      }
    }
    .width(30)
    .height(30)
    .margin({ right: 8 })
    .onClick(() => {
      this.chooseStore(item)
    })
  }

  @Builder
  StoreItem(item: StoreInfo) {
    Column() {
      Row() {
        this.StoreRadio(item)

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
  SpecSheet() {
    Column() {
      this.SheetHeader('选择规格', 'spec')

      this.SpecProductCard()

      if (!isDessertCategory(this.getSelectedProduct().category)) {
        this.SpecGroup('温度', 'temperature')
        this.SpecGroup('糖度', 'sugar')
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

      this.SelectedCountRow()

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
  SpecProductCard() {
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
  }

  @Builder
  SpecGroup(title: string, type: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .fontColor('#2E2118')
      .margin({ top: 18 })
      .width('100%')

    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(type === 'temperature' ? temperatureList : sugarList, (item: string) => {
        this.SpecChip(item, type)
      }, (item: string) => item)
    }
    .width('100%')
    .margin({ top: 10 })
  }

  @Builder
  SpecChip(title: string, type: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(this.isSpecSelected(title, type) ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.isSpecSelected(title, type) ? '#FFFFFF' : '#6B4F3A')
      .padding({ left: 16, right: 16, top: 9, bottom: 9 })
      .margin({ right: 10, bottom: 10 })
      .backgroundColor(this.isSpecSelected(title, type) ? '#8B5E3C' : '#F6E5D2')
      .borderRadius(18)
      .onClick(() => {
        this.setSpecValue(title, type)
      })
  }

  @Builder
  SelectedCountRow() {
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

      this.SelectedCountButton('－', 'reduce')

      Text(this.selectedCount.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .margin({ left: 14, right: 14 })

      this.SelectedCountButton('＋', 'add')
    }
    .width('100%')
    .margin({ top: 20 })
  }

  @Builder
  SelectedCountButton(label: string, type: string) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(type === 'add' ? '#FFFFFF' : '#8B5E3C')
    }
    .width(34)
    .height(34)
    .borderRadius(17)
    .backgroundColor(type === 'add' ? '#8B5E3C' : '#F6E5D2')
    .onClick(() => {
      this.changeSelectedCount(type)
    })
  }

  @Builder
  CartSheet() {
    Column() {
      this.SheetHeader('购物车', 'cart')

      if (this.getCartProducts().length === 0) {
        this.EmptyCartInSheet()
      } else {
        Scroll() {
          Column() {
            ForEach(this.getCartProducts(), (item: CartProductInfo) => {
              this.CartSheetItem(item)
            }, (item: CartProductInfo) => getCartProductKey(item))
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

        Text(getSpecText(item.category, item.temperature, item.sugar))
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 5 })

        Row() {
          this.CartCountButton('－', 'reduce', item)

          Text(item.count.toString())
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .margin({ left: 12, right: 12 })

          this.CartCountButton('＋', 'add', item)

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
  CartCountButton(label: string, type: string, item: CartProductInfo) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(type === 'add' ? '#FFFFFF' : '#8B5E3C')
    }
    .width(30)
    .height(30)
    .borderRadius(15)
    .backgroundColor(type === 'add' ? '#8B5E3C' : '#F6E5D2')
    .onClick(() => {
      this.updateCartItem(item, type)
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
