import promptAction from '@ohos.promptAction'
import AnswerOptionItem from './AnswerOptionItem'


@Entry
@Component
struct QuizIndex {
  rightAnswer: string = 'A'
  selectedAnswer: string = 'B'

  build() {
    Column() {
      Column() {
        // 顶部
        Stack({ alignContent: Alignment.End }) {
          Text('答案解析')
            .width('100%')
            .fontSize(18)
            .fontWeight(600)
            .textAlign(TextAlign.Center)
          Image($r('app.media.ic_allread'))
            .width(20)
            .aspectRatio(1)

        }
        .width('100%')
        .padding({ top: 10, bottom: 20, })

        // 进度条
        Row() {
          Progress({ value: 1, total: 10 })
            .margin({ right: 10 })
            .layoutWeight(1)
          Text() {
            Span('1')
              .fontWeight(900)
              .fontColor(Color.Gray)
            Span('/10')
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

        // 题目内容
        Column({ space: 16 }) {
          Text('Vue最大的优势是什么?')
            .width('100%')
          Column({ space: 8 }) {
            ForEach(['A', 'B', 'C', 'D'], (item: string) => {
              AnswerOptionItem({
                isSelected: item === this.selectedAnswer,
                isRight: this.rightAnswer === item,
                letter: item
              })
            })
          }
        }
        .width('100%')
        .margin({ top: 10 })

        // 答案
        Column({ space: 30 }) {
          Column() {
            Text('答案')
              .fontWeight(600)
              .fontSize(18)
              .width('100%')
              .margin({ bottom: 20 })
            Row() {
              Text() {
                Span('正确答案: ')
                Span('A')
                  .fontColor('#00cc9f')
              }
              .layoutWeight(1)

              Text() {
                Span('你的答案: ')
                Span('A')
                  .fontColor('#f83b43')
              }
              .layoutWeight(1)
            }
          }

          Column() {
            Text('解析')
              .fontWeight(600)
              .fontSize(18)
              .width('100%')
              .margin({ bottom: 20 })
            Row() {
              Text() {
                Span('正确答案: ')
                Span('A')
                  .fontColor('#00cc9f')
              }
              .layoutWeight(1)

            }
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 30 })
      }
      .padding({ left: 15, right: 15 })
      .layoutWeight(1)

      // 切换上一题 下一题
      Row() {
        Row() {
          Image($r('app.media.ic_left'))
            .width(18)
            .aspectRatio(1)
            .margin({ right: 15 })
          Text('上一题')
        }
        .opacity(.5)
        .layoutWeight(1)

        Row() {
          Text('下一题')
            .margin({ right: 15 })
          Image($r('app.media.ic_right'))
            .width(18)
            .aspectRatio(1)
        }
        .justifyContent(FlexAlign.End)
        .layoutWeight(1)
      }
      .height(50)
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f9f9f9')
  }
}