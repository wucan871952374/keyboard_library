import 'package:flutter/material.dart';

///按键样式
class KeyStyleMode {
  Color commonTextColor;
  Color pressTextColor;
  Color commonBgColor;
  Color pressBgColor;
  double textSize;

  KeyStyleMode(
      {this.commonTextColor = Colors.black,
      this.pressTextColor = Colors.white,
      this.commonBgColor = Colors.white,
      this.pressBgColor = Colors.blueAccent,
      this.textSize = 20});
}

///按键
class KeyMode {
  KeyStyleMode keyStyleMode;
  String title;
  int inputType; // 0  表示输入， 1.表示删除一位，2.表示清空
  KeyMode(this.keyStyleMode, this.title, {this.inputType = 0});
}

///输入框输入内容控制模型
class InputLimitMode {
  TextEditingController controller;
  FocusNode focusNode;
  int inputType;
  dynamic? maxInput;
  bool enableInputPoint;
  int maxLength;
  int maxLengthDecimal;

  /// 0 表示输入字符串   1 表示输入数字
  InputLimitMode(this.controller, this.focusNode,
      {this.inputType = 0,
      this.maxInput,
      this.enableInputPoint = false,
      this.maxLength = 5,
      this.maxLengthDecimal = 3});
}
