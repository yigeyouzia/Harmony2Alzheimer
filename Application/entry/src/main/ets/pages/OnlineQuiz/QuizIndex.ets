import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { Constants } from '../../common/Constants'
import OptionItem from './QuizOptionItem'
import AnswerSheetDialog from './AnswerSheetDialog'

interface  IAnswer {
  letter:string,
  txt:string,
  isselected:boolean
}

class Answer implements IAnswer {
  letter:string
  txt:string
  isselected:boolean

  constructor(answer:IAnswer) {
    this.letter = answer.letter;
    this.txt = answer.txt;
    this.isselected = answer.isselected;
  }
}

@Entry
@Component
struct QuizIndex {
  @State selectedIndex:number = 2;
  @State answerList:Array<IAnswer> = [
    new Answer({letter:'A',txt:'默认选项1',isselected:false}),
    new Answer({letter:'B',txt:'默认选项2',isselected:false}),
    new Answer({letter:'C',txt:'默认选项3',isselected:false}),
    new Answer({letter:'D',txt:'默认选项4',isselected:false})
  ];
  onBackPress() {
    // return true
  }

  // 自定义弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    // 构造器
    builder: AnswerSheetDialog({
      cancel: () => {
        // AlertDialog.show({ message: 'cancel' })
      },
      confirm: () => {
        // AlertDialog.show({ message: 'confirm' })
      }
    }),
    // 对齐
    alignment:DialogAlignment.Bottom,
    customStyle:true

  })

  build() {
    Column() {
      Column() {

        // 顶部
        Stack({ alignContent: Alignment.End }) {
          Text('在线模拟')
            .width('100%')
            .fontSize(18)
            .fontWeight(600)
            .textAlign(TextAlign.Center)
          Image($r('app.media.ic_allread'))
            .width(20)
            .aspectRatio(1)
            .onClick(()=>{
              this.dialogController.open();
            })
        }
        .width('100%')
        .padding({ top: 10, bottom: 20, })

        // 进度条
        Row() {
          Progress({ value: 1, total: 10 })
            .margin({ right: 10 })
            .layoutWeight(1)
          Text() {
            Span('1')
              .fontWeight(900)
              .fontColor(Color.Gray)
            Span('/10')
              .fontWeight(900)
              .fontColor('#c4c4c4')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // 题目类型
        Row() {
          Text('单选题')
            .fontSize(12)
            .fontColor(Color.Gray)
            .padding({ top: 2, bottom: 2, left: 10, right: 10 })
            .backgroundColor(Color.White)
        }
        .width('100%')

        // 题目内容
        Column({ space: 16 }) {
          Text('Vue最大的优势是什么?')
            .width('100%')
          Column({ space: 8 }) {
            ForEach(this.answerList, (item:IAnswer,index:number) => {
              OptionItem({ label:`${item.letter}.${item.txt}`, isSelected: item.isselected})
                .onClick(()=>{
                  let list =JSON.parse(JSON.stringify(this.answerList));
                  list.forEach(item=>{item.isselected = false;})
                  list[index].isselected = true;
                  this.answerList = list;
                })
            })
          }
        }
        .width('100%')
        .margin({ top: 10 })

        Blank()
        // 交卷按钮
        Button('提交答案')
          .width(200)
          .height(45)
          .margin({ bottom: 60 })
          .onClick(()=>{
            router.pushUrl({url:Constants.PAGE_QUIZ_RESULT})
          })
      }
      .padding({ left: 15, right: 15 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f9f9f9')
  }
}