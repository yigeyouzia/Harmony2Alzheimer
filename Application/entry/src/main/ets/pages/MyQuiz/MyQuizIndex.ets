import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import { QuizItem } from '../../components/quiz/QuizItem'
import OptionItem from './QuizOptionItem'
// import AnswerSheetDialog from './AnswerSheetDialog'


@Entry
@Component
struct MyQuizIndex {
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Column() {

        // 顶部
        Stack({ alignContent: Alignment.End }) {
          Text('在线模拟')
            .width('100%')
            .fontSize(18)
            .fontWeight(600)
            .textAlign(TextAlign.Center)
          Image($r('app.media.ic_allread'))
            .width(20)
            .aspectRatio(1)
          // .onClick(()=>{
          //   this.dialogController.open();
          // })
        }
        .width('100%')
        .padding({ top: 10, bottom: 20, })

        // 进度条
        Row() {
          Progress({ value: 1, total: 10 })
            .margin({ right: 10 })
            .layoutWeight(1)
          Text() {
            Span('2')
              .fontWeight(900)
              .fontColor(Color.Gray)
            Span('/30')
              .fontWeight(900)
              .fontColor('#c4c4c4')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 题目类型
        Row() {
          Text('单选题')
            .fontSize(12)
            .fontColor(Color.Gray)
            .padding({ top: 2, bottom: 2, left: 10, right: 10 })
            .backgroundColor(Color.White)
        }
        .width('100%')
        .margin({ top: 10 })

        Swiper(this.swiperController) {
          // Text("0")
          //   .width('100%')
          //   .height('70%')
          //   .backgroundColor(Color.Gray)
          //   .textAlign(TextAlign.Center)
          //   .fontSize(30)

          ForEach([1, 2, 3, 4], (item, index) => {
            QuizItem({ question: $r(`app.string.quiz_ + ${item}`) })
              .width('100%')
              .height('60%')
          })
          // QuizItem({ question: $r('app.string.title_immersive') })
          //   .width('100%')
          //   .height('60%')
        }
        .loop(false)

        Blank()
        // 交卷按钮
        Button('提交答案')
          .width(200)
          .height(45)
          .margin({ bottom: 60 })
          .onClick(() => {
            router.pushUrl({ url: Constants.PAGE_QUIZ_RESULT })
          })
      }
      .padding({ left: 15, right: 15 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f9f9f9')
  }
}