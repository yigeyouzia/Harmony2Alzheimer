import router from '@ohos.router'
import { Constants } from '../../common/Constants'


@CustomDialog
export default struct AnswerSheetDialog {
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  list: string[] = Array.from({ length: 20 }, (_, index) => index + 1 + '');

  build() {
    Column() {
      // 标题
      Row() {
        Text('单项选择题')
        Blank()
        Image($r('app.media.ic_public_close_filled'))
          .width(20)
          .aspectRatio(1)
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
      }
      .width('100%')
      // 标识
      Row({ space: 40 }) {
        Row({ space: 8 }) {
          Text()
            .size({ width: 16, height: 16 })
            .borderRadius(8)
            .backgroundColor(Constants.GRAY_FULL_COLOR)
          Text('未答')
        }

        Row({ space: 8 }) {
          Text()
            .size({ width: 16, height: 16 })
            .borderRadius(8)
            .backgroundColor(Constants.RIGHT_FULL_COLOR)
          Text('已答')
        }

      }
      .width('100%')
      .padding({ top: 15, bottom: 15 })

      // 答题卡选项
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.list, (item: string,index:number) => {
          Row() {
            if(index<=3){
              Text(item)
                .textAlign(TextAlign.Center)
                .fontColor(Color.White)
                .size({ width: 40, height: 40 })
                .borderRadius(20)
                .backgroundColor(Constants.RIGHT_FULL_COLOR)
            }else{
              Text(item)
                .textAlign(TextAlign.Center)
                .fontColor(Color.White)
                .size({ width: 40, height: 40 })
                .borderRadius(20)
                .backgroundColor(Constants.GRAY_FULL_COLOR)
            }

          }
          .justifyContent(FlexAlign.Center)
          .width('20%')
          .aspectRatio(1)
        })
      }
      .backgroundColor(Constants.GRAY_LIGHT_COLOR)

      // 交卷查看结果
      Button('提交答案')
        .margin(20)
        .width(200)
        .onClick(() => {
          this.confirm()
          this.controller.close()
          router.push({ url: Constants.PAGE_QUIZ_RESULT })
        })
    }
    .padding(20)
    .width('100%')
    .backgroundColor(Color.White)
  }
}