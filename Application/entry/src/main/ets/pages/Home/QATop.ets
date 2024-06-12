// 此组件作用：用来单独呈现答题排行榜

@Extend(Text) function setTextStyle() {
  .fontSize(13)
  .fontWeight(400)
  .fontColor('#6F7579')
}

@Component
export struct QATTop {

  // 排名：1,2,3调用
  @Builder TopListItem(index: number, nickname: string, score: number) {
    Stack({ alignContent: Alignment.Start }) {
      if (index === 0) {
        Image($r("app.media.ic_1"))
          .height(48)
      } else if (index == 1) {
        Image($r("app.media.ic_2"))
          .height(48)
      } else {
        Image($r("app.media.ic_3"))
          .height(48)
      }

      Row({ space: 8 }) {
        Image($r("app.media.kefu"))
          .height(40)
          .aspectRatio(1)
        Text(nickname)
          .fontSize(13)
          .fontWeight(400)
        Blank()
        Text(score + '')
      }
      .padding({ left: 65 })
      .width('100%')
    }
    .clip(false)
  }

  @Builder TopListItemOther(index: number, nickname: string, score: number) {
    Row() {
      Text(`${index + 1}`)
        .padding({ left: 16 })
      Row({ space: 8 }) {
        Image($r("app.media.kefu"))
          .height(30)
          .aspectRatio(1)
          .margin({ right: 5 })
        Text(nickname)
          .fontSize(13)
          .fontWeight(400)
        Blank()
        Text(score + '')
      }
      .layoutWeight(1)
      .padding({ left: 45 })
    }
    .width('100%')

    .height(48)
  }

  build() {

    Row() {
      Column() {
        Text('答题排行榜')
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(500)
          .padding({ top: 10, bottom: 12 })
        // 排行榜
        Column() {
          // 表头
          Row() {
            Text('排名')
              .setTextStyle()
              .width(60)
            Text('昵称')
              .setTextStyle()
              .layoutWeight(2)
            Text('答题成绩')
              .textAlign(TextAlign.End)
              .setTextStyle()
          }
          .padding({ bottom: 12, left: 9 })

          // 内容
          Scroll() {
            Column({ space: 10 }) {
              ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item, index) => {
                if (index < 3) {
                  this.TopListItem(index, '188****8888', 100 - index)
                } else {
                  this.TopListItemOther(index, '186****8888', 80 - index)
                }

              }, item => item)
            }
          }
          .width('100%')
          .scrollBar(BarState.Off)
          .scrollable(ScrollDirection.Vertical)
        }
        .clip(true)
        .width('100%')
        .height(395)
        .borderRadius(10)
        .backgroundColor(Color.White)
        .padding({ top: 10, left: 7, right: 15, bottom: 50 })
        .shadow({ radius: 10, color: '#CAD4E8', offsetX: 10, offsetY: 10 })
      }
      .width('100%')
      .height('100%')
      .padding(16)

    }
    .width('100%')
    .height('100%')
  }
}