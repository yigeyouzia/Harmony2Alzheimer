import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import { QuizItem } from '../../components/quiz/QuizItem'
import OptionItem from './QuizOptionItem'
// import AnswerSheetDialog from './AnswerSheetDialog'


interface Question {
  section: number,
  question: string,
  img_url?: String,
}

const allQuestions: Question[] = [
  { section: 1, question: "按照规律连线" },
  { section: 1, question: "复制立方体" },
  { section: 1, question: "画钟表（11点过10分）" },
  { section: 2, question: "命名", img_url: "app.media.quiz_mingming" },
  { section: 3, question: "读出下列词语，而后由患者重复上述过程重复两次，5分钟后回忆" },
  { section: 4, question: "读出下列数字，请患者重复（每秒1个）" },
  { section: 4, question: "读出下列数字，每当数字1出现时，患者必须用手敲打一下桌面" },
  { section: 4, question: "100连续减7" },
  { section: 5, question: "重复：我只知道今天张亮是来帮过忙的人" },
  { section: 5, question: "重复：狗在房间的时候，猫总是躲在沙发下面" },
  { section: 5, question: "在1分钟内尽可能多的说出动物的名字" },
  { section: 6, question: "词语相似性：如香蕉-桔子=水果，火车-自行车，手表-尺子" },
  { section: 7, question: "回忆时不能提示（仅根据非提示回忆记分）" },
  { section: 8, question: "日期" },
  { section: 8, question: "月份" },
  { section: 8, question: "年代" },
  { section: 8, question: "星期几" },
  { section: 8, question: "地点" },
  { section: 8, question: "城市" }
];


@Entry
@Component
struct MyQuizIndex {
  private swiperController: SwiperController = new SwiperController()
  @State allQuestions: {
    section: number,
    question: string
  }[] = allQuestions;

  build() {
    Column() {
      Column() {

        // 顶部
        Stack({ alignContent: Alignment.End }) {
          Text('MoCA （Montreal Congnive Assessment）蒙特利尔认知评估')
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

          // ForEach([1, 2, 3, 4], (item, index) => {
          //   QuizItem({ question: $r(`app.string.quiz_ + ${item}`) })
          //     .width('100%')
          //     .height('60%')
          // })

          ForEach(this.allQuestions, (item: Question, index) => {
            QuizItem({ question: item.question })
              .width('100%')
              .height('60%')
          })

          // this.sections.forEach((item, index) => {
          //
          // })


          QuizItem({ question: $r('app.string.abc') })
            .width('100%')
            .height('60%')
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