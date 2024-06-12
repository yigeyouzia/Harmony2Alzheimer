import request from '@ohos.request';
import fileFs from '@ohos.file.fs';
import fs from '@ohos.file.fs';

interface resultClass {
  fileName: string
  // 必须叫formImages不然卡片收不到
  formImages: Record<string, number>
}

class resultClassModel implements resultClass {
  fileName: string = ''
  formImages: Record<string, number> = {
    fileName: 0
  }

  constructor(model: resultClass) {
    this.fileName = model.fileName
    this.formImages = model.formImages
  }
}

export class Http2BufferClass {
  static httpFile: string = ''
  static result: resultClass = new resultClassModel({} as resultClass)

  static get(httpFile: string, context: Context, callback: (result: resultClass) => void) {
    // 如果下载的地址一样，直接返回
    if (httpFile === Http2BufferClass.httpFile) {
      callback(this.result)
    } else {
      Http2BufferClass.httpFile = httpFile
      let tempDir = context.getApplicationContext()
        .tempDir;
      let fileName = 'file' + Date.now()
      let tmpFile = tempDir + '/' + fileName;
      request.downloadFile(context, { url: Http2BufferClass.httpFile, filePath: tmpFile })
        .then(task => {
          console.log('logData:', '创建下载任务，拿到task')
          task.on('complete', () => {
            let file: fileFs.File
            console.log('logData:', '下载完成，进入complete')
            try {
              file = fs.openSync(tmpFile);
            } catch (e) {
              console.error('logData:', `openSync失败`);
            }
            this.result = new resultClassModel({
              // 名字必须是下载的路径
              fileName: tmpFile,
              formImages: {
                [tmpFile]: file.fd
              }
            })
            console.log('logData:', '拿到result')
            callback(this.result)
          })
          task.on('fail', () => {
            console.log('logData:', '下载失败')
          });
        })
    }

  }

  static async getList(httpFiles: string[], context: Context, callback: (resultList) => void) {
    let downLoadIndex = 0
    const resultList = []
    const downLoadCallBack = (result)=>{
      console.log('downLoadCallBack',downLoadIndex.toString())
      resultList.push(result)
      downLoadIndex++
      if(downLoadIndex === httpFiles.length){
        downLoadIndex = 0;
        callback(resultList)
      }else{
        Http2BufferClass.get(httpFiles[downLoadIndex],context,(result)=>{
          downLoadCallBack(result)
        })
      }
    }
    Http2BufferClass.get(httpFiles[downLoadIndex],context,(result)=>{
       downLoadCallBack(result)
    })
  }
}

