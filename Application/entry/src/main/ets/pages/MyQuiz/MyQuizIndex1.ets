import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import { QuizItem } from '../../components/quiz/QuizItem'
import OptionItem from './QuizOptionItem'
// import AnswerSheetDialog from './AnswerSheetDialog'


interface Question {
  section: number,
  question: string
}

const allQuestions: Question[] = [
  { section: 1, question: "今年的年份？" },
  { section: 1, question: "现在是什么季节？" },
  { section: 1, question: "今天是几号？" },
  { section: 1, question: "今天是星期几？" },
  { section: 1, question: "现在是几月份？" },
  { section: 1, question: "您能告诉我现在我们在哪里吗？（例如，现在我们在哪个省、市）" },
  { section: 1, question: "您现在什么区县？" },
  { section: 1, question: "您住在什么街道？" },
  { section: 1, question: "我们现在几楼？" },
  { section: 1, question: "这儿是什么地方？地址名称：" },
  { section: 2, question: "请重复：皮球" },
  { section: 2, question: "请重复：国旗" },
  { section: 2, question: "请重复：树木" },
  { section: 3, question: "从100减去7，然后从所得的数目再减去7，如此一直计算下去，把每一个答案告诉我，直到我说“停”为止。" },
  { section: 4, question: "请倒述：天上有月亮" },
  { section: 4, question: "请记住的三样东西是什么？皮球" },
  { section: 4, question: "请记住的三样东西是什么？国旗" },
  { section: 4, question: "请记住的三样东西是什么？树木" },
  { section: 5, question: "请问这是什么？（手表）" },
  { section: 5, question: "请问这是什么？（铅笔）" },
  { section: 6, question: "请清楚地重复一遍：“四十四只石狮子”。" },
  { section: 7, question: "请照这张卡片所写的去做：（闭上你的眼睛）" },
  { section: 7, question: "请用右手拿这张纸，再用双手把纸对折，然后将纸放在您的大腿上。" },
  { section: 8, question: "请您说一句完整的、有意义的句子" },
  { section: 9, question: "请在同一张卡片上照样把它画出来。（两个五边形的图案，交叉处形成一个小四边形）" }
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
          Text('简易智能状态检查中文版')
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