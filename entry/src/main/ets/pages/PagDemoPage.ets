import { PAGFile, PAGView, PAGViewController, PAGViewListener } from '@tencent/libpag';

@Entry
@Component
struct PagDemoPage {
  TAG: string = 'PAGDEMO::'
  @State message: string = 'Hello World';

  manager = getContext(this).resourceManager
  file = PAGFile.LoadFromAssets(this.manager, 'alertmail.pag');

  @State isFirstLoadFinish: boolean = false

  @State viewController: PAGViewController = new PAGViewController()
  @State count: number = 0
  listener: PAGViewListener = {
    onAnimationStart: () => {
      console.log(this.TAG, `动效开始了${this.count}`)
    },
    onAnimationRepeat: () => {
      if (this.isFirstLoadFinish === false) {
        console.log(this.TAG, '第一次播放结束')
        console.log(this.TAG, `starttime = ${this.file?.startTime()} duration = ${this.file?.duration()}`)

        this.isFirstLoadFinish = true
      }
      this.count++
      console.log(this.TAG, `开始重复了${this.count}`)
    },
    onAnimationEnd: () => {
      this.count = this.count + 1
      console.log(this.TAG, `结束了${this.count}`)
    }
  }

  aboutToAppear(): void {
    this.viewController.setComposition(this.file);
    this.viewController.setRepeatCount(-1);
    this.viewController.play();
    this.viewController.addListener(new WeakRef(this.listener))
  }

  build() {
    Column() {
      PAGView({
        controller: this.viewController
      })


    }
    .height('100%')
    .width('100%')
  }
}