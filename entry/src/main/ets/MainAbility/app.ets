import hilog from '@ohos.hilog';

export default {

  onCreate() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Application onCreate');
    console.info('test Application created');
  },
  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Application onDestroy');
  },

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    console.debug( 'MainAbility onWindowStageDestroy');
  },

  onForeground() {
    // Ability has brought to foreground
    console.debug( 'MainAbility onForeground');
  },

  onBackground() {
    // Ability has back to background
    console.debug('MainAbility onBackground');
  },

}