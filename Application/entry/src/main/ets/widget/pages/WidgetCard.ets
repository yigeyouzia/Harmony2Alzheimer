class RankInfo {
  name: string = 'nickname'
  score: number = 60
  avatar: Resource = $r('app.media.kefu')
}

const CARD_FIRST_COLOR: string = '#FFA621';
const CARD_SECOND_COLOR: string = '#929DCA';
const CARD_THIRD_COLOR: string = '#EA8F50';


let storage = new LocalStorage()

// 顶级组件
@Entry(storage)
@Component
struct RankCardCard {
  build() {
    Stack() {
      // 背景图
      Image($r('app.media.ic_public_card_bg_svg'))
      // 排行图
      Image($r('app.media.ic_public_card_svg'))
        .width('85%')
      Row() {
        // 第二名
        SilverRankItem()
        // 第一
        GoldenRankItem()
        // 第三名
        CopperRankItem()
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .height(160)
      .width('100%')
      .onClick(() => {
        postCardAction(this, {
          'action': 'router',
          'abilityName': 'EntryAbility', // 只能跳转到当前应用下的UIAbility
          'params': {
            'behavior': 'rank'
          }
        });
      })
    }
    .width('100%')
    .height('100%')
  }
}


// 第一名
@Component
struct GoldenRankItem {
  @LocalStorageProp('first') first: RankInfo = {
    name: '第一名',
    score: 100,
    avatar: $r('app.media.kefu')
  }

  build() {
    Column() {
      Image(this.first.avatar)
        .width(40)
        .border({ width: 2, color: CARD_FIRST_COLOR })
        .borderRadius(20)
        .aspectRatio(1)
      Image($r('app.media.ic_public_card_golden'))
        .width(28)
      Text(this.first.name)
        .fontSize(14)
        .fontWeight(500)
        .margin({ top: 8 })
      Text(this.first.score + '')
        .fontColor(CARD_FIRST_COLOR)
        .fontSize(12)
        .fontWeight(700)
    }
    .alignSelf(ItemAlign.Start)
  }
}
// 第二名
@Component
struct SilverRankItem {
  @LocalStorageProp('second') second: RankInfo = {
    name: '第二名',
    score: 90,
    avatar: $r('app.media.kefu')
  }

  build() {
    Column() {
      Image(this.second.avatar)
        .width(40)
        .border({ width: 2, color: CARD_SECOND_COLOR })
        .borderRadius(20)
        .aspectRatio(1)
      Image($r('app.media.ic_public_card_silver'))
        .width(28)
      Text(this.second.name)
        .fontSize(14)
        .fontWeight(500)
        .margin({ top: 8 })

      Text(this.second.score + '')
        .fontColor(CARD_SECOND_COLOR)
        .fontSize(12)
        .fontWeight(700)
    }
    .alignSelf(ItemAlign.Center)
  }
}

// 第三名
@Component
struct CopperRankItem {
  @LocalStorageProp('third') third: RankInfo = {
    name: '第三名',
    score: 80,
    avatar:$r('app.media.kefu')
  }

  build() {
    Column() {
      Image(this.third.avatar)
        .width(40)
        .border({ width: 2, color: CARD_THIRD_COLOR })
        .borderRadius(20)
        .aspectRatio(1)
      Image($r('app.media.ic_public_card_copper'))
        .width(28)
      Text(this.third.name)
        .fontSize(14)
        .fontWeight(500)
        .margin({ top: 8 })

      Text(this.third.score + '')
        .fontColor(CARD_THIRD_COLOR)
        .fontSize(12)
        .fontWeight(700)
    }
    .alignSelf(ItemAlign.Center)
  }
}

