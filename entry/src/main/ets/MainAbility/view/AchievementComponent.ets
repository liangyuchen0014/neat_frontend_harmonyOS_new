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

import * as commonConst from '../common/constants/CommonConstants';

@Preview
@Component
export struct AchievementIndex {
  aboutToAppear(){
    console.debug('AchievementIndex', 'aboutToAppear')
  }

  onPageShow () {
    console.debug('AchievementIndex', 'onPageShow')
  }

  build() {
    Column({space: commonConst.DEFAULT_20}) {
      TitleBar()
      BadgePanel()
    }
    .padding(commonConst.DEFAULT_10)
    .height(commonConst.FULL_HEIGHT)
    .width(commonConst.FULL_WIDTH)
    .backgroundColor($r('app.color.black'))
  }
}

@Component
 struct TitleBar {
  build() {
    Row() {
      Text($r('app.string.achievement'))
        .fontSize($r('app.float.default_24'))
        .fontColor($r('app.color.white'))
        .align(Alignment.Start)
        .padding({left: commonConst.ACHIEVE_TITLE_BAR_LEFT,top: commonConst.ACHIEVE_TITLE_BAR_TOP})
    }
    .width(commonConst.FULL_WIDTH)
  }
}

@Component
struct BadgePanel {
  @StorageProp('AchievementLevelKey') successiveDays: number = 0;

  aboutToAppear() {
    console.debug('BadgePanel','aboutToAppear')
    getAchievementLevel()
  }

  build() {
    Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap }) {
      ForEach(getBadgeCardItems(this.successiveDays), (item) => {
        BadgeCard({ content: item[0], imgSrc: item[1]})
      })
    }
    .width(commonConst.FULL_WIDTH)
  }
}

@Component
export struct BadgeCard {
  @Prop content: string;
  @Prop imgSrc: string;

  build() {
    Column({space: commonConst.DEFAULT_18}) {
      Image($rawfile(this.imgSrc))
        .width(commonConst.FULL_WIDTH)
        .height(commonConst.ACHIEVE_CARD_IMG_HEIGHT)
        .objectFit(ImageFit.Contain)
      Text($r('app.string.task_achievement_level', Number(this.content)))
        .lineHeight($r('app.float.default_16'))
        .fontSize($r('app.float.default_12'))
        .fontColor($r('app.color.white'))
    }
    .width(`${commonConst.ACHIEVE_SPLIT_RATIO * 100}%`)
    .padding({top: commonConst.ACHIEVE_CARD_TOP, bottom: commonConst.ACHIEVE_CARD_BOTTOM})
  }
}

function getAchievementLevel() {
  AppStorage.Set<Number>('AchievementLevelKey',0);
}
function getBadgeCardItems(successiveDays: number):[string, string][] {
  let badgeMileStones = [3, 7, 30, 50, 73, 99];
  let cardItems:[string, string][] = [];
  for (let i = 0; i < badgeMileStones.length; i++) {
    let onOrOff = successiveDays >= badgeMileStones[i] ? 'on' : 'off';
    let titleContent = String(badgeMileStones[i]);
    let badgeImg = `achievement/badge_${ badgeMileStones[i] }_${ onOrOff }.png`;
    let oneItem:[string, string] = [titleContent, badgeImg];
    cardItems.push(oneItem);
  }
  return cardItems;
}