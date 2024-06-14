import { TypeItem } from '../../components/BrushQuest/TypeItem' //练习列表项组件
import router from '@ohos.router'

interface title {
  section: string,
  name: string
}

const QuizName: title[] = [
  { section: 'pages/MyQuiz/MyQuizIndex1', name: "简易智能状态检查中文版" },
  { section: 'pages/MyQuiz/MyQuizIndex2', name: "CDR（Clinical Dementia Rating Worksheet）临床痴呆评定表" },
  { section: 'pages/MyQuiz/MyQuizIndex3', name: "MoCA （Montreal Congnive Assessment）蒙特利尔认知评估" }
]

@Entry
@Component
export struct QList {
  @State QuizNames: title[] = QuizName;
  @State basePath: string = "pages/MyQuiz/MyQuizIndex";

  build() {
    Row() {
      Column({ space: 15 }) {
        ForEach(this.QuizNames, (item: title, index) => {
          TypeItem({ title_name: item.name })
            .onClick(() => {
              router.pushUrl({ url: item.section, params: { typeid: index } })
            })
        })
      }
      .width('100%')
      .height('100%')
      .padding(15)
    }
    .height('100%')
    .backgroundColor('#F5F7F9')
  }
}