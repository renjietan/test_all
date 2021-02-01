import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/config/textField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/config/baseConfig.dart';

class SimpleField extends StatefulWidget {
  /// 搜索回调
  final ValueChanged<String> onSearch;

  /// 整个组件的背景色
  final Color background;

  /// 点击清除按钮时的回调
  final VoidCallback onClear;

  /// 整个个组件高度
  final double height;

  /// 左侧widget  默认为搜索图标
  final Widget leftWidget;

  /// 文本框的文字居中方式
  final TextAlign searchTextAlign;

  /// 整个组件的线框宽度
  final double borderWidth;

  /// 整个组件的圆角
  final double borderRadius;

  /// 整个组件的线框颜色
  final Color borderColor;

  /// 文本框的字体大小
  final double textFontSize;

  /// 左侧图标的大小
  final double leftIconSize;
  final List<BoxShadow> boxShadow;
  SimpleField({
    Key key,
    this.onSearch,
    this.background,
    this.onClear,
    this.height,
    this.leftWidget,
    this.searchTextAlign,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.textFontSize,
    this.leftIconSize,
    this.boxShadow,
  }) : super(key: key);

  @override
  _EllipseFieldState createState() => _EllipseFieldState();
}

class _EllipseFieldState extends State<SimpleField> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ValueChanged<String> _onSearch = widget.onSearch ?? (val) {};
    VoidCallback _onClear = widget.onClear ?? () {};
    String oldText = "";

    return Container(
      height: widget.height ?? ScreenUtil().setHeight(TextFieldConfig.height),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10),
        right: ScreenUtil().setWidth(10),
      ),
      decoration: BoxDecoration(
        color: widget.background ?? TextFieldConfig.backgroundColor,
        border: Border.all(
          width: widget.borderWidth ?? TextFieldConfig.borderWidth,
          color: widget.borderColor ?? TextFieldConfig.borderColor,
        ),
        boxShadow: widget.boxShadow ?? [],
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? TextFieldConfig.radius,
        ),
        // BorderRadius.circular(widget.radius ?? BaseConfig.appBarRadius)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          widget.leftWidget ??
              Icon(
                Icons.search,
                color: TextFieldConfig.leftIconColor,
                size: widget.leftIconSize ?? TextFieldConfig.leftIconSize,
              ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              style: TextStyle(
                fontSize: widget.textFontSize ?? TextFieldConfig.fontSize,
              ),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                _onSearch(_controller.text);
                if (oldText == _controller.text) {
                  _focusNode.unfocus();
                } else {
                  oldText = _controller.text;
                }
              },
              textAlign: widget.searchTextAlign ?? TextAlign.start,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
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
                color: TextFieldConfig.rightIconBgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.close,
                color: TextFieldConfig.rightIconColor,
                size: TextFieldConfig.rightIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
