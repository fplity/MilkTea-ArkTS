import router from '@ohos.router'
import { AppTheme } from './AppTheme'

interface NavItem {
  icon: ResourceStr
  title: string
  pageUrl: string
  key: string
}

// 底部导航配置项
const navList: NavItem[] = [
  { icon: $r('app.media.home'), title: '首页', pageUrl: 'pages/HomePage', key: 'home' },
  { icon: $r('app.media.menu'), title: '点单', pageUrl: 'pages/MenuPage', key: 'menu' },
  { icon: $r('app.media.cart'), title: '购物车', pageUrl: 'pages/CartPage', key: 'cart' },
  { icon: $r('app.media.mine'), title: '我的', pageUrl: 'pages/MinePage', key: 'mine' }
]

@Component
export struct BottomNavBar {
  @Prop current: string  // 当前选中的 key

  build() {
    Row() {
      ForEach(navList, (item: NavItem) => {
        Column() {
          Image(item.icon)
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .opacity(this.current === item.key ? 1 : 0.5)

          Text(item.title)
            .fontSize(12)
            .fontColor(this.current === item.key ? AppTheme.NAV_ACTIVE : AppTheme.NAV_INACTIVE)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          if (this.current !== item.key) {
            router.replaceUrl({
              url: item.pageUrl
            })
          }
        })
      }, (item: NavItem) => item.key)
    }
    .width('100%')
    .height(72)
    .padding({ left: 8, right: 8 })
    .backgroundColor(AppTheme.WHITE)
  }
}
