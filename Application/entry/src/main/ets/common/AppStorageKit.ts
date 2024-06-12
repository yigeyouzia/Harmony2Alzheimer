import dataPreferences from '@ohos.data.preferences' // 导入首选项
import { AgUser } from '../services/AgUser';
import { QATopModel } from '../models/models';
import { Constants } from './Constants';


export class AppStorageKit {
  static async SetLoginUser<T>(data: T, context) {
    // 保存数据到内存中
    AppStorage.SetOrCreate<T>('user', data);

    // 保存数据到首选项(磁盘持久化)
    const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
    store.put(Constants.LOGIN_USER, JSON.stringify(data));
    await store.flush(); // 将数据保存到磁盘
  }

  static async GetLoginUser<T>(context) {
    // 保存数据到首选项(磁盘持久化)
    const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
    let res = await store.get(Constants.LOGIN_USER, "{}");
    return JSON.parse(res.toString()) as AgUser;
  }

  static async DelLoginUser<T>(context) {
    AppStorage.Delete('user');

    // 保存数据到首选项(磁盘持久化)
    const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
    await store.delete(Constants.LOGIN_USER);
    await store.flush();
  }

  static async SetRanking<T>(data: T, context) {
    // 保存数据到首选项(磁盘持久化)
    const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
    store.put("ranking", JSON.stringify(data));
    await store.flush(); // 将数据保存到磁盘
  }

  static async GetRank(context) {
    // 保存数据到首选项(磁盘持久化)
    const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
    let res = await store.get("ranking", "{}");
    return JSON.parse(res.toString()) as QATopModel[];
  }

  // // 以数组的形式保存卡片id
  // static async SetCarID(cardID, context) {
  //   try {
  //     // 保存数据到首选项(磁盘持久化)
  //     const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
  //     let res = await store.get("cardid", "[]");
  //     let resobj: string[] = JSON.parse(res.toString()) as string[];
  //     if (!resobj.includes(cardID)) {
  //       resobj.push(cardID);
  //     }
  //     store.put("cardid", JSON.stringify(resobj));
  //     await store.flush(); // 将数据保存到磁盘
  //     console.log('AppStorageKit SetCarID success cardID:',cardID);
  //     let ret = await store.get("cardid", "[]");
  //     return ret.toString();
  //   } catch (err) {
  //     console.log('AppStorageKit SetCarID error', JSON.stringify(err));
  //     return 'AppStorageKit SetCarID error' + JSON.stringify(err);
  //   }
  // }
  //
  // static async GetCarkIds(context) {
  //   try {
  //     // 保存数据到首选项(磁盘持久化)
  //     const store = await dataPreferences.getPreferences(context, Constants.PREFERENCES_STORE);
  //     let res = await store.get("cardid", "[]");
  //     console.log('AppStorageKit GetCarkID success',res);
  //     return JSON.parse(res.toString()) as string[];
  //   } catch (err) {
  //     console.log('AppStorageKit GetCarkID error', JSON.stringify(err));
  //     return ['AppStorageKit GetCarkID error' + JSON.stringify(err)];
  //   }
  // }
}