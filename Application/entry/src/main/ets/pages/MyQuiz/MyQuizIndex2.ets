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
  { section: 1, question: "他/她有记忆减退或考虑问题困难吗?" },
  { section: 1, question: "假如有是经常出现的吗(而不是偶尔出现)?" },
  { section: 1, question: "他/她能回忆起最近发生的事情吗?" },
  { section: 1, question: "如果让他/她到商店去买几样东西他/她能记住买什么吗?" },
  { section: 1, question: "过去的一年中他/她有记忆力减退吗?" },
  { section: 1, question: "他/她的记忆问题是否已经影响他/她的日常活动?" },
  { section: 1, question: "他/她会完全忘记近几周的重要事情吗(如旅游、聚会、婚礼等)?" },
  { section: 1, question: "他/她会记不清这些事情的细节吗?" },
  { section: 1, question: "他/她会把很早以前的重要事情完全忘记吗(如生日、结婚日期、工作单位)?" },
  { section: 1, question: "告诉我一些他/她最近生活中应该记住的一些事情" },
  { section: 1, question: "他/她是什么时候出生的?" },
  { section: 1, question: "他/她在什么地方出生的?" },
  { section: 1, question: "他/她最后就读的学校叫什么名字? 那所学校在哪儿? 他/她上到几年级" },
  { section: 1, question: "他/她主要的工作是什么?" },
  { section: 1, question: "他/她最后做的主要工作是什么?" },
  { section: 1, question: "他/她(或配偶)何时退休的? 什么原因退休的?" },
  { section: 2, question: "日期?" },
  { section: 2, question: "月份?" },
  { section: 2, question: "年份?" },
  { section: 2, question: "星期几?" },
  { section: 2, question: "当事情先后发生时他/她是否能判断清楚先后顺序?" },
  { section: 2, question: "他/她能否在熟悉的街道找到路?" },
  { section: 2, question: "他/她能否在自己家以外的地方知道如何从一个地方到另一个地方?" },
  { section: 2, question: "他/她是否在熟悉的室内找不到地方?" },
  { section: 3, question: "现在必须评估他/她解决问题的总体能力" },
  { section: 3, question: "评估他/她处理少量钱财的能力" },
  { section: 3, question: "评估他/她处理复杂财务或买卖的能力" },
  { section: 3, question: "他/她能否处理家庭中发生的紧急情况" },
  { section: 3, question: "他/她能明白所处的场合或其他人对某一问题的解释吗?" },
  { section: 3, question: "在社交场合或与他人交往时他/她的行为得体吗?" },
  { section: 4, question: "他/她仍在工作吗?" },
  { section: 4, question: "他/她决定退休是因为记忆减退或考虑问题困难吗?" },
  { section: 4, question: "他/她的记忆减退或考虑问题困难经常引起明显的工作困难吗?" },
  { section: 4, question: "他/她过去开过车或独自乘坐公共交通工具吗?" },
  { section: 4, question: "他/她现在是否还能够开车或独自乘坐公共交通工具?" },
  { section: 4, question: "假如不是是否由于记忆或思维问题?" },
  { section: 4, question: "如果他/她仍有开车或独自乘坐公共交通工具你认为是否他/她会因此而出现危险吗?" },
  { section: 4, question: "他/她能独立去购物吗?" },
  { section: 4, question: "他/她能独立外出活动吗?" },
  { section: 4, question: "有没有带他/她去参加家庭以外的社交活动?" },
  { section: 4, question: "一个偶尔看到他/她的行为的人会觉得他/她行为异常吗?" },
  { section: 4, question: "如果在养老院里他/她能很好地参加社交活动吗?" },
  { section: 4, question: "以上是否能够得到足够的信息来评定受试者参加社会活动的受损程度?" },
  { section: 5, question: "他/她做家务的能力有什么变化吗?" },
  { section: 5, question: "他/她现在还能做好哪些家务?" },
  { section: 5, question: "他/她参加业余爱好的能力有什么变化?" },
  { section: 5, question: "他/她还能做好哪些爱好的事情?" },
  { section: 5, question: "如果在养老院他/她再也无法做好哪些家务和爱好的事情了?" },
  { section: 5, question: "处理家务的能力" },
  { section: 5, question: "他/她做家务的能力以下哪个答案最合适" },
  { section: 5, question: "家务:如做饭、洗衣、打扫卫生、购买食品杂货、倒垃圾、整理院子、家庭用具简单维护" },
  { section: 5, question: "爱好:缝纫、绘画、手工艺、读书、接待客人、摄影、园艺、看电影或音乐会、做木工活、参与体育运动" },
  { section: 6, question: "穿衣" },
  { section: 6, question: "洗漱与梳妆打扮" },
  { section: 6, question: "吃饭" },
  { section: 6, question: "二便控制" },
  { section: 7, question: "你在记忆或思维方面有问题吗?" },
  { section: 7, question: "刚才你的配偶、子女等告诉我一些你最近经历的事。你能告诉我有关这些事情的一些情况吗?" },
  { section: 7, question: "我现在说一个姓名和地址请您记住。现在请跟我重复这个姓名和地址" },
  { section: 7, question: "你什么时候出生的?" },
  { section: 7, question: "你在什么地方出生的?" },
  { section: 7, question: "你最后就读的学校是?" },
  { section: 7, question: "在过去你从事的主要工作是什么? 假如没有工作配偶的主要工作是什么?" },
  { section: 7, question: "你最后从事的主要工作是什么? 假如没有工作配偶最后的主要工作是什么?" },
  { section: 7, question: "你(或配偶)何时退休的? 什么原因退休的?" },
  { section: 7, question: "请重复我刚才让您记住的姓名和地址" },
  { section: 8, question: "今天是几号?" },
  { section: 8, question: "今天是星期几?" },
  { section: 8, question: "现在是几月份?" },
  { section: 8, question: "今年是哪一年?" },
  { section: 8, question: "这里是什么地方?" },
  { section: 8, question: "我们现在在哪个城市或城镇?" },
  { section: 8, question: "不看手表现在大概几点了?" },
  { section: 8, question: "能告诉我陪你来的人是谁吗?" },
  { section: 9, question: "相似性: 萝卜和芹菜" },
  { section: 9, question: "相似性: 桌子和书架" },
  { section: 9, question: "区别: 撒谎和失误" },
  { section: 9, question: "区别: 河流和运河" },
  { section: 9, question: "计算: 10元等于多少个5角?" },
  { section: 9, question: "计算: 135元可换成多少个5元?" },
  { section: 9, question: "计算: 从20减去3再从每一个得数连续减3一直减下去" },
  { section: 9, question: "判断: 当你到达一个陌生的城市怎么找到当地的朋友?" },
  { section: 9, question: "判断: 受试者对其失能和日常生活状况的评估对他/她为什么到这儿来做检查的理解程度" }
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
          Text('CDR（Clinical Dementia Rating Worksheet）临床痴呆评定表')
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