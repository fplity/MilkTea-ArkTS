import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

interface DetailParams {
  id?: number
}

interface ProductInfo {
  id: number
  name: string
  category: string
  price: number
  image: Resource
  tag: string
  desc: string
  detail: string
}

interface CartItemInfo {
  id: number
  count: number
  temperature: string
  sugar: string
}

const productList: ProductInfo[] = [
  { id: 1, name: '珍珠奶茶', category: '奶茶', price: 18, image: $r('app.media.product1'), tag: '经典热卖', desc: '经典奶茶香浓顺滑', detail: '经典珍珠奶茶，茶香与奶香融合，珍珠Q弹有嚼劲。' },
  { id: 2, name: '鲜果百香绿茶', category: '果茶', price: 20, image: $r('app.media.product2'), tag: '清爽果香', desc: '百香果香绿茶清爽', detail: '鲜果百香绿茶酸甜清爽，搭配绿茶茶底，适合夏天饮用。' },
  { id: 3, name: '草莓奶油蛋糕', category: '甜品', price: 22, image: $r('app.media.product3'), tag: '甜品推荐', desc: '草莓香甜奶油细腻', detail: '草莓奶油蛋糕口感松软，奶油细腻，草莓酸甜清新。' },
  { id: 4, name: '生椰拿铁', category: '咖啡', price: 20, image: $r('app.media.product4'), tag: '椰香咖啡', desc: '椰香浓郁咖啡顺滑', detail: '生椰拿铁融合椰乳和咖啡香气，入口顺滑，椰香自然。' },
  { id: 5, name: '冰美式', category: '咖啡', price: 16, image: $r('app.media.product5'), tag: '清爽提神', desc: '冰爽提神口感清爽', detail: '冰美式口感干净清爽，咖啡香明显，适合需要提神的时候。' },
  { id: 6, name: '葡萄多多', category: '果茶', price: 22, image: $r('app.media.product6'), tag: '葡萄果香', desc: '葡萄香甜酸甜清爽', detail: '葡萄多多带有浓郁葡萄香气，酸甜平衡，口感清爽。' },
  { id: 7, name: '芋泥波波奶茶', category: '奶茶', price: 21, image: $r('app.media.product7'), tag: '绵密芋泥', desc: '芋泥绵密波波Q弹', detail: '芋泥波波奶茶口感厚实，芋泥绵密，波波软糯Q弹。' },
  { id: 8, name: '茉莉奶绿', category: '奶茶', price: 19, image: $r('app.media.product8'), tag: '茉莉清香', desc: '茉莉清香奶绿顺滑', detail: '茉莉奶绿茶香清雅，奶味柔和，喝起来清爽不腻。' },
  { id: 9, name: '黑糖珍珠奶茶', category: '奶茶', price: 20, image: $r('app.media.product9'), tag: '黑糖香甜', desc: '黑糖香甜珍珠软糯', detail: '黑糖珍珠奶茶带有黑糖焦香，珍珠软糯，口感浓郁。' },
  { id: 10, name: '奥利奥奶茶', category: '奶茶', price: 19, image: $r('app.media.product10'), tag: '甜品奶茶', desc: '奥利奥香奶茶顺滑', detail: '奥利奥奶茶加入饼干碎，带有甜品口感，奶茶顺滑香甜。' },
  { id: 11, name: '抹茶红豆奶茶', category: '奶茶', price: 21, image: $r('app.media.product11'), tag: '抹茶红豆', desc: '抹茶清香红豆软糯', detail: '抹茶红豆奶茶抹茶清香明显，红豆软糯香甜。' },
  { id: 12, name: '经典拿铁', category: '咖啡', price: 18, image: $r('app.media.product12'), tag: '经典咖啡', desc: '经典拿铁奶香柔和', detail: '经典拿铁奶香柔和，咖啡香稳定，适合日常饮用。' },
  { id: 13, name: '卡布奇诺', category: '咖啡', price: 19, image: $r('app.media.product13'), tag: '绵密奶泡', desc: '奶泡绵密咖啡香浓', detail: '卡布奇诺奶泡细腻绵密，咖啡香气浓郁，层次感明显。' },
  { id: 14, name: '摩卡咖啡', category: '咖啡', price: 21, image: $r('app.media.product14'), tag: '巧克力味', desc: '摩卡香浓巧克力味', detail: '摩卡咖啡融合咖啡和巧克力风味，香甜浓郁。' },
  { id: 15, name: '焦糖玛奇朵', category: '咖啡', price: 22, image: $r('app.media.product15'), tag: '焦糖香甜', desc: '焦糖香甜咖啡顺滑', detail: '焦糖玛奇朵带有焦糖香气，咖啡和奶香融合顺滑。' },
  { id: 16, name: '提拉米苏', category: '甜品', price: 28, image: $r('app.media.product16'), tag: '人气甜品', desc: '咖啡奶香入口绵密', detail: '提拉米苏入口绵密，咖啡香与奶香融合，甜而不腻。' },
  { id: 17, name: '芒果布丁', category: '甜品', price: 18, image: $r('app.media.product17'), tag: '嫩滑布丁', desc: '芒果香甜布丁嫩滑', detail: '芒果布丁口感嫩滑，芒果香甜明显，适合饭后甜点。' },
  { id: 18, name: '巧克力慕斯', category: '甜品', price: 24, image: $r('app.media.product18'), tag: '丝滑慕斯', desc: '慕斯丝滑巧克力香', detail: '巧克力慕斯细腻丝滑，巧克力香浓，口感柔软。' },
  { id: 19, name: '原味芝士蛋糕', category: '甜品', price: 22, image: $r('app.media.product19'), tag: '芝士香浓', desc: '芝士香浓入口细腻', detail: '原味芝士蛋糕芝士香气浓郁，入口细腻，奶香充足。' },
  { id: 20, name: '奶油泡芙', category: '甜品', price: 16, image: $r('app.media.product20'), tag: '轻甜小食', desc: '外皮酥香奶油顺滑', detail: '奶油泡芙外皮酥香，内馅顺滑，适合搭配饮品。' },
  { id: 21, name: '满杯百香果', category: '果茶', price: 22, image: $r('app.media.product21'), tag: '酸甜清爽', desc: '百香果香酸甜清爽', detail: '满杯百香果酸甜开胃，果香浓郁，喝起来清爽解腻。' },
  { id: 22, name: '蜜桃乌龙茶', category: '果茶', price: 20, image: $r('app.media.product22'), tag: '蜜桃茶香', desc: '蜜桃清甜乌龙茶香', detail: '蜜桃乌龙茶带有蜜桃清甜和乌龙茶香，口感清新。' },
  { id: 23, name: '柠檬茉莉茶', category: '果茶', price: 18, image: $r('app.media.product23'), tag: '清新解腻', desc: '柠檬清爽茉莉清香', detail: '柠檬茉莉茶柠檬清爽，茉莉清香，适合搭配甜品。' },
  { id: 24, name: '葡萄芝士茶', category: '果茶', price: 24, image: $r('app.media.product24'), tag: '芝士果茶', desc: '葡萄香甜芝士浓郁', detail: '葡萄芝士茶葡萄香甜，芝士奶盖浓郁，口感丰富。' },
  { id: 25, name: '西瓜冰茶', category: '果茶', price: 19, image: $r('app.media.product25'), tag: '夏日冰爽', desc: '西瓜清甜冰爽解渴', detail: '西瓜冰茶清甜冰爽，适合夏天饮用，口感轻盈。' },
  { id: 26, name: '杨枝甘露', category: '果茶', price: 20, image: $r('app.media.product26'), tag: '热带果香', desc: '芒果清甜椰香浓郁', detail: '杨枝甘露带有芒果清甜和椰香口感，顺滑清爽，是果茶区新品。' }
]

@Entry
@Component
struct DetailPage {
  @State productId: number = 1
  @State count: number = 1
  @State selectedTemperature: string = '正常冰'
  @State selectedSugar: string = '正常糖'

  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0
  @StorageLink('cartItems') cartItems: CartItemInfo[] = []

  private temperatureList: string[] = ['正常冰', '少冰', '去冰', '常温', '热']
  private sugarList: string[] = ['正常糖', '七分糖', '五分糖', '三分糖', '无糖']

  aboutToAppear(): void {
    const params = router.getParams() as DetailParams
    if (params && params.id !== undefined) {
      this.productId = Number(params.id)
    }

    this.resetSpec()
    this.refreshCartMoney()
  }

  private getProduct(): ProductInfo {
    const result = productList.find((item: ProductInfo) => item.id === this.productId)
    if (result) {
      return result
    }
    return productList[0]
  }

  private resetSpec(): void {
    const product = this.getProduct()

    if (product.category === '甜品') {
      this.selectedTemperature = '默认'
      this.selectedSugar = '默认'
    } else {
      this.selectedTemperature = '正常冰'
      this.selectedSugar = '正常糖'
    }
  }

  private getSelectedSpecText(): string {
    const product = this.getProduct()

    if (product.category === '甜品') {
      return '默认规格'
    }

    return this.selectedTemperature + ' / ' + this.selectedSugar
  }

  private goBack(): void {
    router.back()
  }

  private addCount(): void {
    this.count++
  }

  private reduceCount(): void {
    if (this.count > 1) {
      this.count--
    }
  }

  private refreshCartMoney(): void {
    let totalCount: number = 0
    let totalMoney: number = 0

    this.cartItems.forEach((item: CartItemInfo) => {
      const product = productList.find((p: ProductInfo) => p.id === item.id)

      if (product !== undefined && item.count > 0) {
        totalCount += item.count
        totalMoney += product.price * item.count
      }
    })

    this.cartCount = totalCount
    this.cartTotal = totalMoney
  }

  private updateCartItem(id: number, addCount: number): void {
    const product = this.getProduct()
    let hasItem: boolean = false
    const newCartItems: CartItemInfo[] = []

    this.cartItems.forEach((item: CartItemInfo) => {
      if (
        item.id === id &&
          item.temperature === this.selectedTemperature &&
          item.sugar === this.selectedSugar
      ) {
        hasItem = true
        newCartItems.push({
          id: item.id,
          count: item.count + addCount,
          temperature: item.temperature,
          sugar: item.sugar
        })
      } else {
        newCartItems.push(item)
      }
    })

    if (!hasItem) {
      newCartItems.push({
        id: id,
        count: addCount,
        temperature: product.category === '甜品' ? '默认' : this.selectedTemperature,
        sugar: product.category === '甜品' ? '默认' : this.selectedSugar
      })
    }

    this.cartItems = newCartItems
    this.refreshCartMoney()
  }

  private addToCart(): void {
    const product = this.getProduct()

    this.updateCartItem(product.id, this.count)

    promptAction.showToast({
      message: product.name + ' 已加入购物车'
    })
  }

  private buyNow(): void {
    const product = this.getProduct()

    this.updateCartItem(product.id, this.count)

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

        Text('商品详情')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .margin({ left: 14 })

        Blank()

        Text(this.getProduct().category)
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
          Stack() {
            Image(this.getProduct().image)
              .width('100%')
              .height(300)
              .objectFit(ImageFit.Cover)
              .borderRadius(30)

            Text(this.getProduct().tag)
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

            Text(this.getProduct().detail)
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

      if (this.getProduct().category !== '甜品') {
        Text('温度')
          .fontSize(16)
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
          .fontSize(16)
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
}