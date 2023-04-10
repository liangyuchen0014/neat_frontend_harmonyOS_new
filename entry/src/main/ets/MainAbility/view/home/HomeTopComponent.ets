import * as commonConst from '../../common/constants/CommonConstants';
import { DEFAULT_100 } from '../../common/constants/CommonConstants';
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
import { HomeStore } from '../../viewmodel/HomeViewModel';
import { WeekCalendar } from './WeekCalendarComponent';
import HealthText from '../../view/HealthTextComponent';

@Extend(Text) function titleTextStyle() {
  .fontSize($r('app.float.default_16'))
  .fontWeight(commonConst.FONT_WEIGHT_500)
  .width(commonConst.THOUSANDTH_1000)
  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
  .fontColor($r(`app.element.color.titleColor`))
}

@Component
export default struct HomeTopView {
  @Link homeStore: HomeStore;

  getDonePercent() {
    let dayInfo = this.homeStore.selectedDayInfo?.dayInfo;
    console.debug("dayInfo", JSON.stringify(dayInfo));
    if (dayInfo && (dayInfo?.finTaskNum || 0) > 0) {
      if (dayInfo.finTaskNum > dayInfo.targetTaskNum) {
        return `${DEFAULT_100}`;
      }
      return `${Math.ceil(dayInfo.finTaskNum / dayInfo.targetTaskNum * DEFAULT_100)}`;
    }
    return '0';
  }

  build() {
    Column() {
      Text($r('app.string.target_progress'))
        .titleTextStyle()
        .opacity(commonConst.OPACITY_6)
        .padding({ left: $r('app.float.default_24') })
      Row() {
        HealthText({
          title: this.getDonePercent(),
          fontSize: $r('app.float.default_72'),
          fontFamily: $r('app.string.HarmonyHeiTi_Bold'),
          fontWeight: commonConst.FONT_WEIGHT_700
        })
        Text('%')
          .titleTextStyle()
          .fontSize($r('app.float.default_40'))
          .margin({ top: $r('app.float.default_12'), left: $r('app.float.default_8') })
      }
      .width(commonConst.THOUSANDTH_1000)
      .padding({ left: $r('app.float.default_24') })

      WeekCalendar({ homeStore: $homeStore })
    }
    .height(commonConst.THOUSANDTH_500)
    .backgroundImagePosition({ x: 0, y: 0 })
    .backgroundImage($rawfile('homeImg/home_bg.png'))
    .backgroundImageSize({ width: commonConst.THOUSANDTH_1000, height: commonConst.THOUSANDTH_900 })
    .justifyContent(FlexAlign.End)
  }
}