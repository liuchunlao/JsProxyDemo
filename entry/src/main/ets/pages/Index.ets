import { router } from '@kit.ArkUI';

const TAG:string = 'INDEX::'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Button('WebDemo')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/WebDemoPage'
          })
        })
      Button('PagDemo')
        .onClick(() => {
          router.pushUrl({
            url: 'pages/PagDemoPage'
          })
        })
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width('100%')
  }
}