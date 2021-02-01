import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appclient/mobileUI/config/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({
    Key key,
    this.leading,
    this.onClear,
    this.onSearch,
    this.action,
    this.backgroundColor,
    this.inputHeight,
    this.leftIconColor,
    this.leftIconSize,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIconBgColor,
  }) : super(key: key);

  /// 搜索框左侧图标 大小
  final double leftIconSize;

  /// 搜索框左侧图标 颜色
  final Color leftIconColor;

  /// 搜索框右侧图标 大小
  final double rightIconSize;

  /// 搜索框右侧图标 颜色
  final Color rightIconColor;

  /// 搜索框右侧图标 背景色
  final Color rightIconBgColor;

  /// 搜索框高度
  final double inputHeight;

  final Widget leading;
  final List<Widget> action;
  // 点击取消回调
  final VoidCallback onClear;

  // 点击键盘搜索回调
  final ValueChanged<String> onSearch;

  /// 搜索框背景色
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return _AppBar(
      key: key,
      leading: leading,
      onSearch: onSearch,
      onClear: onClear,
      action: action,
      inputHeight: inputHeight,
      leftIconColor: leftIconColor,
      leftIconSize: leftIconSize,
      rightIconColor: rightIconColor,
      rightIconSize: rightIconSize,
      rightIconBgColor: rightIconBgColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBar extends StatefulWidget {
  _AppBar({
    Key key,
    this.leading,
    this.onClear,
    this.onSearch,
    this.action,
    this.backgroundColor,
    this.inputHeight,
    this.leftIconColor,
    this.leftIconSize,
    this.rightIconColor,
    this.rightIconSize,
    this.rightIconBgColor,
  }) : super(key: key);

  /// 搜索框左侧图标 大小
  final double leftIconSize;

  /// 搜索框左侧图标 颜色
  final Color leftIconColor;

  /// 搜索框右侧图标 大小
  final double rightIconSize;

  /// 搜索框右侧图标 颜色
  final Color rightIconColor;

  /// 搜索框右侧图标 背景色
  final Color rightIconBgColor;

  /// 搜索框高度
  final double inputHeight;

  // 头部组件 可选
  final Widget leading;

  final List<Widget> action;

  // 点击取消回调 可选
  final VoidCallback onClear;

  // 点击键盘搜索回调 可选
  final ValueChanged<String> onSearch;

  /// 搜索框背景色
  final Color backgroundColor;
  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<_AppBar> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  // 搜索面板
  Widget _searchPanel() {
    ValueChanged<String> _onSearch = widget.onSearch ?? (val) {};
    VoidCallback _onClear = widget.onClear ?? () {};

    return Container(
      height: widget.inputHeight ?? kToolbarHeight - 18,
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(15),
        right: ScreenUtil().setWidth(15),
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppBarConfig.searchBgColor,
        borderRadius: BorderRadius.circular(AppBarConfig.radius),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: widget.leftIconColor ?? AppBarConfig.searchLeftIconColor,
            size: widget.leftIconSize ?? AppBarConfig.searchLeftIconSize,
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              style: TextStyle(fontSize: AppBarConfig.textFontSize),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                _onSearch(_controller.text);
                _focusNode.unfocus();
                VoidCallback _onClear = widget.onClear ?? () {};
                _onClear();
              },
              decoration: InputDecoration(
                // filled: true,
                // fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(AppBarConfig.radius),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _focusNode.unfocus();
              _controller.clear();
              _onClear();
            },
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: widget.rightIconBgColor ??
                    AppBarConfig.searchRightIconBgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.close,
                color:
                    widget.leftIconColor ?? AppBarConfig.searchRightIconColor,
                size: widget.leftIconSize ?? AppBarConfig.searchRightIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // action 组件
  List<Widget> _action() {
    return widget.action ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading,
      title: _searchPanel(),
      actions: _action(),
      automaticallyImplyLeading: false,
    );
  }
}
