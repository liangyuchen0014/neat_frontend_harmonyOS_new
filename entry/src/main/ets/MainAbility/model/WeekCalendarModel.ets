import TaskInfo from '../common/bean/TaskInfo';
import DayInfo from '../common/bean/DayInfo';
import { WEEK_TITLES, dateToStr } from '../common/utils/Utils'


// day number of on week
export const WEEK_DAY_NUM: number = 7;

export class WeekDateModel {
  weekTitle: string;
  dateStr: string;
  date: Date;
  dayInfo: DayInfo;
  taskList: TaskInfo[] = [];

  constructor(weekTitle: string, dateStr: string, date: Date) {
    this.weekTitle = weekTitle;
    this.dateStr = dateStr;
    this.date = date;
  }
}