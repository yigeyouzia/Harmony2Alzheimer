import agconnect from '@hw-agconnect/api-ohos';
import "@hw-agconnect/core-ohos";
import '@hw-agconnect/cloudstorage-ohos';
import picker from '@ohos.file.picker';
import fs from '@ohos.file.fs';

import emitter from "@ohos.events.emitter";

export default class UploadForGac {

  // emit订阅事件
  // callback:回调函数
  static emitOn(callback){
    // 定义一个eventId为1的事件
    let event = {
      eventId:1
    };

    // 收到eventId为1的事件后执行该回调
    // let callback = (eventData) => {
    //   console.info('event callback');
    // };

    // 订阅eventId为1的事件
    emitter.on(event, callback);
  }

  // emit发送事件
  static emitSend(sendData){
    // 定义一个eventId为1的事件，事件优先级为Low
    let event = {
      eventId: 1,
      priority: emitter.EventPriority.LOW
    };

    // let eventData = {
    //   data: {
    //     "content": "c",
    //     "id": 1,
    //     "isEmpty": false,
    //   }
    // };
    let eventData = {
      data: sendData
    };

    // 发送eventId为1的事件，事件内容为eventData
    emitter.emit(event, eventData);
  }

  // 统一调用上传方法
  /**
   * maxSelectNumber:限制用户选择的图片数量
   * */

  static async UploadImage(maxSelectNumber: number = 1): Promise<string[]> {
    return new Promise(async (resolve,reject)=>{
      try {
        // 1. 获取用户选择的图片地址
        let paths = await UploadForGac.SelectImage(maxSelectNumber);

        // 2.将图片地址转为Buffer
        let cloudStoragePaths = [];
        paths.forEach(async (path,index) => {
          let buffer = await UploadForGac.ReadBufferFromPath(path);
          let cloudStorageFilePath = await UploadForGac.uploadFileToGac(buffer);
          console.log("cloudStorageFilePath:", cloudStorageFilePath);

          cloudStoragePaths.push(cloudStorageFilePath);
          console.log("云存储地址数组:", cloudStoragePaths.length);

          if(index >= paths.length -1 ){
            resolve(cloudStoragePaths);
          }
        })
        // console.log("云存储地址数组 foreach外面:", cloudStoragePaths.length);
        // return cloudStoragePaths;
      } catch (err) {
        let errStr = JSON.stringify(err).slice(0, 800);
        console.log('往GAC上传图片错误:' + errStr);
        reject([]);
      }
    })
  }

  // 1. 选择图片
  // maxSelectNumber:允许选择图片的最大数量，默认为1张
  static async SelectImage(maxSelectNumber: number = 1): Promise<string[]> {
    try {
      // 1. 通过filepicker选取文件
      const photoSelectOptions = new picker.PhotoSelectOptions();
      photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
      photoSelectOptions.maxSelectNumber = maxSelectNumber; // 选择媒体文件的最大数目
      const photoViewPicker = new picker.PhotoViewPicker();

      let photoSelectResult = await photoViewPicker.select(photoSelectOptions);
      let localPicPath = photoSelectResult.photoUris; //获取选取的文件路径

      // 返回用户选择的图片路径数组
      return localPicPath;

    } catch (err) {
      let errStr = JSON.stringify(err).slice(0, 800);
      console.log('选择文件错误:' + errStr);
      return Promise.reject(['选择文件错误:' + errStr])
    }
  }

  // 2. 根据文件路径filePath 读取文件数据到ArrayBuffer中
  // filePath->文件路径 -> 通过UploadForGac.SelectImage 方法获取
  static async ReadBufferFromPath(filePath: string): Promise<Uint8Array> {
    try {

      const file = fs.openSync(filePath, fs.OpenMode.READ_ONLY) // 以只读模式打开文件
      let buffer = new ArrayBuffer(10 * 1024 * 1024); // 定义10M大小缓存区用来存储读取的文件内容，不能太大，否则会崩溃
      let readLen = await fs.readSync(file.fd, buffer); // 读取文件内容到buffer中并获得文件大小
      let data = new Uint8Array(buffer.slice(0, readLen)); // 从buffer中截取文件大小的内容
      fs.closeSync(file); // 关闭文件
      return data;

    } catch (err) {

      let errStr = JSON.stringify(err).slice(0, 800);
      console.log('读取文件流错误:' + errStr);
      return Promise.reject(['读取文件流错误:' + errStr]);

    }
  }

  // 3. 将data数据上传到云存储中,返回云地址
  static async uploadFileToGac(data: Uint8Array): Promise<string> {
    return new Promise(async (resolve, reject) => {
      //初始化云存储对象
      const storageManagement = agconnect.cloudStorage();
      //创建引用
      const storageReference = await storageManagement.storageReference();
      // 确定上传到云存储的文件路径，文件名唯一处理
      const uuid = Date.now()
        .toString() + Math.random()
        .toString()
        .replace(".", "") // 生成一个唯一的文件名
      const reference = storageReference.child('headImg/' + uuid);
      const uploadTask = reference.putData(data);

      uploadTask.on('progress', async (uploadSize, totalSize) => {
        var progress = (uploadSize / totalSize) * 100;
        // emit发送事件
        UploadForGac.emitSend({
          uploadSize:uploadSize,
          totalSize:totalSize
        })
        console.log("上传百分比:", progress);
        if (progress === 100) {
          // 获取上传的图片地址
          let downloadUrl = await reference.getDownloadURL(); //获取下载地址
          console.log("云存储地址：:", downloadUrl);
          // 返回promise
          resolve(downloadUrl);
        }
      });

      uploadTask.catch(err => {
        let errStr = JSON.stringify(err).slice(0, 800);
        // 返回promise
        reject("上传错误:" + errStr);
        console.log("上传错误:" + errStr);
      });

    });
  }
}