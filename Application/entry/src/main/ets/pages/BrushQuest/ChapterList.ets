import router from '@ohos.router'
import Prompt from '@system.prompt';
import { Constants } from '../../common/Constants';
import ChapterItem from './ChapterItem';

class ParamsType {
  typeid: number
}

@Entry
@Component
struct ChapterList {
  @State message: string = '111'

  aboutToAppear() {
    let params: ParamsType = router.getParams() as ParamsType;
    this.message = params.typeid.toString();
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.End }) {
        Text('章节列表')
          .fontSize(18)
          .width('100%')
          .textAlign(TextAlign.Center)
        Image($r('app.media.ic_allread'))
          .width(20)
          .aspectRatio(1)
      }
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 15, right: 15 })

      List() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12], (item: number) => {
          ListItem() {
            ChapterItem()
              .onClick(()=>{
                router.pushUrl({url:Constants.PAGE_QUIZ})
              })
          }
        })
      }
      .divider({ strokeWidth: 1, startMargin: 15, endMargin: 15, color: Constants.GRAY_FULL_COLOR })
      .layoutWeight(1)
      .width('100%')
      .borderRadius(30)
      .backgroundColor(Color.White)
    }
    .height('100%')
    .backgroundColor('#e9f3fe')
  }
}