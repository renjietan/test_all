import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/config/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/config/enumSum.dart';

/// @description: 简易按钮
/// @params:
/// @fileName: SimpleButton.dart
/// @author: 谭人杰
/// @date: 2020-10-12 17:24:50
/// @后台人员:
class SimpleButton extends StatelessWidget {
  /// 按钮文本
  final String text;

  /// 按钮点击回调
  final VoidCallback callback;

  /// 按钮子widget,  如果传了child参数, text将失效
  final Widget child;

  /// mousedown mouseUp回调
  final ValueChanged<bool> onHighlightChanged;

  /// 文本颜色 如果传了child参数, textColor将失效
  final Color textColor;

  /// 禁用时按钮的颜色
  final Color disabledColor;

  /// 按钮按下时颜色
  final Color highlightColor;

  /// 水波纹颜色
  final Color splashColor;

  /// 阴影
  final double elevation;

  /// 禁用时 阴影
  final double disabledElevation;

  /// 按下时 阴影
  final double highlightElevation;

  ///背景色  当按钮被禁用时 color将失效,  disabledColor将生效
  final Color color;

  /// 宽度
  final double minWidth;

  ///高度
  final double height;

  /// 按钮类型
  final SimpleButtonType simpleButtonType;
  final Color disabledTextColor;
  const SimpleButton({
    Key key,
    this.text,
    this.callback,
    this.child,
    this.onHighlightChanged,
    this.textColor,
    this.disabledColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.color,
    this.minWidth,
    this.height,
    this.simpleButtonType = SimpleButtonType.rounded_rectangle,
    this.disabledTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height ?? ScreenUtil().setHeight(ButtonConfig.height),
      constraints: BoxConstraints(
        minWidth: this.minWidth ?? double.infinity,
        maxWidth: this.minWidth ?? double.infinity,
      ),
      child: MaterialButton(
        color: this.color ?? ButtonConfig.backgroundColor,
        disabledTextColor:
            this.disabledTextColor ?? ButtonConfig.disabledTextColor,
        child: child ??
            Text(
              "$text",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(ButtonConfig.fontSize),
              ),
            ),
        onPressed: this.callback == null ? null : () => callback(),
        onHighlightChanged: this.onHighlightChanged ?? (value) {},
        textColor: this.textColor ?? ButtonConfig.textColor,
        disabledColor: this.disabledColor ?? ButtonConfig.disabledColor,
        highlightColor: this.highlightColor ?? ButtonConfig.highlightColor,
        splashColor: this.splashColor ?? ButtonConfig.splashColor,
        elevation: this.elevation ?? ButtonConfig.elevation,
        highlightElevation: this.highlightElevation ?? ButtonConfig.elevation,
        disabledElevation: this.disabledElevation ?? ButtonConfig.elevation,
        shape: simpleButtonType == SimpleButtonType.rounded_rectangle
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
      ),
    );
  }
}
