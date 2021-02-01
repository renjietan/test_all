import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/config/textField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/config/baseConfig.dart';

class SimpleTextFormField extends StatefulWidget {
  /// 输入完成回调
  final ValueChanged<String> onInput;

  /// 背景色
  final Color background;

  /// 清楚按钮 回调
  final VoidCallback onClear;

  /// 高度
  final double height;

  /// 左侧文字
  final String title;

  /// 输入框文字 对齐方式
  final TextAlign textalign;

  /// 边框圆角
  final double borderRadius;

  /// 输入框文字大小
  final double textFontSize;

  /// 投影
  final List<BoxShadow> boxShadow;

  /// 线宽
  final double borderWidth;

  /// 线颜色
  final Color borderColor;
  SimpleTextFormField({
    Key key,
    this.onInput,
    this.background,
    this.onClear,
    this.height,
    this.title,
    this.textalign,
    this.borderRadius,
    this.textFontSize,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
  }) : super(key: key);

  @override
  _SimpleTextFormFieldState createState() => _SimpleTextFormFieldState();
}

class _SimpleTextFormFieldState extends State<SimpleTextFormField> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ValueChanged<String> _onSearch = widget.onInput ?? (val) {};
    VoidCallback _onClear = widget.onClear ?? () {};
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
          Text(
            "${widget.title ?? ""}",
            style: TextStyle(
              fontSize: ScreenUtil()
                  .setSp((widget.textFontSize ?? BaseConfig.baseFontSize) + 2),
            ),
          ),
          Expanded(
            child: TextField(
              scrollPadding: EdgeInsets.all(0),
              focusNode: _focusNode,
              controller: _controller,
              style: TextStyle(
                fontSize: widget.textFontSize ?? BaseConfig.baseFontSize,
              ),
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                _onSearch(_controller.text);
                _focusNode.unfocus();
              },
              textAlign: widget.textalign ?? TextAlign.start,
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
                color: Colors.black38,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: BaseConfig.baseFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
