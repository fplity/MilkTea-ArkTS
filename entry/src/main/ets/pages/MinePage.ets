import router from '@ohos.router'
import { AppInfo } from '../common/AppInfo'
import { CouponInfo, couponList } from '../common/CouponData'
import { BottomNavBar } from '../common/BottomNavBar'
import { showToast } from '../common/AppToast'

interface SettingItem {
  icon: string
  title: string
  desc: string
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

@Entry
@Component
struct MinePage {
  @State userName: string = '小帅'
  @State memberLevel: string = '黄金会员'
  @State points: number = 1280

  @StorageLink('paidOrders') paidOrders: PaidOrderInfo[] = []

  private settingList: SettingItem[] = [
    { icon: '👤', title: '个人资料', desc: '头像、昵称、手机号' },
    { icon: '📍', title: '收货地址', desc: '管理配送地址' },
    { icon: '🔔', title: '消息通知', desc: '订单提醒与优惠通知' },
    { icon: '🛡️', title: '账号安全', desc: '密码与隐私设置' },
    { icon: '🎧', title: '客服中心', desc: '常见问题与在线客服' }
  ]

  private goCoupon(): void {
    router.pushUrl({
      url: 'pages/CouponPage'
    })
  }

  private isCouponText(title: string, desc: string): boolean {
    return title.includes('优惠') ||
    title.includes('券') ||
    desc.includes('优惠') ||
    desc.includes('券')
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          this.TopArea()
          this.UserCard()
          this.MemberCard()
          this.DataCard()
          this.OrderRecordCard()
          this.CouponCard()
          this.PointCard()
          this.SettingCard()
          this.AppVersionFooter()

          Blank()
            .height(90)
        }
        .width('100%')
      }
      .layoutWeight(1)

      BottomNavBar({ current: 'mine' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7EC')
  }

  @Builder
  TopArea() {
    Row() {
      Column() {
        Text('个人中心')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text('查看会员、优惠券、积分和订单')
          .fontSize(13)
          .fontColor('#9A7B60')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Text('⚙')
          .fontSize(22)
          .fontColor('#6B4F3A')
      }
      .width(46)
      .height(46)
      .borderRadius(23)
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 10,
        color: '#12000000',
        offsetX: 0,
        offsetY: 4
      })
      .onClick(() => {
        showToast('进入设置')
      })
    }
    .width('100%')
    .padding({ left: 22, right: 22, top: 34, bottom: 12 })
  }

  @Builder
  UserCard() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Image($r('app.media.mine'))
          .width(70)
          .height(70)
          .objectFit(ImageFit.Cover)
          .borderRadius(35)
      }
      .width(82)
      .height(82)
      .borderRadius(41)
      .backgroundColor('#F6E5D2')
      .border({
        width: 3,
        color: '#FFFFFF'
      })
      .shadow({
        radius: 12,
        color: '#16000000',
        offsetX: 0,
        offsetY: 5
      })

      Column() {
        Row() {
          Text(this.userName)
            .fontSize(23)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text(this.memberLevel)
            .fontSize(12)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })
            .backgroundColor('#8B5E3C')
            .borderRadius(13)
            .margin({ left: 10 })
        }

        Text('欢迎回来，今天也要喝一杯喜欢的奶茶')
          .fontSize(13)
          .fontColor('#9A7B60')
          .margin({ top: 8 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Text('>')
        .fontSize(22)
        .fontColor('#B8A99A')
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
    .shadow({
      radius: 14,
      color: '#12000000',
      offsetX: 0,
      offsetY: 6
    })
    .onClick(() => {
      showToast('查看个人资料')
    })
  }

  @Builder
  MemberCard() {
    Column() {
      Row() {
        Column() {
          Text('Milk Tea 会员卡')
            .fontSize(21)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFF5EA')

          Text('黄金会员 · 享专属优惠')
            .fontSize(13)
            .fontColor('#F6D8A8')
            .margin({ top: 6 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('会员中心')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .padding({ left: 13, right: 13, top: 7, bottom: 7 })
          .backgroundColor('#F6D8A8')
          .borderRadius(16)
          .onClick(() => {
            this.goCoupon()
          })
      }
      .width('100%')

      Row() {
        Column() {
          Text('成长值')
            .fontSize(12)
            .fontColor('#F6D8A8')

          Text('2680')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('本月权益')
            .fontSize(12)
            .fontColor('#F6D8A8')

          Text('8 项')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('已下单')
            .fontSize(12)
            .fontColor('#F6D8A8')

          Text(this.paidOrders.length.toString() + ' 单')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('92%')
    .padding(22)
    .margin({ left: 16, right: 16, top: 18 })
    .backgroundColor('#6F4E37')
    .borderRadius(30)
    .shadow({
      radius: 16,
      color: '#22000000',
      offsetX: 0,
      offsetY: 8
    })
  }

  @Builder
  DataCard() {
    Row() {
      this.DataItem('优惠券', couponList.length.toString(), '张', true)
      this.DataItem('积分', this.points.toString(), '分', false)
      this.DataItem('订单', this.paidOrders.length.toString(), '单', false)
    }
    .width('92%')
    .padding({ top: 18, bottom: 18 })
    .margin({ left: 16, right: 16, top: 18 })
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
  DataItem(title: string, value: string, unit: string, isCoupon: boolean) {
    Column() {
      Row() {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')

        Text(unit)
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ left: 2, top: 8 })
      }

      Text(title)
        .fontSize(13)
        .fontColor('#6B4F3A')
        .margin({ top: 6 })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (isCoupon) {
        this.goCoupon()
      } else {
        showToast(title)
      }
    })
  }

  @Builder
  OrderRecordCard() {
    Column() {
      Row() {
        Text('我的订单')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)

        Text(this.paidOrders.length.toString() + ' 单')
          .fontSize(14)
          .fontColor('#8B5E3C')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#F6E5D2')
          .borderRadius(15)
      }
      .width('100%')
      .margin({ bottom: 14 })

      if (this.paidOrders.length === 0) {
        Column() {
          Text('🧾')
            .fontSize(40)

          Text('暂无已支付订单')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')
            .margin({ top: 12 })

          Text('支付完成后会在这里显示取餐号或快递号')
            .fontSize(13)
            .fontColor('#9A7B60')
            .margin({ top: 6 })
        }
        .width('100%')
        .height(150)
        .justifyContent(FlexAlign.Center)
      } else {
        ForEach(this.paidOrders, (item: PaidOrderInfo) => {
          this.OrderRecordItem(item)
        }, (item: PaidOrderInfo) => item.orderNo)
      }
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 18 })
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
  OrderRecordItem(item: PaidOrderInfo) {
    Column() {
      Row() {
        Text(item.takeWay === '到店自取' ? '到店自取' : '外卖配送')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .padding({ left: 10, right: 10, top: 5, bottom: 5 })
          .backgroundColor(item.takeWay === '到店自取' ? '#8B5E3C' : '#D35400')
          .borderRadius(14)

        Blank()

        Text('已支付')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E9D52')
      }
      .width('100%')

      Text(item.productText)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .margin({ top: 12 })
        .width('100%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text('订单编号：' + item.orderNo)
        .fontSize(12)
        .fontColor('#9A7B60')
        .margin({ top: 6 })
        .width('100%')

      if (item.takeWay === '到店自取') {
        Row() {
          Text('取餐号')
            .fontSize(14)
            .fontColor('#7A6251')
            .layoutWeight(1)

          Text(item.pickupNo)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')
        }
        .width('100%')
        .margin({ top: 12 })
      } else {
        Row() {
          Text('快递号')
            .fontSize(14)
            .fontColor('#7A6251')
            .layoutWeight(1)

          Text(item.expressNo)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#D35400')
        }
        .width('100%')
        .margin({ top: 12 })
      }

      Row() {
        Text(item.createTime)
          .fontSize(12)
          .fontColor('#9A7B60')
          .layoutWeight(1)

        Text('实付 ￥' + item.finalMoney.toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(14)
    .margin({ bottom: 12 })
    .backgroundColor('#F8F4EF')
    .borderRadius(20)
  }

  @Builder
  CouponCard() {
    Column() {
      Row() {
        Text('我的优惠券')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')
          .layoutWeight(1)
          .onClick(() => {
            this.goCoupon()
          })

        Text('全部')
          .fontSize(14)
          .fontColor('#8B5E3C')
          .onClick(() => {
            this.goCoupon()
          })
      }
      .width('100%')
      .margin({ bottom: 14 })

      ForEach(couponList, (item: CouponInfo) => {
        this.CouponItemCard(item)
      }, (item: CouponInfo) => item.id)
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 18 })
    .backgroundColor('#FFFFFF')
    .borderRadius(26)
    .shadow({
      radius: 12,
      color: '#12000000',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.goCoupon()
    })
  }

  @Builder
  CouponItemCard(item: CouponInfo) {
    Row() {
      Column() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text(item.desc)
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text('¥' + item.money.toString())
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .backgroundColor('#8B5E3C')
        .borderRadius(16)
    }
    .width('100%')
    .padding(14)
    .margin({ bottom: 12 })
    .backgroundColor('#F8F4EF')
    .borderRadius(20)
    .onClick(() => {
      this.goCoupon()
    })
  }

  @Builder
  PointCard() {
    Column() {
      Row() {
        Column() {
          Text('我的积分')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#2E2118')

          Text('积分可兑换饮品券和甜品券')
            .fontSize(13)
            .fontColor('#9A7B60')
            .margin({ top: 6 })
            .onClick(() => {
              this.goCoupon()
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text(this.points.toString())
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D35400')
      }
      .width('100%')

      Row() {
        Text('签到赚积分')
          .fontSize(15)
          .fontColor('#6B4F3A')
          .layoutWeight(1)

        Button('立即签到')
          .width(100)
          .height(38)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .backgroundColor('#8B5E3C')
          .borderRadius(19)
          .onClick(() => {
            this.points += 20
            showToast('签到成功，积分 +20')
          })
      }
      .width('100%')
      .padding(14)
      .margin({ top: 16 })
      .backgroundColor('#F8F4EF')
      .borderRadius(20)
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 18 })
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
  SettingCard() {
    Column() {
      Text('设置')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2E2118')
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.settingList, (item: SettingItem) => {
        this.SettingItemCard(item)
      }, (item: SettingItem) => item.title)
    }
    .width('92%')
    .padding(18)
    .margin({ left: 16, right: 16, top: 18 })
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
  SettingItemCard(item: SettingItem) {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(item.icon)
          .fontSize(20)
      }
      .width(42)
      .height(42)
      .borderRadius(21)
      .backgroundColor('#F6E5D2')

      Column() {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E2118')

        Text(item.desc)
          .fontSize(12)
          .fontColor('#9A7B60')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .alignItems(HorizontalAlign.Start)

      Text('>')
        .fontSize(20)
        .fontColor('#B8A99A')
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .onClick(() => {
      if (this.isCouponText(item.title, item.desc)) {
        this.goCoupon()
      } else {
        showToast(item.title)
      }
    })
  }
  @Builder
  AppVersionFooter() {
    Column() {
      Text(`${AppInfo.APP_NAME} v${AppInfo.VERSION}`)
        .fontSize(12)
        .fontColor('#9A7B60')

      Text(AppInfo.BUILD_ID)
        .fontSize(10)
        .fontColor('#C8B8A8')
        .margin({ top: 4 })

      Text(AppInfo.BUNDLE_NAME)
        .fontSize(10)
        .fontColor('#C8B8A8')
        .margin({ top: 4 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .margin({ top: 22, bottom: 8 })
  }
}
