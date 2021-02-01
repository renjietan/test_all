import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/config/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @description: 公用TabBar
/// @params:
/// @fileName: SimpleAppBar.dart
/// @author: 谭人杰
/// @date: 2020-09-16 17:31:32
/// @后台人员:
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// @description: 是否显示leading
  final bool isShowLeading;

  /// @description: 左侧leading
  final Widget leading;

  /// @description: title
  /// 可传入文本或widget
  final dynamic title;

  /// @description: 右侧按钮
  final List<Widget> actions;

  /// @description: 背景色
  final Color backgroundColor;

  /// @description: 是否文本居中
  final bool isCenterTitle;

  /// @description: 渐变色
  final List<Color> linearGradient;

  /// @description: 投影
  final double elevation;

  final PreferredSizeWidget bottom;

  const SimpleAppBar({
    Key key,
    this.isShowLeading = true,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
    this.isCenterTitle = true,
    this.linearGradient,
    this.elevation = 1,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleType = this.title.runtimeType.toString();

    return AppBar(
      title: titleType == "String"
          ? Text(
              "${this.title}",
              style: TextStyle(
                fontSize: AppBarConfig.textFontSize,
              ),
            )
          : this.title,
      leading: Navigator.of(context).canPop()
          ? this.leading ??
              IconButton(
                icon: Icon(
                  Icons.chevron_left_outlined,
                ),
                onPressed: () {
                  BaseConfig.navigatorKey.currentState.pop();
                },
              )
          : null,
      backgroundColor: this.backgroundColor ?? AppBarConfig.backgroundColor,
      centerTitle: isCenterTitle,
      actions: this.actions ?? [],
      iconTheme: IconThemeData(
        color: AppBarConfig.iconColor,
        size: AppBarConfig.iconFontSize,
      ),
      bottom: bottom,
      elevation: elevation,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: linearGradient ?? AppBarConfig.gradient,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom?.preferredSize?.height ?? kToolbarHeight);
}
