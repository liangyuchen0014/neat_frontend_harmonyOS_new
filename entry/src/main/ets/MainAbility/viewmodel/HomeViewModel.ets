/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { DEFAULT_100 } from '../common/constants/CommonConstants';
/*import { isReachNewAchievement, ACHIEVEMENT_LEVEL_KEY } from '../model/AchieveModel';
import DatabaseApi from '../model/DatabaseModel';*/
import { TaskMapById, ITaskItem, ACHIEVEMENT_LEVEL_LIST } from '../model/TaskInitList';
import TaskInfo from '../common/bean/TaskInfo';
import DayInfo from '../common/bean/DayInfo';
import { dateToStr, weekDateFormat } from '../common/utils/Utils';
/*import { TaskInfoTableApi, TaskInfoTable } from '../common/database/tables/TaskInfoTable';
import { DayInfoTable } from '../common/database/tables/DayInfoTable';
import { GlobalInfoTable } from '../common/database/tables/GlobalInfoTable';
import { Logger } from '../common/utils/log/Logger';*/
//import { initializeOnStartUp, getPreviousWeek } from '../model/WeekCalendarModel';

import { WeekDateModel,  WEEK_DAY_NUM } from '../model/WeekCalendarModel';
import http from '@ohos.net.http';
let httpRequest = http.createHttp();

@Observed
export class HomeStore {
  public currentDate: Date;
  public dateArr: Array<WeekDateModel> = []; // data source list
  public selectedDay: number; // selected day of on week
  public showDate: number;
  public dateTitle: string ;
  public selectedDayInfo: WeekDateModel ; // task info on selected day


  constructor(currentDate: Date) {
    this.currentDate = currentDate;
    this.showDate = currentDate.getTime();
    this.dateTitle = weekDateFormat(currentDate.getTime());
    this.selectedDay = (new Date().getDay() + WEEK_DAY_NUM - 1) % WEEK_DAY_NUM;
  }

}