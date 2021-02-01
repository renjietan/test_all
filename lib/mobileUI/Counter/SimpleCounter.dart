import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appclient/mobileUI/config/button.dart';
import 'package:flutter_appclient/mobileUI/config/counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/config/enumSum.dart';

class SimpoleCountter extends StatefulWidget {
  final Color background;
  final double width;
  final Color btnColor;
  final double btnWidth;
  final double btnHeight;
  final double btnFontSize;
  final SimpleCounterButtonType buttonType;
  final int initvalue;
  final ValueChanged<String> callback;
  final Color btnTextColor;
  final TextStyle textStyle;
  SimpoleCountter({
    Key key,
    this.background,
    this.width,
    this.btnColor,
    this.btnHeight,
    this.btnWidth,
    this.btnFontSize,
    this.btnTextColor,
    this.buttonType = SimpleCounterButtonType.circle,
    this.initvalue,
    this.textStyle,
    @required this.callback,
  }) : super(key: key);

  @override
  _SimpoleCountterState createState() => _SimpoleCountterState();
}

class _SimpoleCountterState extends State<SimpoleCountter> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.initvalue == null ? "0" : "${widget.initvalue}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: widget.background ?? CounterConfig.background,
          width: widget.width ?? CounterConfig.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  switch (_controller.text) {
                    case "":
                      _controller.text = "0";
                      break;
                    case "0":
                      break;
                    default:
                      _controller.text = (int.parse(_controller.text == ""
                                  ? "0"
                                  : _controller.text) -
                              1)
                          .toString();
                  }
                  widget.callback(_controller.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: widget.btnTextColor ?? CounterConfig.btnTextColor,
                      fontSize: widget.btnFontSize ?? CounterConfig.btnFontSize,
                    ),
                  ),
                  width: widget.btnWidth ??
                      ScreenUtil().setWidth(CounterConfig.btnWidth),
                  height: widget.btnHeight ??
                      ScreenUtil().setWidth(CounterConfig.btnHeight),
                  decoration: BoxDecoration(
                    shape: widget.buttonType == SimpleCounterButtonType.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    color: widget.btnColor ?? CounterConfig.btnColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: CupertinoTextField(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0, color: Colors.transparent),
                      ),
                      style: widget.textStyle ?? CounterConfig.textStyle,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        widget.callback(value);
                      },
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(7),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('^[0-9][0-9]*'))
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.text = (int.parse(
                              _controller.text == "" ? "0" : _controller.text) +
                          1)
                      .toString();
                  widget.callback(_controller.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: widget.btnTextColor ?? CounterConfig.btnTextColor,
                      fontSize: widget.btnFontSize ?? CounterConfig.btnFontSize,
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: widget.buttonType == SimpleCounterButtonType.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    color: widget.btnColor ?? CounterConfig.btnColor,
                  ),
                  width: widget.btnWidth ??
                      ScreenUtil().setWidth(CounterConfig.btnWidth),
                  height: widget.btnHeight ??
                      ScreenUtil().setWidth(CounterConfig.btnHeight),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
