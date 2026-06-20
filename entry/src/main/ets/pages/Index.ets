import router from '@ohos.router';
import { AppInfo } from '../common/AppInfo';

@Entry
@Component
struct Index {
  aboutToAppear(): void {
    router.replaceUrl({
      url: 'pages/HomePage'
    });
  }

  build() {
    Column() {
      Text('正在进入首页...')
        .fontSize(18)
        .fontColor('#999999')

      Text(`${AppInfo.APP_NAME} v${AppInfo.VERSION}`)
        .fontSize(12)
        .fontColor('#999999')
        .margin({ top: 10 })

      Text(AppInfo.BUILD_ID)
        .fontSize(10)
        .fontColor('#BBBBBB')
        .margin({ top: 4 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F6E5D3')
  }
}