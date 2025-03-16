import { webview } from '@kit.ArkWeb';

const TAG:string = 'PROXY::'

class TestObj {
  constructor() {
  }

  test(testStr: string): string {
    console.log(TAG, 'TestObj test ==' + testStr);
    return testStr;
  }

  toString(): void {
    console.log(TAG, 'TestObj toString');
  }

  testNumber(testNum: number): number {
    console.log(TAG, 'TestObj testNumber== ' + testNum);
    return testNum;
  }

  asyncTestBool(testBol: boolean): void {
    console.log(TAG, 'TestObj asyncTestBool' + testBol);
  }
}

class WebObj {
  constructor() {
  }

  webTest(): string {
    console.log(TAG, 'WebObj webTest');
    return "Web test";
  }

  webString(): void {
    console.log(TAG, 'webTest webString');
  }
}

class AsyncObj {
  constructor() {
  }

  asyncTest(): void {
    console.log(TAG, 'AsyncObj asyncTest');
  }

  asyncString(testStr:string): void {
    console.log(TAG, 'AsyncObj asyncString==' + testStr);
  }
}

@Entry
@Component
struct WebDemoPage {
  TAG: string = 'WEBDEMOPAGE::'
  @State isReigstered: boolean = false
  @State message: string = 'Hello World';
  controller: webview.WebviewController = new webview.WebviewController()
  @State testObjtest: TestObj = new TestObj();
  @State webTestObj: WebObj = new WebObj();
  @State asyncTestObj: AsyncObj = new AsyncObj();

  registerProxy() {
    try {
      // 同时注册同步和异步函数
      this.controller.registerJavaScriptProxy(this.testObjtest, "objName", ["test", "toString", "testNumber"], ["asyncTestBool"]);
      // 仅注册同步函数
      this.controller.registerJavaScriptProxy(this.webTestObj, "objTestName", ["webTest", "webString"]);
      // 仅注册异步函数
      this.controller.registerJavaScriptProxy(this.asyncTestObj, "objAsyncName", [], ["asyncTest", "asyncString"]);

      this.controller.refresh();
      console.log(TAG, '注册成功')

      this.isReigstered = true
    } catch (error) {
      console.error(TAG, `ErrorCode: ${error.code},  Message: ${error.message}`);
    }
  }

  aboutToDisappear(): void {
    if (this.isReigstered) {
      this.controller.deleteJavaScriptRegister('objName')
      this.controller.deleteJavaScriptRegister('objTestName')
      this.controller.deleteJavaScriptRegister('objAsyncName')
    }
  }

  build() {
    Column() {
      Button('注册').onClick(() => {
        this.registerProxy()
      })
      Web({
        src: $rawfile('index.html'),//$rawfile('index.html')
        controller: this.controller
      })
        .javaScriptAccess(true)
        // .javaScriptProxy({  直接注册javascript
        //   object: this.testObjtest,
        //   name:'objName',
        //   methodList: ['test', 'toString', 'testNumber'],
        //   asyncMethodList: ['asyncTestBool'],
        //   controller: this.controller
        // })

    }
    .height('100%')
    .width('100%')
  }
}