import { ProjectPage } from './project/ProjectPage'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  build() {
    Column() {
      Tabs({
        index: this.currentIndex,
        barPosition: BarPosition.End
      }) {
        //首页
        TabContent() {
          ProjectPage()
        }
        .tabBar(this.tabBuilder(0, '试验项目', $r('app.media.project_selected'), $r('app.media.project')))

        //福券专区
        TabContent() {
          // DiscountCouponPage()
        }
        .tabBar(this.tabBuilder(1, '在线沟通', $r('app.media.chat_selected'), $r('app.media.chat')))

        //我的
        TabContent() {
          // MePage()
        }
        .tabBar(this.tabBuilder(2, '我的', $r('app.media.me_selected'), $r('app.media.me')))

      }
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.currentIndex = index
      })
    }
  }
  @Builder tabBuilder(index: number, title: string, selectedImage: Resource, normalImage: Resource) {
    Column() {
      Image(this.currentIndex == index ? selectedImage : normalImage)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex == index ? '#1698CE' : '#6B6B6B')
        .fontSize(12)
    }
    .width('100%')
    .height('100%')
  }
}