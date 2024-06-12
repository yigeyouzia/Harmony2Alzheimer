import { CommonActionButton } from '../components/CommonActionButton';
import { Constants } from '../common/Constants';

@Component
export struct AuthResultView {
  public onLoginPressed: Function;
  @State isEditingDisplayName: boolean = false;
  @State displayNameText: string = ''
  @State canLogOut: boolean = true;
  @State loginButtonEnableState: boolean = true;

  aboutToAppear() {
  }

  async logout() {
    this.canLogOut = false

  }

  async deleteUser() {
    this.canLogOut = false

  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
      CommonActionButton({
        title: $r('app.string.auth_service_login_button_text'),
        color: $r('app.color.start_window_background'),
        backColor: $r('app.color.action_button_background'),
        onAction: () => {
          this.onLoginPressed();
        },
        isEnabled: $loginButtonEnableState
      })
      Column() {
        Image($r('app.media.app_icon'))
          .width(Constants.LENGTH_70_PX)
          .height(Constants.LENGTH_70_PX)
        Image($r("app.media.user_dark"))
          .width(Constants.LENGTH_70_PX)
          .height(Constants.LENGTH_70_PX)

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text($r('app.string.auth_result_mobile_number'))
            .fontSize($r('app.float.body_font_size'))
          Text('123')
            .fontSize($r('app.float.body_font_size'))
        }
        .margin({ top: Constants.LENGTH_10_PX, bottom: Constants.LENGTH_10_PX })

        Divider()
          .color($r('app.color.placeholder_background'))

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text($r('app.string.auth_result_registered'))
            .fontSize($r('app.float.body_font_size'))
          Text('134')
            .fontSize($r('app.float.body_font_size'))
        }
        .margin({ top: Constants.LENGTH_10_PX, bottom: Constants.LENGTH_10_PX })

        Divider()
          .color($r('app.color.placeholder_background'))

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text($r('app.string.auth_result_last_login'))
            .fontSize($r('app.float.body_font_size'))
          Text('12')
            .fontSize($r('app.float.body_font_size'))
        }
        .margin({ top: Constants.LENGTH_10_PX, bottom: Constants.LENGTH_10_PX })
      }
      .margin({ left: Constants.LENGTH_30_PX, right: Constants.LENGTH_30_PX, top: Constants.LENGTH_20_PX })
      .padding(Constants.LENGTH_15_PX)
      .border({ width: Constants.LENGTH_1_PX, color: $r('app.color.placeholder_background') })

      Column() {
        CommonActionButton({
          title: $r('app.string.auth_service_delete_user_button_text'),
          color: $r('app.color.black'),
          backColor: $r('app.color.start_window_background'),
          borderW: Constants.LENGTH_1_PX,
          borderC: $r('app.color.black'),
          onAction: () => {
            this.deleteUser();
          },
          isEnabled: $canLogOut
        })
          .margin({ top: Constants.LENGTH_10_PX })

        CommonActionButton({
          title: $r('app.string.auth_service_logout_button_text'),
          color: $r('app.color.black'),
          backColor: $r('app.color.start_window_background'),
          borderW: Constants.LENGTH_1_PX,
          borderC: $r('app.color.black'),
          onAction: () => {
            this.logout();
          },
          isEnabled: $canLogOut
        })
          .margin({ top: Constants.LENGTH_10_PX })
      }

    }
    .height(Constants.PERCENT_90)
  }

  formatDate(date: String): string {
    if (date) {
      let d = new Date(parseInt(date.toString()));

      let ymd = d
        .toISOString()
        .replace('-', '/')
        .split('T')[0]
        .replace('-', '/');

      let hours = d.getHours()
                    .toString()
                    .length < 2 ? "0" + d.getHours() : d.getHours();

      let minutes = d.getMinutes()
                      .toString()
                      .length < 2 ? "0" + d.getMinutes() : d.getMinutes();

      let seconds = d.getSeconds()
                      .toString()
                      .length < 2 ? "0" + d.getSeconds() : d.getSeconds();

      let hm = hours + ':' + minutes + ':' + seconds;

      return ymd + ' ' + hm;
    }
  }
}