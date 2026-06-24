import router from '@ohos.router'
import { AppTopBar } from '../common/AppTopBar'
import { ProductInfo, productList } from '../common/ProductData'

@Entry
@Component
struct SearchPage {
  @State keyword: string = ''

  private getSearchProducts(): ProductInfo[] {
    let text: string = this.keyword.trim()

    if (text === '') {
      return productList
    }

    return productList.filter((item: ProductInfo) => {
      return item.name.indexOf(text) !== -1 ||
        item.desc.indexOf(text) !== -1 ||
        item.category.indexOf(text) !== -1 ||
        item.categoryCode.indexOf(text) !== -1
    })
  }

  build() {
    Column() {
      AppTopBar({ title: '搜索商品' })
      this.SearchBox()

      Scroll() {
        Column() {
          if (this.getSearchProducts().length === 0) {
            this.EmptyResult()
          } else {
            ForEach(this.getSearchProducts(), (item: ProductInfo) => {
              this.ProductCard(item)
            }, (item: ProductInfo) => item.id.toString())
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
  SearchBox() {
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
    .margin({ top: 10, bottom: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(27)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductCard(item: ProductInfo) {
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

          Text(item.category)
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
          Text('¥' + item.price.toString())
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
                  category: item.categoryCode
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
    .onClick(() => {
      router.pushUrl({
        url: 'pages/DetailPage',
        params: {
          id: item.id
        }
      })
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
