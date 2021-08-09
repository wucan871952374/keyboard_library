import 'package:flutter/cupertino.dart';

import 'num_precision.dart';

class CheckInputUtil {
  /// 处理输入数字的校验
  static InputStatus inputNumCheck(TextEditingController controller, String inputValue,
      {dynamic maxInput, bool enableInputDecimal = true, int maxLengthInteger = 5, int maxLengthDecimal = 3}) {
    if (inputValue == '.') {
      if (enableInputDecimal && controller.text.isNotEmpty && !controller.text.contains('.')) {
        controller.text = "${controller.text}.";
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        return InputStatus.SUCCESS;
      }
      return InputStatus.FAILURE;
    }

    if (inputValue == '0' && controller.text == '0') {
      return InputStatus.FAILURE;
    }

    String oldText = controller.text;
    String newText = (controller.text == '0' && inputValue != '.') ? "$inputValue" : "$oldText$inputValue";
    if (maxInput != null && NP.minus(newText, maxInput) > 0) {
      return InputStatus.INPUTOUTMAX;
    }

    List<String> splitList = newText.split('.');
    if (splitList[0].length > maxLengthInteger) {
      return InputStatus.FAILURE;
    }

    if (splitList.length > 1 && splitList[1].length > maxLengthDecimal) {
      return InputStatus.FAILURE;
    }

    controller.text = newText;
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return InputStatus.SUCCESS;
  }

  ///处理字符串的输入校验
  static InputStatus inputStringCheck(TextEditingController controller, String inputValue,
      {bool canInputPoint = false, int? maxLength}) {
    if (inputValue == '.' && !canInputPoint) {
      return InputStatus.FAILURE;
    }

    if (maxLength != null && controller.text.length >= maxLength) {
      return InputStatus.INPUTOUTMAX;
    }

    controller.text = "${controller.text}$inputValue";
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return InputStatus.SUCCESS;
  }
}

enum InputStatus {
  SUCCESS,
  FAILURE,
  INPUTOUTMAX,
}
