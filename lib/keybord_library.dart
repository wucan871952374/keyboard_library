import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keybord_library/input_check_util.dart';
import 'package:keybord_library/key_board_btn.dart';
import 'package:keybord_library/key_style_mode.dart';
import 'package:rxdart/rxdart.dart';

/// A Calculator.
class NumKeyBoard extends StatelessWidget {
  final List<InputLimitMode> limits;
  final KeyStyleMode keyStyleMode;
  final double width;
  final double height;
  final double space;
  final double radius;
  final double runSpace;
  final Color bgColor;

  const NumKeyBoard(this.limits, this.keyStyleMode, this.width, this.height,
      {Key? key, this.space = 10, this.runSpace = 10, this.bgColor = Colors.white, this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<KeyMode> keys = initKeyBtns();
    List<Widget> keyBtns = [];
    double btnWidth = (width - space * 4) / 3;
    double btnHeight = (height - runSpace * 5) / 4;
    keys.forEach((keyMode) {
      keyBtns.add(KeyBoardBtn(
        keyMode,
        radius: radius,
        onPress: () {
          keyPress(keyMode);
        },
        width: btnWidth,
        height: btnHeight,
      ));
    });

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        width: width,
        height: height,
        color: bgColor,
        padding: EdgeInsets.only(top: runSpace),
        child: Wrap(
          spacing: space,
          runSpacing: runSpace,
          alignment: WrapAlignment.center,
          children: keyBtns,
        ),
      ),
    );
  }

  List<KeyMode> initKeyBtns() {
    List<KeyMode> keys = [];
    keys.add(KeyMode(keyStyleMode, '1'));
    keys.add(KeyMode(keyStyleMode, '2'));
    keys.add(KeyMode(keyStyleMode, '3'));
    keys.add(KeyMode(keyStyleMode, '4'));
    keys.add(KeyMode(keyStyleMode, '5'));
    keys.add(KeyMode(keyStyleMode, '6'));
    keys.add(KeyMode(keyStyleMode, '7'));
    keys.add(KeyMode(keyStyleMode, '8'));
    keys.add(KeyMode(keyStyleMode, '9'));
    keys.add(KeyMode(keyStyleMode, '0'));
    keys.add(KeyMode(keyStyleMode, '.'));
    keys.add(KeyMode(keyStyleMode, '退格', inputType: 1));
    return keys;
  }

  keyPress(KeyMode keyMode) {
    InputLimitMode? limitMode = findCurrentFocusMode();
    if (limitMode == null) {
      return;
    }
    if (keyMode.inputType == 0) {
      if (limitMode.inputType == 0) {
        //字符串
        CheckInputUtil.inputStringCheck(limitMode.controller, keyMode.title,
            canInputPoint: limitMode.enableInputPoint, maxLength: limitMode.maxLength);
      } else if (limitMode.inputType == 1) {
        //数字
        CheckInputUtil.inputNumCheck(limitMode.controller, keyMode.title,
            enableInputDecimal: limitMode.enableInputPoint,
            maxInput: limitMode.maxInput,
            maxLengthInteger: limitMode.maxLength,
            maxLengthDecimal: limitMode.maxLengthDecimal);
      }
    } else {
      TextEditingController controller = limitMode.controller;
      String text = controller.text;
      if (text.isNotEmpty) {
        controller.text = text.substring(0, text.length - 1);
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
      }
    }
  }

  InputLimitMode? findCurrentFocusMode() {
    InputLimitMode? limitMode;
    limits.forEach((mode) {
      if (mode.focusNode.hasFocus) {
        limitMode = mode;
      }
    });
    return limitMode;
  }
}

class BigKeyBoard extends StatefulWidget {
  final KeyStyleMode keyStyleMode;
  final Color lineColor;
  final double width;
  final double height;
  final int debounce;
  final TextEditingController controller;
  final int maxLength;
  final StreamController? streamController;
  final VoidCallback? closeCallBack;

  const BigKeyBoard(this.keyStyleMode, this.controller, this.width, this.height,
      {Key? key,
      this.lineColor = Colors.black38,
      this.maxLength = 20,
      this.debounce = 500,
      this.streamController,
      this.closeCallBack})
      : super(key: key);

  @override
  _BigKeyBoardState createState() => _BigKeyBoardState();
}

class _BigKeyBoardState extends State<BigKeyBoard> {
  late KeyStyleMode keyStyleMode;
  final _keyPressSubject = BehaviorSubject<KeyMode>();
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    keyStyleMode = widget.keyStyleMode;
    _subscription = _keyPressSubject.debounceTime(Duration(milliseconds: widget.debounce)).listen((keyMode) {
      widget.streamController?.add(keyMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<KeyMode> keys = initKeyBtns();
    List<Widget> keyBtns = [];
    double btnWidth = (widget.width - 11) / 10;
    double btnHeight = (widget.height - 5) / 4;
    keys.forEach((keyMode) {
      keyBtns.add(KeyBoardBtn(
        keyMode,
        onPress: () {
          dealKeyPress(keyMode);
        },
        width: keyMode.inputType == 1 ? btnWidth * 2 : btnWidth,
        height: btnHeight,
      ));
    });
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.lineColor,
      padding: EdgeInsets.only(top: 1),
      child: Wrap(
        spacing: 1,
        runSpacing: 1,
        alignment: WrapAlignment.center,
        children: keyBtns,
      ),
    );
  }

  List<KeyMode> initKeyBtns() {
    List<KeyMode> keys = [];
    keys.add(KeyMode(keyStyleMode, '1'));
    keys.add(KeyMode(keyStyleMode, '2'));
    keys.add(KeyMode(keyStyleMode, '3'));
    keys.add(KeyMode(keyStyleMode, '4'));
    keys.add(KeyMode(keyStyleMode, '5'));
    keys.add(KeyMode(keyStyleMode, '6'));
    keys.add(KeyMode(keyStyleMode, '7'));
    keys.add(KeyMode(keyStyleMode, '8'));
    keys.add(KeyMode(keyStyleMode, '9'));
    keys.add(KeyMode(keyStyleMode, '0'));
    keys.add(KeyMode(keyStyleMode, 'q'));
    keys.add(KeyMode(keyStyleMode, 'w'));
    keys.add(KeyMode(keyStyleMode, 'e'));
    keys.add(KeyMode(keyStyleMode, 'r'));
    keys.add(KeyMode(keyStyleMode, 't'));
    keys.add(KeyMode(keyStyleMode, 'y'));
    keys.add(KeyMode(keyStyleMode, 'u'));
    keys.add(KeyMode(keyStyleMode, 'i'));
    keys.add(KeyMode(keyStyleMode, 'o'));
    keys.add(KeyMode(keyStyleMode, 'p'));
    keys.add(KeyMode(keyStyleMode, 'a'));
    keys.add(KeyMode(keyStyleMode, 's'));
    keys.add(KeyMode(keyStyleMode, 'd'));
    keys.add(KeyMode(keyStyleMode, 'f'));
    keys.add(KeyMode(keyStyleMode, 'g'));
    keys.add(KeyMode(keyStyleMode, 'h'));
    keys.add(KeyMode(keyStyleMode, 'j'));
    keys.add(KeyMode(keyStyleMode, 'k'));
    keys.add(KeyMode(keyStyleMode, 'l'));
    keys.add(KeyMode(keyStyleMode, '清空', inputType: 2));
    keys.add(KeyMode(keyStyleMode, '关闭', inputType: 3));
    keys.add(KeyMode(keyStyleMode, 'z'));
    keys.add(KeyMode(keyStyleMode, 'x'));
    keys.add(KeyMode(keyStyleMode, 'c'));
    keys.add(KeyMode(keyStyleMode, 'v'));
    keys.add(KeyMode(keyStyleMode, 'b'));
    keys.add(KeyMode(keyStyleMode, 'n'));
    keys.add(KeyMode(keyStyleMode, 'm'));
    keys.add(KeyMode(keyStyleMode, '退格', inputType: 1));
    return keys;
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _keyPressSubject.close();
  }

  ///处理按键点击
  void dealKeyPress(KeyMode keyMode) {
    // 0  表示输入， 1.表示删除一位，2.表示清空  3.表示关闭
    var controller = widget.controller;
    int maxLength = widget.maxLength;
    String text = controller.text;
    switch (keyMode.inputType) {
      case 0:
        if (text.length < maxLength) {
          controller.text = "$text${keyMode.title}";
          _keyPressSubject.add(keyMode);
        }
        break;
      case 1:
        if (text.isNotEmpty) {
          controller.text = text.substring(0, text.length - 1);
          _keyPressSubject.add(keyMode);
        }
        break;
      case 2:
        if (text.isNotEmpty) {
          controller.text = '';
        }
        break;
      case 3:
        if (widget.closeCallBack != null) {
          widget.closeCallBack!();
        }
        break;
    }
  }
}
