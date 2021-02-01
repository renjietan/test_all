import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/enumSum.dart';
import 'package:flutter_appclient/mobileUI/config/button.dart';

/// @description: 图标按钮
/// @fileName: iconTextButton.dart
/// @author: 谭人杰
/// @date: 2020-10-12 20:59:03
/// @后台人员:

class IconTextButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final IconTextAlignment iconTextAlignment;
  final VoidCallback callback;
  final ValueChanged<bool> onHighlightChanged;
  final IconTextType iconTextType;
  final EdgeInsets padding;
  final Color color;
  final Color textColor;
  final Color disabledColor;
  final Color highlightColor;
  final Color splashColor;
  final double elevation;
  final double highlightElevation;
  final double disabledElevation;

  const IconTextButton({
    Key key,
    this.icon,
    this.label,
    this.iconTextAlignment = IconTextAlignment.iconLeftTextRight,
    this.iconTextType = IconTextType.rounded_rectangle,
    this.padding,
    @required this.callback,
    this.onHighlightChanged,
    this.color,
    this.textColor,
    this.disabledColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
  })  : assert(icon != null),
        assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: this.color ?? ButtonConfig.backgroundColor,
      child: iconTextAlignment == IconTextAlignment.iconLeftTextRight
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                icon,
                SizedBox(width: 8.0),
                label,
              ],
            )
          : iconTextAlignment == IconTextAlignment.iconRightTextLeft
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    label,
                    SizedBox(width: 8.0),
                    icon,
                  ],
                )
              : iconTextAlignment == IconTextAlignment.iconTopTextBottom
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        icon,
                        SizedBox(height: 8.0),
                        label,
                        SizedBox(height: 4.0),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 4.0),
                        label,
                        SizedBox(height: 8.0),
                        icon,
                      ],
                    ),

      ///点击回调函数
      onPressed: this.callback == null ? null : () => callback(),

      ///按钮按下时回调 value = true
      ///按钮抬起时回调 value = false
      ///要先于 onPressed  类似 mouseUP  mouseDown
      onHighlightChanged:
          this.onHighlightChanged == null ? null : onHighlightChanged,

      ///配制按钮上文本的颜色
      textColor: this.textColor ?? ButtonConfig.textColor,

      ///未设置点击时的背景颜色
      disabledColor: this.disabledColor ?? ButtonConfig.disabledColor,

      ///按钮点击下的颜色
      highlightColor: this.highlightColor ?? ButtonConfig.highlightColor,

      ///水波方的颜色
      splashColor: this.splashColor ?? ButtonConfig.splashColor,

      ///按钮的阴影
      elevation: this.elevation ?? ButtonConfig.elevation,

      ///按钮按下时的阴影高度
      highlightElevation: this.highlightElevation ?? ButtonConfig.elevation,

      ///未设置点击时的阴影高度
      disabledElevation: this.disabledElevation ?? ButtonConfig.elevation,
      shape: iconTextType == IconTextType.rounded_rectangle
          ? RoundedRectangleBorder(
              side: BorderSide(
                width: ButtonConfig.borderWidth,
                color: ButtonConfig.borderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(ButtonConfig.radius),
              ),
            )
          : StadiumBorder(
              side: BorderSide(
                width: ButtonConfig.borderWidth,
                color: ButtonConfig.borderColor,
              ),
            ),
      padding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}
