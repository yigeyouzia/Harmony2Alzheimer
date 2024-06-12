@Component
export default struct ChapterItem {
  title: string = '默认标题' // 标题
  isHard: boolean = false // 难易
  isDone: boolean = false // 是否做题

  build() {
    Column({ space: 20 }) {
      Text(this.title)
        .alignSelf(ItemAlign.Start)
      Row() {
        this.tagBuilder(this.isHard)
        Blank()
        Row() {
          if (this.isDone) {

            // 未做题
            Text('暂未做题')
              .fontSize(13)
          } else {
            // 已完成
            Text() {
              Span('已完成')
                .fontSize(13)
                .fontColor('#00a4fa')
              Span(' | 得分:90')

            }
            .fontSize(13)
          }

        }
      }
      .width('100%')
    }
    .width('100%')
    .padding({ top: 20, left: 15, right: 15, bottom: 20 })
  }

  @Builder
  tagBuilder(isHard: boolean) {
    Text(isHard ? '困难' : '简单')
      .fontColor(isHard ? '#ff9670' : '#00bf67')
      .backgroundColor(isHard ? '#fff6ed' : '#f0f9ec')
      .fontSize(12)
      .padding({ top: 3, left: 8, right: 8, bottom: 3 })
  }
}