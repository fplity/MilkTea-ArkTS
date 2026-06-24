import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { CouponInfo, couponList } from '../common/CouponData'
import { AppTopBar } from '../common/AppTopBar'

@Entry
@Component
struct CouponPage {
  @StorageLink('isLogin') isLogin: boolean = false
  @StorageLink('userPhone') userPhone: string = ''

  @StorageLink('cartCount') cartCount: number = 0
  @StorageLink('cartTotal') cartTotal: number = 0

  @StorageLink('coupon8Received') coupon8Received: boolean = false
  @StorageLink('coupon5Received') coupon5Received: boolean = false
  @StorageLink('coupon6Received') coupon6Received: boolean = false

  @StorageLink('selectedCouponMoney') selectedCouponMoney: number = 0
  @StorageLink('selectedCouponTitle') selectedCouponTitle: string = ''
  @StorageLink('selectedCouponLimit') selectedCouponLimit: number = 0

  aboutToAppear() {
    if (!this.isLogin) {
      promptAction.showToast({
        message: '请先登录账号后查看优惠券'
      })
    }
  }

  private getReceived(id: string): boolean {
    if (id === 'new-user') {
      return this.coupon8Received
    } else if (id === 'milk-tea') {
      return this.coupon5Received
    } else if (id === 'fruit-tea') {
      return this.coupon6Received
    }

    return false
  }

  private setReceived(id: string): void {
    if (id === 'new-user') {
      this.coupon8Received = true
    } else if (id === 'milk-tea') {
      this.coupon5Received = true
    } else if (id === 'fruit-tea') {
      this.coupon6Received = true
    }
  }

  private canUseCoupon(limitMoney: number): boolean {
    return this.cartTotal >= limitMoney
  }

  private getCouponButtonText(item: CouponInfo): string {
    if (!this.isLogin) {
      return '登录后领取'
    }

    if (!this.getReceived(item.id)) {
      return '点击领取'
    }

    if (this.selectedCouponMoney === item.money) {
      return '已使用'
    }

    if (!this.canUseCoupon(item.limitMoney)) {
      return '满 ' + item.limitMoney.toString() + ' 元可用'
    }

    return '选择使用'
  }

  private getCouponButtonColor(item: CouponInfo): string {
    if (!this.isLogin) {
      return '#C68A4A'
    }

    if (!this.getReceived(item.id)) {
      return '#D05A2A'
    }

    if (this.selectedCouponMoney === item.money) {
      return '#2E9D52'
    }

    if (!this.canUseCoupon(item.limitMoney)) {
      return '#B8A99A'
    }

    return '#6F4E37'
  }

  private handleCouponClick(item: CouponInfo): void {
    if (!this.isLogin) {
      promptAction.showToast({
        message: '请先登录账号'
      })

      router.pushUrl({
        url: 'pages/LoginPage'
      })
      return
    }

    if (!this.getReceived(item.id)) {
      this.setReceived(item.id)

      promptAction.showToast({
        message: '领取成功'
      })
      return
    }

    if (!this.canUseCoupon(item.limitMoney)) {
      promptAction.showToast({
        message: '当前商品金额不足，满 ' + item.limitMoney.toString() + ' 元可用'
      })
      return
    }

    if (this.selectedCouponMoney === item.money) {
      AlertDialog.show({
        title: '取消使用优惠券',
        message: '你正在使用「' + item.title + '」，是否取消使用？',
        autoCancel: true,
        alignment: DialogAlignment.Center,
        secondaryButton: {
          value: '继续使用',
          action: () => {
          }
        },
        primaryButton: {
          value: '取消使用',
          action: () => {
            this.selectedCouponMoney = 0
            this.selectedCouponTitle = ''
            this.selectedCouponLimit = 0

            promptAction.showToast({
              message: '已取消使用优惠券'
            })
          }
        }
      })
      return
    }

    AlertDialog.show({
      title: '使用优惠券',
      message: '是否使用「' + item.title + '」？结算时将抵扣 ' + item.money.toString() + ' 元',
      autoCancel: true,
      alignment: DialogAlignment.Center,
      secondaryButton: {
        value: '暂不使用',
        action: () => {
        }
      },
      primaryButton: {
        value: '确定使用',
        action: () => {
          this.selectedCouponMoney = item.money
          this.selectedCouponTitle = item.title
          this.selectedCouponLimit = item.limitMoney

          promptAction.showToast({
            message: '已选择使用优惠券'
          })
        }
      }
    })
  }
  private goNext(): void {
    if (!this.isLogin) {
      router.pushUrl({
        url: 'pages/LoginPage'
      })
      return
    }

    if (this.cartCount > 0) {
      router.pushUrl({
        url: 'pages/OrderPage'
      })
    } else {
      router.pushUrl({
        url: 'pages/MenuPage'
      })
    }
  }

  build() {
    Column() {
      AppTopBar({ title: '优惠券' })

      Scroll() {
        Column() {
          Text(this.isLogin ? '我的优惠券' : '新人专享优惠券')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B2517')
            .margin({ top: 30 })

          Text(this.isLogin ? '领取后可选择是否在结算时使用' : '登录账号后即可领取和使用')
            .fontSize(15)
            .fontColor('#9B7A5E')
            .margin({ top: 8 })

          if (this.isLogin) {
            Text('当前账号：' + this.userPhone)
              .fontSize(13)
              .fontColor('#C68A4A')
              .margin({ top: 8 })

            this.TotalCard()
          }

          ForEach(couponList, (item: CouponInfo) => {
            this.CouponCard(item)
          }, (item: CouponInfo) => item.id)

          Text(this.isLogin ? (this.cartCount > 0 ? '去结算' : '去点单') : '去登录 / 注册')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .width('86%')
            .height(52)
            .textAlign(TextAlign.Center)
            .backgroundColor('#6F4E37')
            .borderRadius(26)
            .margin({ top: 26, bottom: 30 })
            .onClick(() => {
              this.goNext()
            })
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
  TotalCard() {
    Column() {
      Row() {
        Text('当前购物车金额')
          .fontSize(14)
          .fontColor('#8A6B52')
          .layoutWeight(1)

        Text('￥' + this.cartTotal.toString())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D05A2A')
      }
      .width('100%')

      Row() {
        Text('当前使用优惠券')
          .fontSize(14)
          .fontColor('#8A6B52')
          .layoutWeight(1)

        Text(this.selectedCouponMoney > 0 ? '-￥' + this.selectedCouponMoney.toString() : '未使用')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selectedCouponMoney > 0 ? '#2E9D52' : '#9B7A5E')
      }
      .width('100%')
      .margin({ top: 10 })

      Row() {
        Text('预计实付')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
          .layoutWeight(1)

        Text('￥' + Math.max(this.cartTotal - this.selectedCouponMoney, 0).toString())
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D05A2A')
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('88%')
    .padding(16)
    .margin({ top: 18 })
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({
      radius: 10,
      color: '#10000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  CouponCard(item: CouponInfo) {
    Row() {
      Column() {
        Text('¥' + item.money.toString())
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D05A2A')

        Text('优惠券')
          .fontSize(13)
          .fontColor('#9B7A5E')
          .margin({ top: 4 })
      }
      .width(96)
      .height(96)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF3E4')
      .borderRadius(24)

      Column() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')

        Text(item.desc)
          .fontSize(13)
          .fontColor('#9B7A5E')
          .margin({ top: 8 })

        Text(this.getCouponButtonText(item))
          .fontSize(12)
          .fontColor('#FFFFFF')
          .padding({ left: 12, right: 12, top: 5, bottom: 5 })
          .backgroundColor(this.getCouponButtonColor(item))
          .borderRadius(14)
          .margin({ top: 12 })
      }
      .layoutWeight(1)
      .margin({ left: 18 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('88%')
    .padding(16)
    .margin({ top: 18 })
    .backgroundColor(this.selectedCouponMoney === item.money ? '#FFF8EE' : '#FFFFFF')
    .borderRadius(28)
    .border({
      width: this.selectedCouponMoney === item.money ? 2 : 0,
      color: '#D05A2A'
    })
    .shadow({
      radius: 12,
      color: '#10000000',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      this.handleCouponClick(item)
    })
  }
}