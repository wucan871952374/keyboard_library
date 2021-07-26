import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keybord_library/input_check_util.dart';
import 'package:keybord_library/key_board_btn.dart';
import 'package:keybord_library/key_style_mode.dart';

/// A Calculator.
class NumKeyBoard extends StatelessWidget {
  final List<InputLimitMode> limits;
  final KeyStyleMode keyStyleMode;
  final double width;
  final double height;
  final double space;
  final double runSpace;
  final Color bgColor;

  const NumKeyBoard(this.limits, this.keyStyleMode, this.width, this.height,
      {Key? key, this.space = 10, this.runSpace = 10, this.bgColor = Colors.white})
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
        onPress: () {
          keyPress(keyMode);
        },
        width: btnWidth,
        height: btnHeight,
      ));
    });

    return Container(
      width: width,
      height: height,
      color: bgColor,
      child: Wrap(
        spacing: space,
        runSpacing: runSpace,
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
        controller.text = text.substring(1, text.length);
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
