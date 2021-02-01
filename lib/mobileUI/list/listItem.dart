import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/config/list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/config/baseConfig.dart';

class ListItem extends StatelessWidget {
  final Color background;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final double horizontalPadding;
  final double height;
  final String title;
  final Widget titleWidget;
  final Widget iconWidget;
  final VoidCallback callback;
  final Widget contentWidget;
  const ListItem({
    Key key,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.horizontalPadding,
    this.title,
    this.titleWidget,
    this.iconWidget,
    this.callback,
    this.background,
    this.height,
    this.contentWidget,
  })  : assert((title == null && titleWidget != null) ||
            (title != null && titleWidget == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: double.infinity,
        height: this.height ?? ScreenUtil().setHeight(ListConfig.height),
        decoration: BoxDecoration(
          border: Border.all(
            width: this.borderWidth ?? ListConfig.borderWidth,
            color: this.borderColor ?? ListConfig.borderColor,
          ),
          borderRadius:
              BorderRadius.circular(this.borderRadius ?? ListConfig.radius),
          color: this.background ?? ListConfig.backgroundColor,
          boxShadow: [ListConfig.boxShadow],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: this.horizontalPadding ?? ListConfig.padding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title != null
                ? Text("$title",
                    style: TextStyle(fontSize: ListConfig.fontSize))
                : titleWidget != null
                    ? titleWidget
                    : Text("$title"),
            Expanded(child: this.contentWidget ?? SizedBox()),
            iconWidget ??
                Icon(
                  Icons.keyboard_arrow_right,
                  size: ListConfig.iconSize,
                ),
          ],
        ),
      ),
    );
  }
}
