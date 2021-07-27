# keybord_library

A new Flutter project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


##
 1.数字键盘使用
   支持绑定多个输入框，并且支持内部处理输入的长度和大小的控制
 ```
  List<InputLimitMode> limits = [];
    limits.add(InputLimitMode(controller, focusNode, enableInputPoint: true, inputType: 0, maxLength: 10));

     NumKeyBoard(
        limits,
        KeyStyleMode(),
        240,
        294,
        bgColor: Colors.blue,
        )
 
  ```

 2.全键盘
   暂时只支持绑定一个TextField，内容改变可设置监听流，快速输入只会过滤掉中间点击回调，可设置间隔时间，默认500ms
  ```
    final StreamController _streamController = StreamController.broadcast();
    _streamController.stream.listen((event) {});
    BigKeyBoard(
                  KeyStyleMode(textSize: 10),
                  controller,
                  400,
                  160,
                  streamController: _streamController,
                  closeCallBack: () {
                    setState(() {
                      showBigKeyBoard = false;
                    });
                  },
                )
  ``` 

  