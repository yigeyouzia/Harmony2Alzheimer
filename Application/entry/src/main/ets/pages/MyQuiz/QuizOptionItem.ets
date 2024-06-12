@Preview
@Component
export default struct OptionItem {
  label: string = '默认选项'
  isSelected: boolean = true


  build() {
    Stack() {
      if (this.isSelected) {
        Row()
          .width('100%')
          .height('100%')
          .linearGradient({ colors: [['#00bffa', 0], ['#0074f4', 1]] })
          .borderRadius(10)

      }

      Row() {
        Text() {
          Span(this.label)
        }
        .fontColor(this.isSelected ? Color.White : Color.Black)
      }
      .width('100%')
      .height('100%')
      .padding(15)
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}