import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keybord_library/key_style_mode.dart';

class KeyBoardBtn extends StatefulWidget {
  final KeyMode keyMode;
  final VoidCallback? onPress;
  final double width;
  final double height;

  const KeyBoardBtn(this.keyMode, {Key? key, this.onPress, this.width = 0, this.height = 0}) : super(key: key);

  @override
  _KeyBoardBtnState createState() => _KeyBoardBtnState();
}

class _KeyBoardBtnState extends State<KeyBoardBtn> {
  late KeyStyleMode keyStyleMode;
  bool isPress = false;

  @override
  void initState() {
    super.initState();
    keyStyleMode = widget.keyMode.keyStyleMode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        setState(() {
          isPress = true;
        });
      },
      onTapUp: (e) {
        tapCancel();
      },
      onTapCancel: () {
        tapCancel();
      },
      onTap: widget.onPress,
      child: Container(
        color: isPress ? keyStyleMode.pressBgColor : keyStyleMode.commonBgColor,
        alignment: Alignment.center,
        child: Text(
          widget.keyMode.title,
          style: TextStyle(
              fontSize: keyStyleMode.textSize,
              color: isPress ? keyStyleMode.pressTextColor : keyStyleMode.commonTextColor),
        ),
      ),
    );
  }

  void tapCancel() {
    Future.delayed(Duration(milliseconds: 80), () {
      if (mounted) {
        setState(() {
          isPress = false;
        });
      }
    });
  }
}
