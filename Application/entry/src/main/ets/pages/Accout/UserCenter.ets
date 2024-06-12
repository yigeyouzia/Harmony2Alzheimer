@Extend(Column) function setColumnStyle(height) {
  .height(height)
  .width('90%')
  .margin({ left: 16, right: 16 })
  .backgroundColor(Color.White)
  .borderRadius(8)
}

@Extend(Text) function setTextStyle() {
  .fontSize(10)
  .fontColor('#979797')
  .margin({ top: 10 })
}

@Extend(Text) function setTextStyle1() {
  .fontSize(14)
  .fontWeight(400)
  .padding(16)
}

import { BindEmailDialog } from '../../components/Accout/BindEmailDialog';
import Prompt from '@system.prompt';
import router from '@ohos.router';
import { Constants } from '../../common/Constants';

@Entry
@Component
export struct UserCenter {
  @State isLink: boolean = true; // true：关联  false：解绑
  @State telPhoneNum: string = '18888888888'

  // 定义自定义弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: BindEmailDialog(),
    customStyle: true,
    autoCancel: true
  })

  build() {

    Row() {
      Column({ space: 20 }) {
        // 用户昵称和头像部分
        Stack() {
          Column() {
            // 头像+昵称
            Column() {
              Image($r('app.media.user_dark'))
                .width(64)
                .aspectRatio(1)
                .interpolation(ImageInterpolation.High) //减轻低清晰度图片在放大显示时出现的锯齿问题

              Text('用户昵称')
                .fontSize(16)
                .fontWeight(400)
                .fontColor('#2B364B')
                .margin({ top: 12 })
            }
            .position({ x: 16, y: -32 })

            Row({ space: 35 }) {
              //   已刷题
              Column() {
                Text('已刷题数(道)')
                  .setTextStyle()
                Text('40')
                  .fontWeight(400)
                  .padding({ top: 5 })
              }
              //   错题数
              Column() {
                Text('错题数量(道)')
                  .setTextStyle()
                Text('40')
                  .fontWeight(400)
                  .padding({ top: 5 })
              }
              .padding({ right: 20 })
            }
            .height(80)
            .position({ x: '100%', y: 0 })
            .translate({ x: '-100%' })
          }
          .setColumnStyle(80)
        }
        .margin({ top: 88 })

        // 手机号码，上次登录时间部分
        Column() {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text('手机号码')
              .setTextStyle1()
            Text(this.telPhoneNum)
              .setTextStyle1()
          }
          .height(44)

          Divider()
            .color('rgba(0,0,0,0.05)')
            .width('90%')

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text('上次登录时间')
              .setTextStyle1()
            Text('2023/12/21 13:21')
              .setTextStyle1()
          }
          .height(44)
        }
        .setColumnStyle(88)


        // 登出
        Column() {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Text('登出')
              .setTextStyle1()
              .onClick(() => {
                this.loginOut()
              })
            Row() {
              Image($r('app.media.ic_right'))
                .width(16)
                .aspectRatio(1)
                .fillColor(Color.Gray)
            }
            .layoutWeight(1)
            .height(44)
            .justifyContent(FlexAlign.End)
          }
          .height(44)
        }
        .setColumnStyle(44)
      }
      .width('100%')
      .height('100%')

    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#E9F2FF', 0.01], ['#fff', 100]]
    })
  }

  loginOut(): void {
    router.replaceUrl({url:Constants.PAGE_LOGIN})
  }
}