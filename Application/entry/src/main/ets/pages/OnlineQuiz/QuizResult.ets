import { Constants } from '../../common/Constants'

@Entry
@Component
struct QuizResult {
  list: string[] = Array.from({ length: 20 }, (_, index) => index + 1 + '');

  getOptionColor(index:number):ResourceColor{
    if(index<10){
      return Constants.RIGHT_FULL_COLOR
    }else if(index==11){
      return Constants.GRAY_FULL_COLOR
    }else{
      return Constants.ERROR_FULL_COLOR
    }
  }

  build() {
    Scroll() {

      Column() {
        // 标题
        Text('答题结果')
          .fontSize(18)
          .fontWeight(600)
          .padding(15)

        // 得分
        Column() {
          Stack({ alignContent: Alignment.Bottom }) {
            Gauge({ value: 30, min: 0, max: 100 })
              .startAngle(270)
              .endAngle(90)
              .colors([[Constants.BLUE_LIGHT_COLOR, 30], [Constants.GRAY_FULL_COLOR, 70]])
              .strokeWidth(20)
              .width(200)
            Column() {
              this.smallText('得分')
              Text('50')
                .fontSize(35)
                .fontWeight(900)
              this.smallText('/100')
              Row() {
                this.smallText('练习类型:')
                this.smallText('HarmonyOS应用开发高级认证')
              }
              .width('100%')
              .padding({ top: 50, bottom: 10 })
              .justifyContent(FlexAlign.SpaceBetween)

              Row() {
                this.smallText('交卷时间:')
                this.smallText('2024.01.01 12:00')
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
          }

        }
        .padding(20)
        .width('100%')
        .backgroundColor(Color.White)
        .borderRadius(10)


        // 考试情况
        Column() {
          Text('考试情况')
            .width('100%')
            .fontWeight(600)
            .padding({ top: 20, bottom: 10 })
          Row() {
            this.examItem('总题数', '20', '题', Constants.BLUE_LIGHT_COLOR)
            this.examItem('答对', '10', '题', Constants.RIGHT_FULL_COLOR)
            this.examItem('答错', '10', '题', Constants.ERROR_FULL_COLOR)
            this.examItem('总用时', '50', 'min', Constants.ERROR_FULL_COLOR)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(10)
        }


        // 答题卡
        Column() {
          Text('答题卡')
            .width('100%')
            .fontWeight(600)
            .padding({ top: 30, bottom: 10 })
          Column() {


            Row({ space: 15 }) {
              Text('单项选择题')
                .layoutWeight(1)
                .fontSize(14)
              Row({ space: 8 }) {
                Text()
                  .size({ width: 12, height: 12 })
                  .borderRadius(8)
                  .backgroundColor(Constants.GRAY_FULL_COLOR)
                Text('未答')
                  .fontSize(12)
              }

              Row({ space: 8 }) {
                Text()
                  .size({ width: 12, height: 12 })
                  .borderRadius(8)
                  .backgroundColor(Constants.RIGHT_FULL_COLOR)
                Text('答对')
                  .fontSize(12)
              }

              Row({ space: 8 }) {
                Text()
                  .size({ width: 12, height: 12 })
                  .borderRadius(8)
                  .backgroundColor(Constants.ERROR_FULL_COLOR)
                Text('答错')
                  .fontSize(12)
              }
            }
            .width('100%')
            .padding(15)
            // 答题卡选项
            Flex({ wrap: FlexWrap.Wrap }) {
              ForEach(this.list, (item: string) => {
                Row() {
                  Text(item)
                    .textAlign(TextAlign.Center)
                    .fontColor(Color.White)
                    .size({ width: 40, height: 40 })
                    .borderRadius(20)
                    .backgroundColor(this.getOptionColor(parseInt(item)))
                }
                .justifyContent(FlexAlign.Center)
                .width('20%')
                .aspectRatio(1)
              })
            }
          }
          .backgroundColor(Color.White)
          .borderRadius(10)
        }
      }
      .padding({ left: 15, right: 15, bottom: 50 })
      .width('100%')
      .linearGradient({
        colors: [
          ['#ccdffc', 0],
          [Constants.GRAY_LIGHT_COLOR, 1]
        ]
      })
    }
  }

  @Builder
  examItem(title: string, num: string, unit: string, fontColor: ResourceColor) {
    Column({ space: 15 }) {
      Text(title)
        .fontSize(13)
      Text() {
        Span(num)
          .fontSize(16)
          .fontColor(fontColor)
        Span(unit)
          .fontColor(fontColor)
          .fontSize(12)
      }
    }
  }

  @Builder
  smallText(text: string, fontSize: number = 12) {
    Text(text)
      .fontSize(fontSize)
      .fontColor(Color.Gray)
  }
}