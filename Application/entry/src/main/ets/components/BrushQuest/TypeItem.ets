import router from '@ohos.router'

@Component
export struct TypeItem {
  build() {
    Flex() {
      Image($r('app.media.ic_cover1'))
        .alignSelf(ItemAlign.Center)
        .height(80)
        .width(60)
        .borderRadius(10)

      Column() {
        Column() {
          Text('HarmonyOS应用开发高级认证')
            .fontSize(14)
            .fontWeight(500)
            .textAlign(TextAlign.Start)
        }
        .alignSelf(ItemAlign.Start)
        .margin({ left: 10, top: 8 })

        Row() {
          Text('10')
            .fontColor('#3266EE')
            .fontSize(12)
            .fontWeight(400)
          Text('/12节 | 已学进度：10%')
            .fontColor('#979797')
            .fontSize(12)
            .fontWeight(400)
        }
        .width(137)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 24, left: 10 })

        Divider()
          // .width(200)
          .alignSelf(ItemAlign.Start)
          .margin({ left: 10, top: 6 })
      }
    }
    .height(96)
    .backgroundColor(Color.White)
    .borderRadius(9)
    .padding(10)

  }
}