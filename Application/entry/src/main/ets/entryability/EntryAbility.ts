import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Window from '@ohos.window';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import { initialize } from '@hw-agconnect/hmcore';
import json from '../../resources/rawfile/agconnect-services.json';
import agconnect from '@hw-agconnect/api-ohos';
import "@hw-agconnect/core-ohos";
export default class EntryAbility extends UIAbility {
  onCreate() {
    let AtManager = abilityAccessCtrl.createAtManager();
    AtManager.requestPermissionsFromUser(this.context, ['ohos.permission.READ_MEDIA', 'ohos.permission.MEDIA_LOCATION']).then((data) => {
      hilog.info(0x0000, 'testTag', '%{public}s', 'request permissions from user success' + data);
    }).catch((err) => {
      hilog.error(0x0000, 'testTag', 'Failed to request permissions from user. Cause: %{public}s', JSON.stringify(err) ?? '');
    });
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    // 初始化 agconnect和 hmcore，保证认证和db访问可正常
    agconnect.instance().init(this.context);
    initialize(this.context,json);
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: Window.WindowStage) {

    // 1. 开启沉浸式状态栏
    // this.setStateBar(windowStage);

    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/Accout/Login', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }


  setStateBar(windowStage){
    //   开启沉浸式状态栏
    // 1.获取应用主窗口。
    let windowClass = null;
    windowStage.getMainWindow((err, data) => {

      if (err.code) {
        console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }

      windowClass = data;
      console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));


      // 2.实现沉浸式效果：设置导航栏、状态栏不显示。
      let names = [];
      windowClass.setWindowSystemBarEnable(names, (err) => {
        if (err.code) {
          console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in setting the system bar to be visible.');
      });

      windowClass.setWindowLayoutFullScreen(true)
    })
  }
}
