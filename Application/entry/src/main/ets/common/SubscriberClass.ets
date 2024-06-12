import commonEventManager from '@ohos.commonEventManager'
import { PublishEventType } from './Constants'

// commonEventManager作用：可用于进程间通讯

export class SubscriberClass {
  static publishCount:number = 1
  // 发布者
  static publish(eventType:PublishEventType,data:string){
    // next中data支持导入类型
    commonEventManager.publish(eventType,{data},(err)=>{
      if(err){
        // 失败只发3次
        if(this.publishCount<=3){
          this.publish(eventType,data)
        }else{
          this.publishCount = 1
        }
      }else{
        this.publishCount = 1
      }
    })
  }
  // 订阅者
  static subscribe(eventType:PublishEventType,subscriber,callback:(event:string)=>void){
    commonEventManager.createSubscriber({ events: [eventType] }, (err, data) => {
      if (err) {
        return console.log('logData:', `创建订阅者error ${JSON.stringify(err)}`)
      }
      console.log('logData:', `创建订阅者success`)
      subscriber = data
      if (subscriber !== null) {
        //订阅事件
        commonEventManager.subscribe(subscriber, (err, data) => {
          if (err) {
            return console.error(`logData`, '订阅事件失败')
          }
          console.log('logData:',`接受订阅事件:${data.data}`)
          callback(data.data)
        })
      } else {
        console.error('logData:',`需要创建subscriber`);
      }
    })
  }
}