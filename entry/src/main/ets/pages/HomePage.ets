import router from '@ohos.router'
import { ProductInfo, getProductsByIds } from '../common/ProductData'
import { BottomNavBar } from '../common/BottomNavBar'

interface CategoryItemData {
  icon: ResourceStr
  title: string
  category: string
}

interface BannerItemData {
  image: ResourceStr
  productId: number
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

  private banners: BannerItemData[] = [
    { image: $r('app.media.banner1'), productId: 26 },
    { image: $r('app.media.banner2'), productId: 6 },
    { image: $r('app.media.banner3'), productId: 4 }
  ]

  private recommendIds: number[] = [
    1, 9, 7, 8, 10, 11,
    2, 26, 6, 21, 22, 23, 24, 25,
    4, 12, 13, 14, 15, 5,
    3, 16, 17, 18, 19, 20
  ]

  private getRecommendProducts(): ProductInfo[] {
    return getProductsByIds(this.recommendIds)
  }

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

      BottomNavBar({ current: 'home' })
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
      ForEach(this.banners, (item: BannerItemData) => {
        Image(item.image)
          .width('100%')
          .height(170)
          .borderRadius(28)
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            this.goProductBuy(item.productId)
          })
      }, (item: BannerItemData) => item.productId.toString())
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

      ForEach(this.getRecommendProducts(), (item: ProductInfo) => {
        this.RecommendCard(item)
      }, (item: ProductInfo) => item.id.toString())
    }
  }

  @Builder
  RecommendCard(item: ProductInfo) {
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
}
