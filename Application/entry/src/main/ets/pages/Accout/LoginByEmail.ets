import { Constants } from '../../common/Constants'
import Prompt from '@system.prompt';

@Extend(TextInput) function commonStyle() {
  .width(280)
  .height(40)
  .backgroundColor('#fff')
  .placeholderColor('#979797')
  .fontColor('#979797')
}

@Extend(Button) function commonButtonStyle() {
  .width(280)
  .height(48)
}

@Entry
@Component
struct LoginByEmail {
  @State isEnabled: boolean = false; //控制登录按钮是否能点
  @State timer: number = 60;
  @State intervalId: number = -123456;
  @State telPhoneNum: string = '' // 电话
  @State vCode: string = '' // 验证码

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
  getVcode(telphoneNum) {
    Prompt.showToast({ message: telphoneNum })
  }

  login(): void {
    if (this.telPhoneNum.trim() === '' || this.vCode.trim() === '') {
      Prompt.showToast({ message: '邮箱和验证码都必须输入', bottom: 400 })
      return;
    }

    AlertDialog.show({ message: `${this.telPhoneNum} - ${this.vCode}` })
  }

  aboutToAppear() {

  }

  build() {
    Row() {
      Column() {
        Text('邮箱登录')
          .fontSize(18)
          .margin({ top: 20, bottom: 20 })
        Column({ space: 24 }) {
          TextInput({ placeholder: '请输入邮箱号' })
            .commonStyle()
            .onChange(value => {
              this.telPhoneNum = value;
            })


          Stack({ alignContent: Alignment.End }) {
            TextInput({ placeholder: '请输入验证码' })
              .commonStyle()
              .onChange(value => {
                this.vCode = value;
              })
            Text(this.timer >= 60 ? '获取验证码' : `${this.timer}s 后可重新获取`)
              .fontSize(13)
              .fontColor('#2C80FF')
              .margin({ right: 15 })
              .enabled(this.timer === 60)
              .onClick(() => {
                if (this.telPhoneNum.trim() === '') {
                  Prompt.showToast({ message: '请先输入邮箱号码', bottom: 400 })
                  return;
                }
                this.startTimer();
                this.getVcode(this.telPhoneNum);
              })
          }

          Button('登录')
            .enabled(this.isEnabled)
            .commonButtonStyle()
            .onClick(() => {
              this.login();
            })
        }

        // 底部三块区域
        Column() {
          Column({ space: 24 }) {
            // 协议
            Row() {
              Radio({ value: 'login', group: 'login' })
                .width(16)
                .aspectRatio(1)
                .onChange((value) => {
                  if (value) {
                    this.isEnabled = true;
                  }
                })

              Text('登录即同意《用户使用协议》和《隐私政策》')
                .fontSize(12)
                .fontColor('#979797')

            }
          }
          .padding({ bottom: 20 })
          .translate({ y: '-100%' })
        }
        .width('100%')
        .position({ x: 0, y: '100%' })
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
    .backgroundColor('#F5F7F9')
  }
}