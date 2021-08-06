import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keybord_library/key_style_mode.dart';
import 'package:keybord_library/r.dart';

class KeyBoardBtn extends StatefulWidget {
  final KeyMode keyMode;
  final VoidCallback? onPress;
  final double width;
  final double height;
  final double radius;

  const KeyBoardBtn(this.keyMode, {Key? key, this.onPress, this.width = 0, this.height = 0, this.radius = 0})
      : super(key: key);

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
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      child: GestureDetector(
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
          width: widget.width,
          height: widget.height,
          child: widget.keyMode.inputType == 1
              ? SizedBox(
                  width: 30,
                  height: 20,
                  child: Image.asset(
                    isPress ? R.assetsKeyboardDeleteWhite : R.assetsKeyboardDeleteBlack,
                    package: 'keybord_library',
                  ),
                )
              : Text(
                  widget.keyMode.title,
                  style: TextStyle(
                      fontSize: keyStyleMode.textSize,
                      color: isPress ? keyStyleMode.pressTextColor : keyStyleMode.commonTextColor),
                ),
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
