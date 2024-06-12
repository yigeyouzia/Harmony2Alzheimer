import { Constants } from '../../common/Constants'
import Prompt from '@system.prompt';


@Extend(TextInput) function commonStyle() {
  .width(280)
  .height(40)
  .backgroundColor('#F9F9F9')
  .placeholderColor('#979797')
  .fontColor('#979797')
}

@Extend(Button) function commonButtonStyle() {
  .width(280)
  .height(48)
}

@CustomDialog
export struct BindEmailDialog {
  @State isEnabled: boolean = false; //控制登录按钮是否能点
  @State timer: number = 60;
  @State intervalId: number = -123456;
  @State EmailAddress: string = '' // 邮箱
  @State vCode: string = '' // 验证码

  // 自动注入自定义弹窗对象，方便调用close方法自己关闭自己
  controller: CustomDialogController = undefined


  // 获取验证码倒计时
  startTimer(): void {
    this.timer = 59;
    this.intervalId = setInterval(() => {
      this.timer--;
      if (this.timer === 0) {
        clearInterval(this.intervalId);
        this.timer = 60;
      }
    }, 1000);
  }

  // 获取验证码
  getVcode(EmailAddress) {
    Prompt.showToast({ message: EmailAddress })
  }

  login(): void {
    if (this.EmailAddress.trim() === '' || this.vCode.trim() === '') {
      Prompt.showToast({ message: '邮箱和验证码都必须输入', bottom: 400 })
      return;
    }

    AlertDialog.show({ message: `${this.EmailAddress} - ${this.vCode}` })
  }

  aboutToAppear() {

  }

  build() {
    Row() {
      Column() {
        Flex({justifyContent:FlexAlign.SpaceBetween}){
            Text('关联邮箱账号')
              .fontSize(16)
              .fontWeight(400)

            Image($r('app.media.ic_public_close_filled'))
              .width(25)
              .aspectRatio(1)
              .fillColor('rgba(0,0,0,0.5)')
              .onClick(()=>{
                this.controller.close();
              })

        }
        .width(300)
        .margin({bottom:30,top:14})

        Column({ space: 24 }) {
          TextInput({ placeholder: '请输入邮箱号' })
            .commonStyle()
            .onChange(value => {
              this.EmailAddress = value;
            })

          Stack() {
            TextInput({ placeholder: '请输入验证码' })
              .commonStyle()
              .onChange(value => {
                this.vCode = value;
              })

            Text(this.timer >= 60 ? '获取验证码' : `${this.timer}s 后可重新获取`)
              .height(40)
              .fontSize(13)
              .fontColor('#2C80FF')
              .lineHeight(40)
              .margin({ left: 215 })
              .enabled(this.timer === 60)
              .onClick(() => {
                if (this.EmailAddress.trim() === '') {
                  Prompt.showToast({ message: '请先输入邮箱号码', bottom: 400 })
                  return;
                }
                this.startTimer();
                this.getVcode(this.EmailAddress);
              })
          }

          Button('关联账号')
            .commonButtonStyle()
            .onClick(() => {
              this.login();
            })
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .translate({y:'30%'})
    .backgroundColor('#fff')
    .padding({bottom:20})
  }
}