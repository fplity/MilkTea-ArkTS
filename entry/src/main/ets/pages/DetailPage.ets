import router from '@ohos.router'
import { AppTopBar } from '../common/AppTopBar'
import { ProductInfo, getProductByIdOrFirst } from '../common/ProductData'
import {
  addCartItem,
  CartItemInfo,
  DEFAULT_SUGAR,
  DEFAULT_TEMPERATURE,
  getDefaultSpec,
  getSpecText as buildSpecText,
  isDessertCategory,
  refreshCartState,
  SpecInfo,
  sugarList,
  temperatureList
} from '../common/CartUtils'
import { showToast } from '../common/AppToast'

interface DetailParams {
  id?: number
}

@Entry
@Component
struct DetailPage {
  @State productId: number = 1
  @State count: number = 1
  @State selectedTemperature: string = DEFAULT_TEMPERATURE
  @State selectedSugar: string = DEFAULT_SUGAR

  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  aboutToAppear(): void {
    const params = router.getParams() as DetailParams
    if (params && params.id !== undefined) {
      this.productId = Number(params.id)
    }

    this.resetSpec()
    refreshCartState(this, this.cartItems)
  }

  private getProduct(): ProductInfo {
    return getProductByIdOrFirst(this.productId)
  }

  private getProductTag(): string {
    const product: ProductInfo = this.getProduct()
    return product.tag !== undefined ? product.tag : '精选推荐'
  }

  private getProductDetail(): string {
    const product: ProductInfo = this.getProduct()
    return product.detail !== undefined ? product.detail : product.desc
  }

  private resetSpec(): void {
    const spec = getDefaultSpec(this.getProduct().category)
    this.selectedTemperature = spec.temperature
    this.selectedSugar = spec.sugar
  }

  private getSelectedSpecText(): string {
    const product: ProductInfo = this.getProduct()

    return buildSpecText(product.category, this.selectedTemperature, this.selectedSugar)
  }

  private addCount(): void {
    this.count++
  }

  private reduceCount(): void {
    if (this.count > 1) {
      this.count--
    }
  }

  private addCurrentSpecToCart(): void {
    const product: ProductInfo = this.getProduct()
    const spec: SpecInfo = isDessertCategory(product.category)
      ? getDefaultSpec(product.category)
      : { temperature: this.selectedTemperature, sugar: this.selectedSugar }

    this.cartItems = addCartItem(this.cartItems, product.id, spec.temperature, spec.sugar, this.count)
    refreshCartState(this, this.cartItems)
  }

  private addToCart(): void {
    const product = this.getProduct()

    this.addCurrentSpecToCart()

    showToast(product.name + ' 已加入购物车')
  }

  private buyNow(): void {
    this.addCurrentSpecToCart()

    router.pushUrl({
      url: 'pages/OrderPage'
    })
  }

  build() {
    Column() {
      AppTopBar({ title: '商品详情', rightText: this.getProduct().category })

      Scroll() {
        Column() {
          Stack() {
            Image(this.getProduct().image)
              .width('100%')
              .height(300)
              .objectFit(ImageFit.Cover)
              .borderRadius(30)

            Text(this.getProductTag())
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .padding({ left: 14, right: 14, top: 7, bottom: 7 })
              .backgroundColor('#8B5E3C')
              .borderRadius(18)
              .position({ x: 18, y: 18 })
          }
          .width('100%')
          .height(300)
          .margin({ top: 8 })

          Column() {
            Row() {
              Text(this.getProduct().name)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor('#2E2118')
                .layoutWeight(1)
                .maxLines(2)
                .lineHeight(34)

              Text('￥' + this.getProduct().price.toString())
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor('#D35400')
                .margin({ left: 10 })
            }
            .width('100%')
            .margin({ top: 22 })

            Text(this.getProduct().desc)
              .fontSize(15)
              .fontColor('#8B6F58')
              .margin({ top: 10 })
              .width('100%')

            Row() {
              Text('商品介绍')
                .fontSize(21)
                .fontWeight(FontWeight.Bold)
                .fontColor('#2E2118')

              Blank()

              Text('精选制作')
                .fontSize(13)
                .fontColor('#8B5E3C')
                .padding({ left: 10, right: 10, top: 5, bottom: 5 })
                .backgroundColor('#F6E5D2')
                .borderRadius(14)
            }
            .width('100%')
            .margin({ top: 30 })

            Text(this.getProductDetail())
              .fontSize(15)
              .fontColor('#6B4F3A')
              .lineHeight(26)
              .margin({ top: 12 })
              .width('100%')

            this.SpecCard()

            Row() {
              Text('购买数量')
                .fontSize(19)
                .fontWeight(FontWeight.Bold)
                .fontColor('#2E2118')

              Blank()

              Stack({ alignContent: Alignment.Center }) {
                Text('-')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#8B5E3C')
              }
              .width(38)
              .height(38)
              .borderRadius(19)
              .backgroundColor('#F6E5D2')
              .onClick(() => {
                this.reduceCount()
              })

              Text(this.count.toString())
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#2E2118')
                .margin({ left: 18, right: 18 })

              Stack({ alignContent: Alignment.Center }) {
                Text('＋')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
              }
              .width(38)
              .height(38)
              .borderRadius(19)
              .backgroundColor('#8B5E3C')
              .onClick(() => {
                this.addCount()
              })
            }
            .width('100%')
            .height(70)
            .padding({ left: 16, right: 16 })
            .margin({ top: 20 })
            .backgroundColor('#FFFFFF')
            .borderRadius(22)
            .shadow({
              radius: 10,
              color: '#10000000',
              offsetX: 0,
              offsetY: 4
            })

            Row() {
              Column() {
                Text('已选规格')
                  .fontSize(14)
                  .fontColor('#8B6F58')

                Text(this.getSelectedSpecText())
                  .fontSize(15)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#2E2118')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Column() {
                Text('合计')
                  .fontSize(14)
                  .fontColor('#8B6F58')

                Text('￥' + (this.getProduct().price * this.count).toString())
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#D35400')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .margin({ top: 24, bottom: 120 })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#FFF7EC')

      Row() {
        Button('加入购物车')
          .width('46%')
          .height(52)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8B5E3C')
          .backgroundColor('#F2DDC7')
          .borderRadius(26)
          .onClick(() => {
            this.addToCart()
          })

        Button('立即购买')
          .width('46%')
          .height(52)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .backgroundColor('#8B5E3C')
          .borderRadius(26)
          .onClick(() => {
            this.buyNow()
          })
      }
      .width('100%')
      .height(86)
      .padding({ left: 18, right: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 14,
        color: '#18000000',
        offsetX: 0,
        offsetY: -4
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  SpecCard() {
    Column() {
      Text('选择规格')
        .fontSize(21)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .width('100%')

      if (!isDessertCategory(this.getProduct().category)) {
        Text('温度')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ top: 18 })
          .width('100%')

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(temperatureList, (item: string) => {
            this.SpecChip(item, 'temperature')
          }, (item: string) => item)
        }
        .width('100%')
        .margin({ top: 10 })

        Text('糖度')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ top: 18 })
          .width('100%')

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(sugarList, (item: string) => {
            this.SpecChip(item, 'sugar')
          }, (item: string) => item)
        }
        .width('100%')
        .margin({ top: 10 })
      } else {
        Text('甜品无需选择温度和糖度，默认规格加入购物车')
          .fontSize(14)
          .fontColor('#9A7B60')
          .width('100%')
          .padding(14)
          .margin({ top: 14 })
          .backgroundColor('#F8F4EF')
          .borderRadius(18)
      }
    }
    .width('100%')
    .padding(16)
    .margin({ top: 24 })
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .shadow({
      radius: 10,
      color: '#10000000',
      offsetX: 0,
      offsetY: 4
    })
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
}
