import router from '@ohos.router';
import HealthText from './HealthTextComponent';
import AddBtn from './/home/AddBtnComponent';
import { TaskCard } from './/home//TaskCardComponent';
import HomeTopView from './/home/HomeTopComponent';
import { CustomDialogView, CustomDialogCallback } from './/dialog/CustomDialogView';
import TaskInfo from '../MainAbility/common/bean/TaskInfo';
import { HomeStore } from '../viewmodel/HomeViewModel';
import { ITaskItem, TaskMapById } from '../model/TaskInitList';
import * as commonConst from '../common/constants/CommonConstants';
const WHITE_COLOR_0X = 255;

@Component
export default struct HomeIndex {
  @State naviAlpha: number = 0;
  @State homeStore: HomeStore = new HomeStore(new Date());
  @Link editedTaskInfo: ITaskItem;
  @Link @Watch('taskChange') editedTaskID: string;
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.homeStore.initData();
  }

  taskChange() {
    this.homeStore.updateTaskInfoList(this.editedTaskInfo);
  }

  taskItemAction(item: TaskInfo, isClick: boolean) {
    if (!this.homeStore.checkCurrentDay()) {
      return;
    }
    if (isClick) {
      // click to clock
      let callback: CustomDialogCallback = { confirmCallback: this.onConfirm.bind(this), cancelCallback: null };
      //this.broadCast.emit(BroadCastType.SHOW_TASK_DETAIL_DIALOG, [item, callback]);
    } else {
      // edit task
      const editTask: ITaskItem = {
        ...TaskMapById[item.taskID],
        targetValue: item?.targetValue,
        isAlarm: item.isAlarm,
        startTime: item.startTime,
        frequency: item.frequency,
        isOpen: item.isOpen,
      };
      router.push({ url: 'pages/TaskEditPage', params: { params: JSON.stringify(editTask) } });
    }
  }

  //confirm clock
  onConfirm(task) {
    this.homeStore.taskClock(task).then((res) => {

    })
  }

  // change navigator alpha when scrolling the Scroll component
  onScrollAction() {
    let yOffset = this.scroller.currentOffset().yOffset;
    if (yOffset > commonConst.DEFAULT_56) {
      this.naviAlpha = 1;
    } else {
      this.naviAlpha = yOffset / commonConst.DEFAULT_56;
    }
  }

  editTaskAction() {
    if (this.homeStore.checkCurrentDay()) {
      router.push({ url: 'pages/TaskListPage' });
    }
  }

  build() {
    Stack() {
      Scroll(this.scroller) {
        Column() {
          HomeTopView({ homeStore: $homeStore })
          Text($r('app.string.task_list')).titleTextStyle()
          if (this.homeStore.getTaskListOfDay().length > 0) {
            Column({ space: commonConst.DEFAULT_8 }) {
              ForEach(this.homeStore.getTaskListOfDay(), (item: TaskInfo) => {
                TaskCard({
                  taskInfoStr: JSON.stringify(item),
                  clickAction: (isClick) => this.taskItemAction(item, isClick)
                })
                  .margin({ bottom: commonConst.DEFAULT_12 })
                  .height($r('app.float.default_64'))
              }, item => JSON.stringify(item))
            }
            .padding({
              top: commonConst.THOUSANDTH_15,
              left: commonConst.THOUSANDTH_33,
              right: commonConst.THOUSANDTH_33
            })
            .width(commonConst.THOUSANDTH_1000)
          } else {
            Column({ space: commonConst.DEFAULT_8 }) {
              Image($rawfile('homeImg/no_data.png'))
                .width($r('app.float.default_132'))
                .height($r('app.float.default_100'));
              HealthText({ title: '', titleResource: $r('app.string.no_task'), fontSize: $r('app.float.default_14') })
            }
            .margin({ top: commonConst.DEFAULT_48 })
          }
        }
      }
      .scrollBar(BarState.Off)
      .allSize()
      .onScroll(this.onScrollAction.bind(this))
      .align(Alignment.TopStart)

      AddBtn()
      Row() {
        Text($r('app.string.MainAbility_label'))
          .titleTextStyle()
          .fontSize($r('app.float.default_24'))
          .padding({ left: commonConst.THOUSANDTH_66 })
      }
      .width(commonConst.THOUSANDTH_1000)
      .height(commonConst.DEFAULT_56)
      .position({ x: 0, y: 0 })
      .backgroundColor(`rgba(${WHITE_COLOR_0X},${WHITE_COLOR_0X},${WHITE_COLOR_0X},${this.naviAlpha})`)

      CustomDialogView()
    }
    .allSize()
    .backgroundColor($r('app.color.primaryBgColor'))
    .borderWidth(1)
    .borderColor($r('app.color.primaryBgColor'))
  }
}

@Styles function allSize () {
  .width(commonConst.THOUSANDTH_1000)
  .height(commonConst.THOUSANDTH_1000)
}

@Extend(Text) function titleTextStyle () {
  .fontSize($r('app.float.default_16'))
  .fontWeight(commonConst.FONT_WEIGHT_500)
  .width(commonConst.THOUSANDTH_1000)
  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
  .fontColor($r(`app.element.color.titleColor`))
  .padding({
    top: commonConst.THOUSANDTH_15,
    bottom: commonConst.THOUSANDTH_15,
    left: commonConst.THOUSANDTH_33
  })
}