import { Constants } from '../../common/Constants';
// import { Log } from '../../common/Log';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { AGCAuth } from '../../services/Auth';
import { Log } from '../../../../mainback/ets/common/Log';
import { TAG_SIZE } from '@hw-agconnect/cloud/src/main/ets/database/encrypt/SecretKeyManager';
import agconnect from '@hw-agconnect/api-ohos';

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

@Entry
@Component
struct Login {
  @State isEnabled: boolean = false; //控制登录按钮是否能点
  @State timer: number = 60;
  @State intervalId: number = -123456;
  @State telPhoneNum: string = '181*******' // 电话
  @State vCode: string = '8888' // 验证码
  @State isTest: Boolean = true;


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
  async getVcode(telphoneNum) {
    try {
      //调用方法下发验证码到手机上
      let rest = await AGCAuth.requestPhoneVerifyCode(telphoneNum)
      promptAction.showToast({ message: rest })
    } catch (err) {
      Log.error("[Login]", JSON.stringify(err))
      throw err
    }

  }

  async login() {
    // TODO 登录
    router.replaceUrl({ url: Constants.PAGE_INDEX })
    return;
    if (this.telPhoneNum.trim() === '' || this.vCode.trim() === '') {
      promptAction.showToast({ message: '手机号和验证码都必须输入', bottom: 400 })
      return;
    }
    try {
      //调用登录
      await AGCAuth.login(true, '+86', this.telPhoneNum, this.vCode)

      router.replaceUrl({ url: Constants.PAGE_INDEX })
    } catch (err) {
      Log.error("SBLogin", JSON.stringify(err))
      throw err
    }
  }

  build() {
    Row() {
      Column({ space: 24 }) {
        Image($r('app.media.ic_logo'))
          .margin({ top: 108 })
          .width(90)
          .aspectRatio(1)

        Text('欢迎使用阿尔兹海默症APP')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        TextInput({ placeholder: '请输入手机号', text: this.telPhoneNum })
          .commonStyle()

          .onChange(value => {
            this.telPhoneNum = value;
          })
          .height(48)

        Stack({ alignContent: Alignment.End }) {
          TextInput({ placeholder: '请输入验证码' })
            .commonStyle()
            .onChange(value => {
              this.vCode = value;
            })
            .height(48)
          Text(this.timer >= 60 ? '获取验证码' : `${this.timer}s 后可重新获取`)
            .fontSize(13)
            .fontColor('#2C80FF')
            .enabled(this.timer === 60)
            .onClick(() => {
              if (this.telPhoneNum.trim() === '') {
                promptAction.showToast({ message: '请先输入手机号码', bottom: 400 })
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

        // 底部三块区域
        Column() {
          Column({ space: 24 }) {
            Text('其他方式登录')
              .fontSize(12)
            // .margin({ top: 102 })

            Stack() {
              Rect()
                .width(30)
                .aspectRatio(1)
                .border({
                  style: BorderStyle.Solid,
                  color: '#2C80FF',
                  width: 1
                })
                .borderRadius(15)
                .fill(Color.Transparent)

              Image($r('app.media.email'))
                .width(12)
                .aspectRatio(1)
            }
            .onClick(() => {
              router.pushUrl({ url: Constants.PAGE_LOGIN_BY_EMAIL })
            })

            // 协议
            Row() {
              Radio({ value: 'login', group: 'login' })
                .width(16)
                .aspectRatio(1)
                .checked(this.isEnabled)
                .onClick(() => {
                  this.isEnabled = !this.isEnabled
                })
              // .onChange((value) => {
              //   if (value) {
              //     this.isEnabled = true;
              //   }
              // })

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
    .linearGradient({
      angle: 180,
      colors: [['#E9F2FF', 0.01], ['#FFF', 35.15]]
    })
  }
}