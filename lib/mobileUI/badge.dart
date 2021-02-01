import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description:角标
/// @params:
/// @fileName: badge.dart
/// @author: 谭人杰
/// @date: 2020-09-29 20:39:10
///
///
/// Bdge(num: 20)

class Badge extends StatelessWidget {
  final int num;
  const Badge({
    Key key,
    @required this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(5),
            vertical: ScreenUtil().setWidth(3),
          ),
          color: Colors.red,
          child: Center(
            child: Text(
              "${this.num > 99 ? "99+" : this.num}",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(11),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
