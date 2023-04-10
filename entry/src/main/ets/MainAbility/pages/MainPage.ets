import router from '@ohos.router';
import * as commonConst from '../common/constants/CommonConstants'
import { MineIndex } from './MinePage';
import { AchievementIndex } from '../view/AchievementComponent'
import HomeIndex from '../view/HomeComponent'
@Preview
@Entry
@Component
struct Index {
  @State currentPage: number = 0;
  @State editedTaskInfo: ITaskItem = JSON.parse(router.getParams() ? router.getParams()['editTask'] : '{}');
  @State editedTaskID: string = '0';
  private tabController: TabsController = new TabsController();

  @Builder TabBuilder(index: number) {
    Column() {
      Image(index == this.currentPage ? NavList[index].icon_selected : NavList[index].icon)
        .width('24vp')
        .height('24vp')
        .objectFit(ImageFit.Contain);
      Text(NavList[index].text)
        .fontSize('10vp')
        .fontWeight(commonConst.FONT_WEIGHT_500)
        .fontColor(this.currentPage === index ? "#007DFF" : "#999")
        .margin({ top: '4vp' })
    }.justifyContent(FlexAlign.Center).allSize()
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        HomeIndex({ editedTaskInfo: $editedTaskInfo, editedTaskID: $editedTaskID })

      }
      .tabBar(this.TabBuilder(TabId.HOME))
      .align(Alignment.Start)

      TabContent() {
        AchievementIndex()
      }
      .tabBar(this.TabBuilder(TabId.ACHIEVEMENT))

      TabContent() {
        MineIndex()
      }
      .tabBar(this.TabBuilder(TabId.MINE))
    }
    .scrollable(false)
    .allSize()
    .barWidth("94%")
    .barMode(BarMode.Fixed)
    .vertical(false)
    .onChange((index) => {
      this.currentPage = index;
    })
  }
  }
@Styles function allSize () {
  .width("100%")
  .height("100%")
}
enum TabId {
  HOME,
  ACHIEVEMENT,
  MINE
}
const NavList: NavItem[] = [
  {
    icon: $rawfile('tabs/home_normal.png'),
    icon_selected: $rawfile('tabs/home_sel.png'),
    text: $r('app.string.tab_home'),
    id: TabId.HOME
  },
  {
    icon: $rawfile('tabs/achievement_normal.png'),
    icon_selected: $rawfile('tabs/achievement_sel.png'),
    text: $r('app.string.tab_achievement'),
    id: TabId.ACHIEVEMENT
  },
  {
    icon: $rawfile('tabs/mine_normal.png'),
    icon_selected: $rawfile('tabs/mine_sel.png'),
    text: $r('app.string.tab_mine'),
    id: TabId.MINE
  },
]
interface NavItem {
  icon: Resource;
  icon_selected: Resource;
  text: Resource;
  id: number;
}
interface ITaskItem {
  taskID: number;
  taskName: Resource;
  isOpen: boolean;
  unit: string;
  icon: Resource;
  dialogBg: Resource;
  targetValue: string;
  isAlarm: boolean;
  startTime: string;
  endTime: string;
  frequency: string;
  isInit: boolean;
  step: number;
}