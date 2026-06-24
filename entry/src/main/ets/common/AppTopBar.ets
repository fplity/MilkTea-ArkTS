import router from '@ohos.router'

@Component
export struct AppTopBar {
  @Prop title: string
  @Prop subtitle: string = ''
  @Prop rightText: string = ''

  build() {
    Row() {
      // 返回箭头
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

      // 标题和副标题
      Column() {
        Text(this.title)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3B2517')
        if (this.subtitle !== '') {
          Text(this.subtitle)
            .fontSize(12)
            .fontColor('#9A7B60')
            .margin({ top: 2 })
        }
      }
      .margin({ left: 14 })
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 右侧文本按钮（如“编辑”、“保存”等）
      if (this.rightText !== '') {
        Text(this.rightText)
          .fontSize(14)
          .fontColor('#8B5E3C')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#F6E5D2')
          .borderRadius(16)
      }
    }
    .width('100%')
    .height(82)
    .padding({ left: 18, right: 18 })
    .backgroundColor('#FFF7EC')
  }
}