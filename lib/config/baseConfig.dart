import 'package:flutter/material.dart';

class BaseConfig {
  BaseConfig._init();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static String baseUrl = "http://rap2api.taobao.org/app/mock/261004";

  /// APP主题色
  static final Color theme = Color(0xFF5AA6FD);

  /// 基础 padding
  static final double basePadding = 10.0;

  /// container背景色
  static final Color baseContainerBackground = Color(0x05373737);

  /// 阴影
  static final double elevation = 1.0;

  /// 基础线宽
  static final double baseBorderWidth = 1.0;

  /// start 头像不使用此圆角 @date:2020-10-12 15:50:27 @author: 谭人杰
  static final double baseRadius = 5.0;

  /// 基础文本字体大小
  static final double baseFontSize = 12.0;

  /// 投影
  static final BoxShadow baseBoxShadow = BoxShadow(
    offset: Offset(0.3, 0.3),
    color: Color(0x26161616),
    blurRadius: 0.3,
    spreadRadius: 0.3,
  );

  /// 灰色文字样式
  static final Color baseDisabledTextColor = Color(0x66161616);

  /// 禁用色
  static final Color baseDisabledColor = Color(0x66161616);
}
