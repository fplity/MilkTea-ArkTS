import router from '@ohos.router'
import { AppTopBar } from '../common/AppTopBar'
import { showToast } from '../common/AppToast'

@Entry
@Component
struct LoginPage {
  @State isRegister: boolean = false
  @State phone: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @StorageLink('isLogin') isLogin: boolean = false
  @StorageLink('userPhone') userPhone: string = ''

  private isEmpty(value: string, message: string): boolean {
    if (value.trim() !== '') {
      return false
    }

    showToast(message)
    return true
  }

  private submit(): void {
    if (this.isEmpty(this.phone, '请输入账号') ||
      this.isEmpty(this.password, '请输入密码') ||
      (this.isRegister && this.isEmpty(this.confirmPassword, '请再次输入密码'))) {
      return
    }

    if (this.isRegister) {
      if (this.confirmPassword !== this.password) {
        showToast('两次密码不一致')
        return
      }

      showToast('注册成功，请登录')

      this.isRegister = false
      this.password = ''
      this.confirmPassword = ''
      return
    } else {
      this.isLogin = true
      this.userPhone = this.phone

      AlertDialog.show({
        title: '登录成功',
        message: '你已登录成功，现在可以查看和领取优惠券了',
        autoCancel: false,
        alignment: DialogAlignment.Center,
        primaryButton: {
          value: '确定',
          action: () => {
            router.replaceUrl({
              url: 'pages/CouponPage'
            }).catch(() => {
              showToast('跳转失败，请检查 CouponPage 是否注册')
            })
          }
        }
      })
    }
  }

  build() {
    Column() {
      AppTopBar({ title: this.isRegister ? '注册' : '登录' })

      Column() {
        Text(this.isRegister ? '注册账号' : '登录账号')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
          .margin({ top: 40 })

        Text(this.isRegister ? '新用户注册后即可领取优惠券' : '登录后查看你的优惠券和积分')
          .fontSize(15)
          .fontColor('#9B7A5E')
          .margin({ top: 8, bottom: 34 })

        this.InputBox('请输入账号 / 手机号', this.phone, 'phone')
        this.InputBox('请输入密码', this.password, 'password')

        if (this.isRegister) {
          this.InputBox('请再次输入密码', this.confirmPassword, 'confirm')
        }

        Button(this.isRegister ? '立即注册' : '立即登录')
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width('86%')
          .height(54)
          .backgroundColor('#6F4E37')
          .borderRadius(27)
          .margin({ top: 26 })
          .onClick(() => {
            this.submit()
          })

        Row() {
          Text(this.isRegister ? '已有账号？' : '还没有账号？')
            .fontSize(14)
            .fontColor('#9B7A5E')

          Text(this.isRegister ? '去登录' : '注册账号')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6F4E37')
            .margin({ left: 6 })
            .onClick(() => {
              this.isRegister = !this.isRegister
              this.password = ''
              this.confirmPassword = ''
            })
        }
        .margin({ top: 22 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F4EF')
  }

  @Builder
  InputBox(placeholderText: string, value: string, typeName: string) {
    TextInput({
      placeholder: placeholderText,
      text: value
    })
      .width('86%')
      .height(54)
      .fontSize(15)
      .fontColor('#3B2517')
      .placeholderColor('#B8A99A')
      .padding({ left: 18, right: 18 })
      .backgroundColor('#FFFFFF')
      .borderRadius(27)
      .margin({ bottom: 16 })
      .type(typeName === 'phone' ? InputType.Normal : InputType.Password)
      .onChange((inputValue: string) => {
        if (typeName === 'phone') {
          this.phone = inputValue
        } else if (typeName === 'password') {
          this.password = inputValue
        } else {
          this.confirmPassword = inputValue
        }
      })
  }
}
