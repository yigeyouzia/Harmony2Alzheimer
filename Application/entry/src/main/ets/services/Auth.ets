
import agconnect from '@hw-agconnect/api-ohos'
import { AGConnectUser,SignInResult } from '@hw-agconnect/auth-ohos';
import '@hw-agconnect/auth-ohos';
import { PhoneAuthProvider,EmailAuthProvider, VerifyCodeSettingBuilder } from '@hw-agconnect/auth-ohos';
import { AgUser } from './AgUser'

import { Log } from '../common/Log';
import { AppStorageKit } from '../common/AppStorageKit';


const TAG = "[AGCAuth]";

export class AGCAuth {

  //1.0获取当前登录用户的对象
  public static async getCurrentUser(): Promise<AGConnectUser> {
    try {
      return await agconnect.auth().getCurrentUser();
    }catch(err){
      Log.error(TAG,JSON.stringify(err))
      throw err
    }

  }

  //2.0 下发手机验证码
  public static async requestPhoneVerifyCode( phone: string,ctrCode: string = '+86',) {
    try {
      let verifyCodeSettings = new VerifyCodeSettingBuilder()
        .setAction(1001)
        .setLang('zh_CN')
        .setSendInterval(60)
        .build();

      let ret = await agconnect.auth().requestPhoneVerifyCode(
        ctrCode,
        phone,
        verifyCodeSettings);

      return '验证码获取成功';
    }catch (err){
      return '验证码获取失败:'+JSON.stringify(err);
    }
  }
  // 获取用户头像
  static async getImg(uid) {
    return "https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/defaultAvatar%2Fic_public_avatar1.png?token=ec5c702d-9ed9-4caf-ac7f-4ca205c70e68";
    /*
      const headImgs = await DatabaseHelper.userHeadImg_Query_By_uid(uid);
      if(headImgs && headImgs.length>0){
        return headImgs[0].imgurl;
      }else{
        return 'https://agc-storage-drcn.platform.dbankcloud.cn/v0/hmqa-bbnx2/user_dark.png?token=74d1ae76-2075-4ab2-b702-74ee968eb6ed';
      }
      */
  }
  public static async Change(user: AGConnectUser) {
    try {
      let imgurl = await AGCAuth.getImg(user.getUid());
      let userExtra = await user.getUserExtra();

      let loginRes = new AgUser(
        user.getUid(),
        imgurl,
        user.getPhone(),
        user.getEmail(),
        user.getDisplayName(),  // 获取不到昵称 -> 采用截取 手机号码或者邮箱地址一部分用来作为用户的昵称
        userExtra.getCreateTime(),
        userExtra.getLastSignInTime()
      );

      return loginRes;
    } catch (err) {
      console.log("SB_login_change_err", JSON.stringify(err))
      throw err
    }
  }

  //登录 手机号验证码登录/邮箱验证码登录
  public static async login(isPhone:boolean,
    countryCode: string, userName: string, verifyCode: string): Promise<AgUser> {
    // let credential = EmailAuthProvider.credentialWithVerifyCode(userName, verifyCode);
    // if (isPhone) {
    //   credential = PhoneAuthProvider.credentialWithVerifyCode(countryCode,userName,verifyCode)
    // }
    // let userResult:SignInRequest = await agconnect.auth().signIn(credential)
    // let agcUser = userResult.get
    try {
      // 用新账号登录之前，需要把已经登录过的用户退出
      await AGCAuth.logout()
      let credential = EmailAuthProvider.credentialWithVerifyCode(userName, verifyCode);
      if (isPhone) {
        credential = PhoneAuthProvider.credentialWithVerifyCode(countryCode, userName, verifyCode);
      }

      // 处理返回结果
      // 获取到了用户登录的信息
      let userResult: SignInResult = await agconnect.auth().signIn(credential);
      let agcUser: AGConnectUser = userResult.getUser();

      // 将agcUser转换成AgUser
      let user: AgUser = await AGCAuth.Change(agcUser)


      // 将user数据保存到首选项中同时保存到AppStorage中
      AppStorageKit.SetLoginUser<AgUser>(user, getContext(this))

      return user

    } catch (err) {
      // Log.error(TAG, JSON.stringify(err).slice(0,800))
      console.log('SB_login_fail',JSON.stringify(err).slice(0,800))
      throw err
    }

  }

  public static async logout() {
    try {
      await agconnect.auth().signOut()
    }catch(err){
      Log.error(TAG,JSON.stringify(err))
    }

  }


}


