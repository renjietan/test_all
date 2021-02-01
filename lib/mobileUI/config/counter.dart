import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterConfig {
  static final double btnWidth = 20;
  static final double btnHeight = 20;
  static final Color btnColor = Color.fromRGBO(62, 103, 255, 1);
  static final double btnFontSize = 12;
  static final Color btnTextColor = Colors.white;
  static final Color background = Colors.transparent;
  static final double width = 100;
  static final TextStyle textStyle = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    color: Colors.black,
  );
}
