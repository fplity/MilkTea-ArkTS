import router from '@ohos.router'

interface CategoryItemData {
  icon: ResourceStr
  title: string
  category: string
}

interface RecommendItemData {
  id: number
  image: ResourceStr
  name: string
  desc: string
  price: number
  category: string
}

@Entry
@Component
struct HomePage {
  private categories: CategoryItemData[] = [
    { icon: $r('app.media.milkTea'), title: '奶茶', category: 'milkTea' },
    { icon: $r('app.media.fruitTea'), title: '果茶', category: 'fruitTea' },
    { icon: $r('app.media.coffee'), title: '咖啡', category: 'coffee' },
    { icon: $r('app.media.dessert'), title: '甜品', category: 'dessert' }
  ]

  private recommends: RecommendItemData[] = [
    { id: 1, image: $r('app.media.product1'), name: '珍珠奶茶', desc: '经典奶茶，香浓顺滑', price: 18, category: 'milkTea' },
    { id: 9, image: $r('app.media.product9'), name: '黑糖珍珠奶茶', desc: '黑糖香甜，奶茶顺滑', price: 20, category: 'milkTea' },
    { id: 7, image: $r('app.media.product7'), name: '芋泥波波奶茶', desc: '芋泥绵密，波波软糯', price: 21, category: 'milkTea' },
    { id: 8, image: $r('app.media.product8'), name: '茉莉奶绿', desc: '茉莉清香，奶味顺滑', price: 19, category: 'milkTea' },
    { id: 10, image: $r('app.media.product10'), name: '奥利奥奶茶', desc: '奥利奥碎，奶香浓郁', price: 19, category: 'milkTea' },
    { id: 11, image: $r('app.media.product11'), name: '抹茶红豆奶茶', desc: '抹茶清香，红豆绵密', price: 21, category: 'milkTea' },

    { id: 2, image: $r('app.media.product2'), name: '鲜果百香绿茶', desc: '百香果香，绿茶清爽', price: 20, category: 'fruitTea' },
    { id: 26, image: $r('app.media.product26'), name: '杨枝甘露', desc: '芒果清甜，椰香浓郁', price: 20, category: 'fruitTea' },
    { id: 6, image: $r('app.media.product6'), name: '葡萄多多', desc: '葡萄果香，酸甜清爽', price: 22, category: 'fruitTea' },
    { id: 21, image: $r('app.media.product21'), name: '满杯百香果', desc: '百香果香，酸甜开胃', price: 22, category: 'fruitTea' },
    { id: 22, image: $r('app.media.product22'), name: '蜜桃乌龙茶', desc: '蜜桃清甜，乌龙茶香', price: 20, category: 'fruitTea' },
    { id: 23, image: $r('app.media.product23'), name: '柠檬茉莉茶', desc: '柠檬清爽，茉莉茶香', price: 18, category: 'fruitTea' },
    { id: 24, image: $r('app.media.product24'), name: '葡萄芝士茶', desc: '葡萄清甜，芝士绵密', price: 24, category: 'fruitTea' },
    { id: 25, image: $r('app.media.product25'), name: '西瓜冰茶', desc: '西瓜清甜，冰爽解渴', price: 19, category: 'fruitTea' },

    { id: 4, image: $r('app.media.product4'), name: '生椰拿铁', desc: '椰香浓郁，咖啡顺滑', price: 20, category: 'coffee' },
    { id: 12, image: $r('app.media.product12'), name: '经典拿铁', desc: '咖啡醇香，奶香顺滑', price: 18, category: 'coffee' },
    { id: 13, image: $r('app.media.product13'), name: '卡布奇诺', desc: '奶泡绵密，咖啡香醇', price: 19, category: 'coffee' },
    { id: 14, image: $r('app.media.product14'), name: '摩卡咖啡', desc: '巧克力香，咖啡浓郁', price: 21, category: 'coffee' },
    { id: 15, image: $r('app.media.product15'), name: '焦糖玛奇朵', desc: '焦糖香甜，奶泡顺滑', price: 22, category: 'coffee' },
    { id: 5, image: $r('app.media.product5'), name: '冰美式', desc: '清爽提神，咖啡香浓', price: 16, category: 'coffee' },

    { id: 3, image: $r('app.media.product3'), name: '草莓奶油蛋糕', desc: '草莓酸甜，奶油细腻', price: 22, category: 'dessert' },
    { id: 16, image: $r('app.media.product16'), name: '提拉米苏', desc: '咖啡香气，奶酪绵密', price: 28, category: 'dessert' },
    { id: 17, image: $r('app.media.product17'), name: '芒果布丁', desc: '芒果香甜，口感嫩滑', price: 18, category: 'dessert' },
    { id: 18, image: $r('app.media.product18'), name: '巧克力慕斯', desc: '巧克力浓郁，慕斯细腻', price: 24, category: 'dessert' },
    { id: 19, image: $r('app.media.product19'), name: '原味芝士蛋糕', desc: '芝士浓郁，口感绵密', price: 22, category: 'dessert' },
    { id: 20, image: $r('app.media.product20'), name: '奶油泡芙', desc: '外皮酥软，奶油香甜', price: 16, category: 'dessert' }
  ]

  private goProductBuy(productId: number): void {
    router.pushUrl({
      url: 'pages/MenuPage',
      params: {
        productId: productId
      }
    })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.TopArea()
          this.BannerArea()
          this.CategoryArea()
          this.ActivityArea()
          this.RecommendArea()

          Blank()
            .height(90)
        }
        .width('100%')
      }
      .layoutWeight(1)

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F4EF')
  }

  @Builder
  TopArea() {
    Row() {
      Column() {
        Text('Milk Tea')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')

        Text('今天想喝点什么？')
          .fontSize(15)
          .fontColor('#9B7A5E')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('🔍')
          .fontSize(20)
      }
      .width(46)
      .height(46)
      .borderRadius(23)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .shadow({
        radius: 8,
        color: '#10000000',
        offsetX: 0,
        offsetY: 3
      })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/SearchPage'
        })
      })
    }
    .width('100%')
    .padding({ left: 22, right: 22, top: 34, bottom: 12 })
  }

  @Builder
  BannerArea() {
    Swiper() {
      Image($r('app.media.banner1'))
        .width('100%')
        .height(170)
        .borderRadius(28)
        .objectFit(ImageFit.Fill)
        .onClick(() => {
          this.goProductBuy(26)
        })

      Image($r('app.media.banner2'))
        .width('100%')
        .height(170)
        .borderRadius(28)
        .objectFit(ImageFit.Fill)
        .onClick(() => {
          this.goProductBuy(6)
        })

      Image($r('app.media.banner3'))
        .width('100%')
        .height(170)
        .borderRadius(28)
        .objectFit(ImageFit.Fill)
        .onClick(() => {
          this.goProductBuy(4)
        })
    }
    .width('92%')
    .height(170)
    .margin({ left: 18, right: 18, top: 12 })
    .borderRadius(28)
    .autoPlay(true)
    .interval(3000)
    .indicator(true)
    .loop(true)
  }

  @Builder
  CategoryArea() {
    Column() {
      Row() {
        Text('饮品分类')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
          .layoutWeight(1)

        Text('全部')
          .fontSize(14)
          .fontColor('#9B7A5E')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MenuPage'
            })
          })
      }
      .width('100%')
      .padding({ left: 22, right: 22, top: 26, bottom: 14 })

      Row() {
        ForEach(this.categories, (item: CategoryItemData) => {
          this.CategoryItem(item.icon, item.title, item.category)
        }, (item: CategoryItemData) => item.category)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ left: 14, right: 14 })
    }
  }

  @Builder
  CategoryItem(icon: ResourceStr, title: string, category: string) {
    Column() {
      Image(icon)
        .width(46)
        .height(46)
        .objectFit(ImageFit.Contain)

      Text(title)
        .fontSize(14)
        .fontColor('#3B2517')
        .margin({ top: 8 })
    }
    .width(76)
    .height(88)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 10,
      color: '#12000000',
      offsetX: 0,
      offsetY: 4
    })
    .onClick(() => {
      router.pushUrl({
        url: 'pages/MenuPage',
        params: {
          category: category
        }
      })
    })
  }

  @Builder
  ActivityArea() {
    Row() {
      Column() {
        Text('新人优惠券')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')

        Text('登录账号后可领取下单立减 8 元')
          .fontSize(13)
          .fontColor('#8A6B52')
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('去领取')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
        .padding({ left: 18, right: 18, top: 8, bottom: 8 })
        .backgroundColor('#6F4E37')
        .borderRadius(18)
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 24 })
    .backgroundColor('#F6D8A8')
    .borderRadius(26)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/CouponPage'
      })
    })
  }

  @Builder
  RecommendArea() {
    Column() {
      Row() {
        Text('热门推荐')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
          .layoutWeight(1)

        Text('更多')
          .fontSize(14)
          .fontColor('#9B7A5E')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/MenuPage'
            })
          })
      }
      .width('100%')
      .padding({ left: 22, right: 22, top: 26, bottom: 14 })

      ForEach(this.recommends, (item: RecommendItemData) => {
        this.RecommendCard(item)
      }, (item: RecommendItemData) => item.name)
    }
  }

  @Builder
  RecommendCard(item: RecommendItemData) {
    Row() {
      Image(item.image)
        .width(94)
        .height(94)
        .borderRadius(22)
        .objectFit(ImageFit.Cover)
        .backgroundColor('#F2E6DA')
        .onClick(() => {
          this.goProductBuy(item.id)
        })

      Column() {
        Row() {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B2517')
            .layoutWeight(1)

          Text('推荐')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .padding({ left: 9, right: 9, top: 4, bottom: 4 })
            .backgroundColor('#C68A4A')
            .borderRadius(12)
        }
        .width('100%')

        Text(item.desc)
          .fontSize(13)
          .fontColor('#9B7A5E')
          .margin({ top: 10 })

        Row() {
          Text('¥' + item.price.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D05A2A')
            .layoutWeight(1)

          Text('+')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .width(44)
            .height(44)
            .textAlign(TextAlign.Center)
            .backgroundColor('#6F4E37')
            .borderRadius(22)
            .onClick(() => {
              this.goProductBuy(item.id)
            })
        }
        .width('100%')
        .margin({ top: 14 })
      }
      .layoutWeight(1)
      .margin({ left: 18 })
      .alignItems(HorizontalAlign.Start)
      .onClick(() => {
        this.goProductBuy(item.id)
      })
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, bottom: 18 })
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
    .shadow({
      radius: 14,
      color: '#12000000',
      offsetX: 0,
      offsetY: 6
    })
  }

  @Builder
  BottomNav() {
    Row() {
      this.BottomItem($r('app.media.home'), '首页', true, '')
      this.BottomItem($r('app.media.menu'), '点单', false, 'pages/MenuPage')
      this.BottomItem($r('app.media.cart'), '购物车', false, 'pages/CartPage')
      this.BottomItem($r('app.media.mine'), '我的', false, 'pages/MinePage')
    }
    .width('100%')
    .height(72)
    .padding({ left: 8, right: 8 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  BottomItem(icon: ResourceStr, title: string, selected: boolean, pageUrl: string) {
    Column() {
      Image(icon)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .opacity(selected ? 1 : 0.5)

      Text(title)
        .fontSize(12)
        .fontColor(selected ? '#6F4E37' : '#B8A99A')
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (pageUrl !== '') {
        router.pushUrl({
          url: pageUrl
        })
      }
    })
  }
}