import router from '@ohos.router'

interface SearchProductData {
  image: ResourceStr
  name: string
  desc: string
  price: number
  category: string
  categoryName: string
}

@Entry
@Component
struct SearchPage {
  @State keyword: string = ''

  private products: SearchProductData[] = [
    { image: $r('app.media.product1'), name: '黑糖珍珠奶茶', desc: '浓郁奶香，软糯珍珠', price: 18, category: 'milkTea', categoryName: '奶茶' },
    { image: $r('app.media.product9'), name: '黑糖珍珠鲜奶', desc: '黑糖香浓，鲜奶顺滑', price: 20, category: 'milkTea', categoryName: '奶茶' },
    { image: $r('app.media.product7'), name: '芋泥波波奶茶', desc: '芋泥绵密，波波软糯', price: 21, category: 'milkTea', categoryName: '奶茶' },
    { image: $r('app.media.product8'), name: '茉莉奶绿', desc: '茉莉清香，奶味顺滑', price: 19, category: 'milkTea', categoryName: '奶茶' },
    { image: $r('app.media.product10'), name: '奥利奥奶茶', desc: '奥利奥碎，奶香浓郁', price: 19, category: 'milkTea', categoryName: '奶茶' },
    { image: $r('app.media.product11'), name: '抹茶红豆奶茶', desc: '抹茶清香，红豆绵密', price: 21, category: 'milkTea', categoryName: '奶茶' },

    { image: $r('app.media.product2'), name: '鲜果百香绿茶', desc: '百香果香，绿茶清爽', price: 20, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product26'), name: '杨枝甘露', desc: '芒果清甜，椰香浓郁', price: 20, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product6'), name: '葡萄多多', desc: '葡萄果香，酸甜清爽', price: 22, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product21'), name: '满杯百香果', desc: '百香果香，酸甜开胃', price: 22, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product22'), name: '蜜桃乌龙茶', desc: '蜜桃清甜，乌龙茶香', price: 20, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product23'), name: '柠檬茉莉茶', desc: '柠檬清爽，茉莉茶香', price: 18, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product24'), name: '葡萄芝士茶', desc: '葡萄清甜，芝士绵密', price: 24, category: 'fruitTea', categoryName: '果茶' },
    { image: $r('app.media.product25'), name: '西瓜冰茶', desc: '西瓜清甜，冰爽解渴', price: 19, category: 'fruitTea', categoryName: '果茶' },

    { image: $r('app.media.product4'), name: '生椰拿铁', desc: '椰香浓郁，咖啡顺滑', price: 20, category: 'coffee', categoryName: '咖啡' },
    { image: $r('app.media.product12'), name: '经典拿铁', desc: '咖啡醇香，奶香顺滑', price: 18, category: 'coffee', categoryName: '咖啡' },
    { image: $r('app.media.product13'), name: '卡布奇诺', desc: '奶泡绵密，咖啡香醇', price: 19, category: 'coffee', categoryName: '咖啡' },
    { image: $r('app.media.product14'), name: '摩卡咖啡', desc: '巧克力香，咖啡浓郁', price: 21, category: 'coffee', categoryName: '咖啡' },
    { image: $r('app.media.product15'), name: '焦糖玛奇朵', desc: '焦糖香甜，奶泡顺滑', price: 22, category: 'coffee', categoryName: '咖啡' },
    { image: $r('app.media.product5'), name: '冰美式', desc: '清爽提神，咖啡香浓', price: 16, category: 'coffee', categoryName: '咖啡' },

    { image: $r('app.media.product3'), name: '草莓奶油蛋糕', desc: '草莓酸甜，奶油细腻', price: 22, category: 'dessert', categoryName: '甜品' },
    { image: $r('app.media.product16'), name: '提拉米苏', desc: '咖啡香气，奶酪绵密', price: 28, category: 'dessert', categoryName: '甜品' },
    { image: $r('app.media.product17'), name: '芒果布丁', desc: '芒果香甜，口感嫩滑', price: 18, category: 'dessert', categoryName: '甜品' },
    { image: $r('app.media.product18'), name: '巧克力慕斯', desc: '巧克力浓郁，慕斯细腻', price: 24, category: 'dessert', categoryName: '甜品' },
    { image: $r('app.media.product19'), name: '原味芝士蛋糕', desc: '芝士浓郁，口感绵密', price: 22, category: 'dessert', categoryName: '甜品' },
    { image: $r('app.media.product20'), name: '奶油泡芙', desc: '外皮酥软，奶油香甜', price: 16, category: 'dessert', categoryName: '甜品' }
  ]

  private getSearchProducts(): SearchProductData[] {
    let text: string = this.keyword.trim()

    if (text === '') {
      return this.products
    }

    return this.products.filter((item: SearchProductData) => {
      return item.name.indexOf(text) !== -1 ||
        item.desc.indexOf(text) !== -1 ||
        item.categoryName.indexOf(text) !== -1
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          if (this.getSearchProducts().length === 0) {
            this.EmptyResult()
          } else {
            ForEach(this.getSearchProducts(), (item: SearchProductData) => {
              this.ProductCard(item)
            }, (item: SearchProductData) => item.name)
          }

          Blank()
            .height(30)
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F4EF')
  }

  @Builder
  TopBar() {
    Column() {
      Row() {
        Text('‹')
          .fontSize(34)
          .fontColor('#3B2517')
          .width(42)
          .height(42)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(21)
          .onClick(() => {
            router.back()
          })

        Text('搜索商品')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
          .margin({ left: 14 })
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 36 })

      Row() {
        Text('🔍')
          .fontSize(18)
          .margin({ left: 14, right: 8 })

        TextInput({
          placeholder: '输入奶茶、果茶、咖啡、甜品名称',
          text: this.keyword
        })
          .fontSize(15)
          .fontColor('#3B2517')
          .placeholderColor('#B8A99A')
          .backgroundColor('#FFFFFF')
          .layoutWeight(1)
          .height(48)
          .onChange((value: string) => {
            this.keyword = value
          })

        if (this.keyword !== '') {
          Text('×')
            .fontSize(22)
            .fontColor('#9B7A5E')
            .width(36)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.keyword = ''
            })
        }
      }
      .width('90%')
      .height(54)
      .margin({ top: 18, bottom: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(27)
      .alignItems(VerticalAlign.Center)
    }
  }

  @Builder
  ProductCard(item: SearchProductData) {
    Row() {
      Image(item.image)
        .width(88)
        .height(88)
        .borderRadius(22)
        .objectFit(ImageFit.Cover)
        .backgroundColor('#F2E6DA')

      Column() {
        Row() {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B2517')
            .layoutWeight(1)

          Text(item.categoryName)
            .fontSize(12)
            .fontColor('#FFFFFF')
            .padding({ left: 8, right: 8, top: 3, bottom: 3 })
            .backgroundColor('#C68A4A')
            .borderRadius(10)
        }
        .width('100%')

        Text(item.desc)
          .fontSize(13)
          .fontColor('#9B7A5E')
          .margin({ top: 8 })

        Row() {
          Text('¥' + item.price)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D05A2A')
            .layoutWeight(1)

          Text('去点单')
            .fontSize(13)
            .fontColor('#FFFFFF')
            .padding({ left: 13, right: 13, top: 7, bottom: 7 })
            .backgroundColor('#6F4E37')
            .borderRadius(16)
            .onClick(() => {
              router.pushUrl({
                url: 'pages/MenuPage',
                params: {
                  category: item.category
                }
              })
            })
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('92%')
    .padding(16)
    .margin({ left: 16, right: 16, bottom: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(26)
    .shadow({
      radius: 12,
      color: '#10000000',
      offsetX: 0,
      offsetY: 5
    })
  }

  @Builder
  EmptyResult() {
    Column() {
      Text('没有找到相关产品')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3B2517')

      Text('换个关键词试试，例如：奶茶、杨枝甘露、生椰拿铁')
        .fontSize(14)
        .fontColor('#9B7A5E')
        .margin({ top: 10 })
    }
    .width('92%')
    .height(220)
    .margin({ left: 16, right: 16, top: 40 })
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
  }
}