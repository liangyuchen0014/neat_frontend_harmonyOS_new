import { MINUS_20 } from '../../common/constants/CommonConstants';
import { ZERO } from '../../common/constants/CommonConstants';
import router from '@ohos.router';
import prompt from '@system.prompt';
import { ITaskItem } from '../../model/TaskInitList';
//import { Logger } from '../../common/utils/log/Logger';
import * as commonConst from '../../common/constants/CommonConstants';
import { taskType } from '../../common/bean/TaskInfo';
import { FrequencyItem, OpenRemindItem, RemindTimeItem, TargetSetItem, TaskChooseItem } from './TaskEditListItem';
//import { BroadCast, BroadCastType } from '../../common/utils/BroadCast';
//import { HealthDataSrcMgr } from '../../common/utils/HealthDataSrcMgr';
import { addTask, formatParams, initFrequencyString, newAddTask } from '../../viewmodel/TaskViewModel';
//import { TaskDialogView } from '../dialog/TaskDialogView';

@Styles function listItemStyle() {
  .backgroundColor($r('app.color.white'))
  .height(commonConst.DEFAULT_56)
  .borderRadius(commonConst.DEFAULT_10)
  .padding({ left: commonConst.DEFAULT_12, right: commonConst.DEFAULT_12 })
}
@Preview
@Component
export default struct TaskDetail {
  @Provide @Watch('onParamsChanged') settingParams: ITaskItem = this.parseRouterParams();
  @Provide frequency: string = initFrequencyString(this.settingParams?.frequency);
  private isChanged: boolean = false;

  parseRouterParams() {
    const routerParams: ITaskItem = JSON.parse(router.getParams()['params']);
    return routerParams;
  }

  onParamsChanged() {
    this.isChanged = true;
  }

  backIndexParams() {
    return formatParams({
      ...this.settingParams,
      isDone: true,
      finValue: this.settingParams?.targetValue,
    });
  }

  finishTaskEdit() {
    if (this.isChanged) {
      addTask({
        id: commonConst.ZERO,
        date: commonConst.GLOBAL_KEY,
        ...this.settingParams,
        isDone: false,
        finValue: '',
      })
        .then(res => {
          router.back({
            url: 'pages/MainPage',
            params: {
              editTask: this.backIndexParams(),
            }
          })
        })
        .catch(res => {
          prompt.showToast({
            message: commonConst.SETTING_FINISH_FAILED_MESSAGE
          })
        })
      return;
    }
    router.back({
      url: 'pages/MainPage',
    })
  }

  build() {
    Row() {
      Column() {
        List({ space: commonConst.LIST_ITEM_SPACE }) {
          ListItem() {
            TaskChooseItem()
          }
          .listItemStyle()

          ListItem() {
            TargetSetItem()
          }
          .listItemStyle()
          .enabled(
            this.settingParams?.isOpen
            && this.settingParams?.taskID !== taskType.smile
            && this.settingParams?.taskID !== taskType.brushTeeth
          )
          .onClick(() => {
//            this.abc.open();
          })

          ListItem() {
            OpenRemindItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen)

          ListItem() {
            RemindTimeItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen && this.settingParams?.isAlarm)
          .onClick(() => {
          })

          ListItem() {
            FrequencyItem()
          }
          .listItemStyle()
          .enabled(this.settingParams?.isOpen)
          .onClick(() => {
          })

        }
        .width(commonConst.THOUSANDTH_940)

        Button() {
          Text($r('app.string.complete')).fontSize($r('app.float.default_20')).fontColor($r('app.color.blueColor'))
        }
        .width(commonConst.THOUSANDTH_800)
        .height(commonConst.DEFAULT_48)
        .backgroundColor($r('app.color.borderColor'))
        .onClick(() => {
          this.finishTaskEdit();
        })
        .position({
          x: commonConst.THOUSANDTH_100,
          y: commonConst.THOUSANDTH_800
        })

//        TaskDialogView()
      }
      .width(commonConst.THOUSANDTH_1000)
    }
  }
}

