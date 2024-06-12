import { Event } from '@ohos.worker'
import { Constants } from '../../common/Constants'

class OptionStyle {
  width: number = 0
  borderColor: string | Color = Color.Transparent
  backgroundColor: string | Color = Color.White
  fontColor: string | Color = Color.Black
  showIcon: boolean = false
  icon:Resource|string = ''
}

@Component
export default struct OptionItem {
  label: string = '默认选项'
  letter: string = 'A'
  isSelected: boolean = false
  isRight: boolean = false
  optionStyle: OptionStyle = new OptionStyle()

  aboutToAppear() {
    if (this.isSelected === true) {
      // 被选中，但不是正确选项，使用错误色
      this.optionStyle.width = 1
      this.optionStyle.borderColor = Constants.ERROR_FULL_COLOR
      this.optionStyle.backgroundColor = Constants.ERROR_HALF_COLOR
      this.optionStyle.fontColor = Constants.ERROR_FULL_COLOR
      this.optionStyle.icon = $r('app.media.ic_public_cancel')
    }
    if (this.isRight === true) {
      // 被选中，而且是正确的，使用正确色
      this.optionStyle.width = 1
      this.optionStyle.borderColor = Constants.RIGHT_FULL_COLOR
      this.optionStyle.backgroundColor = Constants.RIGHT_HALF_COLOR
      this.optionStyle.fontColor = Constants.RIGHT_FULL_COLOR
      this.optionStyle.icon = $r('app.media.ic_public_ok')
    }
  }

  build() {
    Row() {
      Row() {
        Row() {
          Text(`${this.letter}.`)
            .fontColor(this.optionStyle.fontColor)
            .margin({ right: 15 })
          Text(this.label)
        }
        .layoutWeight(1)

        Image(this.optionStyle.icon)
          .width(20)
          .fillColor(this.optionStyle.borderColor)
      }
      .width('100%')
      .height('100%')
      .padding(15)
    }
    .border({
      width: this.optionStyle.width,
      color: this.optionStyle.borderColor
    })
    .width('100%')
    .height(50)
    .backgroundColor(this.optionStyle.backgroundColor)
    .borderRadius(10)
  }
}