import { TypeItem } from '../../components/BrushQuest/TypeItem' //练习列表项组件
import router from '@ohos.router'

@Entry
@Component
export struct QList {
  build() {
    Row() {
      Column({ space: 15 }) {
        ForEach([1, 2, 3, 4], (item, index) => {
          TypeItem()
            .onClick(() => {
              router.pushUrl({ url: 'pages/BrushQuest/ChapterList', params: { typeid: index } })
            })
        }, item => item)
      }
      .width('100%')
      .height('100%')
      .padding(15)
    }
    .height('100%')
    .backgroundColor('#F5F7F9')
  }
}