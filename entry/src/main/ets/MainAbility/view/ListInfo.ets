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
//@Preview
@Component
export struct ListInfo {

  build() {
    List() {
      ForEach(MineInfoList, (item: InfoItem) => {
        ListItem() {
          Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
            Text(item.title).fontSize($r('app.float.default_16')).height($r('app.float.default_40'))

            Image($rawfile('task/right_grey.png'))
              .objectFit(ImageFit.Contain)
              .height($r('app.float.default_12'))
              .width($r('app.float.default_7'))
          }
        }
        .backgroundColor($r('app.color.white'))
        .margin({
          left: $r('app.float.default_24'),
          right: $r('app.float.default_24')
        })
        .height($r('app.float.default_48'))
        .border({
          width: '1vp',
          color: $r('app.color.borderColor')
        })

      }, item => item.id);
    }
    .border({
      radius: '24vp'
    })
    .backgroundColor($r('app.color.white'))
    .margin({ top: $r('app.float.default_24') })
    .padding({ top: $r('app.float.default_16') })
    .flexGrow(1)
    .clip(true)
  }
}

interface InfoItem {
  id: string;
  title: Resource;
  icon?: Resource;
}

const MineInfoList: InfoItem[] = [
  {
    id: '1',
    title: $r("app.string.mine_personal_data")
  },
  {
    id: '2',
    title: $r('app.string.mine_check_updates')
  },
  {
    id: '3',
    title: $r('app.string.mine_about')
  }
];