import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/config/Icon.dart';

class IconText extends StatelessWidget {
  /// 文本
  final String text;

  /// 图标

  final Icon icon;

  /// 图标大小
  final double iconSize;

  /// 图标方向
  final Axis direction;

  /// 边距
  final EdgeInsetsGeometry padding;

  /// 文本样式
  final TextStyle style;

  /// 最大行
  final int maxLines;

  /// 是否允许换行
  final bool softWrap;

  /// 超出行为
  final TextOverflow overflow;

  /// 文本对齐方式
  final TextAlign textAlign;

  const IconText(this.text,
      {Key key,
      this.icon,
      this.iconSize,
      this.direction = Axis.horizontal,
      this.style,
      this.maxLines,
      this.softWrap,
      this.padding,
      this.textAlign,
      this.overflow = TextOverflow.ellipsis})
      : assert(direction != null),
        assert(overflow != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? Text(text ?? '', style: style)
        : text == null || text.isEmpty
            ? (padding == null ? icon : Padding(padding: padding, child: icon))
            : RichText(
                text: TextSpan(style: style, children: [
                  WidgetSpan(
                      child: IconTheme(
                    data: IconThemeData(
                      size: iconSize ??
                          (style == null || style.fontSize == null
                              ? IconConfig.iconSize
                              : style.fontSize + 1),
                      color: style == null ? null : style.color,
                    ),
                    child: padding == null
                        ? icon
                        : Padding(
                            padding: padding,
                            child: icon,
                          ),
                  )),
                  TextSpan(
                      text: direction == Axis.horizontal ? text : "\n$text"),
                ]),
                maxLines: maxLines,
                softWrap: softWrap ?? true,
                overflow: overflow ?? TextOverflow.clip,
                textAlign: textAlign ??
                    (direction == Axis.horizontal
                        ? TextAlign.start
                        : TextAlign.center),
              );
  }
}
