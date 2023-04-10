//import WeekCalendarMethods from '../../viewmodel/CalendarViewModel';
import { WeekDateModel } from '../../model/WeekCalendarModel';
import { HomeStore } from '../../viewmodel/HomeViewModel';
import HealthText from '../../view/HealthTextComponent';
import * as commonConst from '../../common/constants/CommonConstants';

const CHINESE_OF_WEEK: string[] = ['一', '二', '三', '四', '五', '六', '日'];
const YEAR: string = '年';
const MONTH: string = '月';
const DAY: string = '日';
const WEEK: string = '星期';
const DAYS_OF_WEEK: number = 7;
const SUNDAY_FIRST_SHIFT: number = 6;
const WEEK_DAY_WIDTH: number = 100 / commonConst.WEEK_DAY_NUM;
const weekTitleFunc = () => {
  const weekTitleArr = [];
  CHINESE_OF_WEEK.forEach((item, index) => {
    weekTitleArr.push(CHINESE_OF_WEEK[(index + SUNDAY_FIRST_SHIFT) % DAYS_OF_WEEK]); // Sunday is the first day
  });
  return weekTitleArr;
}
const WEEK_TITLES: string[] = weekTitleFunc();
function padTo2Digits(num: number) {
  return num.toString().padStart(2, '0');
}
function dateFormat(date: Date) {
  return date.getFullYear() + YEAR + padTo2Digits(date.getMonth() + 1) + MONTH + padTo2Digits(date.getDate()) + DAY;
}
function weekDateFormat(timestamp: number) {
  let tempDate = new Date(timestamp);
  return dateFormat(tempDate) + WEEK + WEEK_TITLES[tempDate.getDay()];
}
function  setSelectedShowDate(showDateTime: number) {
  if (showDateTime > new Date().getTime()) {
    return;
  }
  this.showDate = showDateTime;
  this.dateTitle = weekDateFormat(this.showDate);
  let selectedInfo = this.dateArr.find((item: WeekDateModel) => item.dateStr == new Date(showDateTime).toDateString());
  if (selectedInfo) {
    this.updateSelectedDayInfo({ ...selectedInfo });
  }
  console.info('dateTitle', this.dateTitle);
}
function sameDate(firstDate: Date, timestamp: number) {

  let secondDate = new Date(timestamp);
  if (firstDate.getFullYear() != secondDate.getFullYear()) {
    return false;
  }

  if (firstDate.getMonth() != secondDate.getMonth()) {
    return false;
  }

  if (firstDate.getDate() != secondDate.getDate()) {
    return false;
  }

  return true;
}

@Component
export struct WeekCalendar {
  @Link homeStore: HomeStore;
  currentPage: number = 1;
  private scroller: Scroller = new Scroller();
  private isLoadMore: boolean = false;
  private isPageScroll: boolean = false;

  aboutToAppear() {
    setSelectedShowDate(new Date().getTime());
  }


  getProgressImg(item: WeekDateModel): Resource {
    let finNum = item.dayInfo?.finTaskNum || 0;
    if (finNum === 0) {
      return $rawfile('homeImg/undone.png');
    }
    if (finNum === (item.dayInfo?.targetTaskNum || 0)) {
      return $rawfile('homeImg/all_done.png');
    }
    return $rawfile('homeImg/half_done.png');
  }

  @Builder ArrowIcon(isRight: boolean) {
    Row() {
      Image($rawfile('task/right_grey.png'))
        .width($r('app.float.default_6'))
        .height($r('app.float.default_12'))
    }
    .width($r('app.float.default_20'))
    .height($r('app.float.default_20'))
    .rotate({ z: 1, angle: isRight ? 0 : commonConst.DEFAULT_180 })
    .justifyContent(FlexAlign.Center)
//    .onClick(() => isRight ? WeekCalendarMethods.goToNextWeek.call(this) : WeekCalendarMethods.gotoPreviousWeek.call(this))
  }

  build() {
    Row() {
      Column() {
        Row() {
          this.ArrowIcon(false)
          HealthText({ title: this.homeStore.dateTitle as string, fontSize: $r('app.float.default_14') })
          this.ArrowIcon(true)
        }
        .justifyContent(FlexAlign.Center)

        Scroll(this.scroller) {
          Row() {
            ForEach(this.homeStore.dateArr, (item: WeekDateModel, index: number) => {
              Column() {
                Text(item.weekTitle)
                  .fontSize($r('app.float.default_12'))
                  .fontWeight(commonConst.FONT_WEIGHT_500)
                  .fontColor(sameDate(item.date, this.homeStore.showDate) ? $r('app.color.blueColor') : $r('app.color.titleColor'))
                  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
                  .opacity(commonConst.OPACITY_6)
                Divider()
                  .margin({top: commonConst.DEFAULT_2, bottom: $r('app.float.default_4')})
                  .width($r('app.float.default_12'))
                  .color(sameDate(item.date, this.homeStore.showDate) ? $r('app.color.blueColor') : $r('app.color.white'))
                Image(this.getProgressImg(item))
                  .height($r('app.float.default_28'))
                  .objectFit(ImageFit.Contain)
                  .margin({ top: commonConst.THOUSANDTH_80 })
              }
              .width(`${WEEK_DAY_WIDTH}%`)
              .justifyContent(FlexAlign.SpaceBetween)
//              .onClick(() => WeekCalendarMethods.calenderItemClickAction.call(this, item, index))
            })
          }
        }
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Horizontal)
        .width(commonConst.THOUSANDTH_1000)
//        .onScrollEnd(() => WeekCalendarMethods.onScrollEndAction.call(this))
//        .onScrollEdge(() => WeekCalendarMethods.onScrollEdgeAction.call(this))
      }
      .borderRadius($r('app.float.default_24'))
      .backgroundColor($r('app.color.white'))
      .width(commonConst.THOUSANDTH_1000)
      .height(commonConst.THOUSANDTH_1000)
      .padding({ top: commonConst.THOUSANDTH_50, bottom: commonConst.THOUSANDTH_120 })

    }
    .width(commonConst.THOUSANDTH_1000)
    .height(commonConst.THOUSANDTH_420)
    .padding(commonConst.THOUSANDTH_33)
  }

}