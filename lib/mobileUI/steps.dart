import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Steps extends StatelessWidget {
  final Axis direction;
  final List steps;
  final double size;
  final Map<String, dynamic> path;
  const Steps({
    Key key,
    @required this.direction,
    this.steps,
    this.size,
    this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: direction,
      itemCount: steps.length,
      itemBuilder: (context, index) => Stack(
        children: <Widget>[
          Positioned(
            top: direction == Axis.horizontal
                ? 16 + size * 2.14 / 2 - 5 / 2
                : size * 6.42,
            bottom: direction == Axis.horizontal ? null : 0,
            left: direction == Axis.horizontal
                ? 0
                : 16 + size * 2.14 / 2 - 5 / 2.5,
            right: direction == Axis.horizontal ? 0 : null,
            height: direction == Axis.horizontal ? path['width'] : null,
            width: direction == Axis.horizontal ? null : path['width'],
            child: Container(
              color: path['color'],
            ),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Text(
                    "${steps[index]['label'] ?? ""}",
                    style: TextStyle(
                      color: steps[index]['color'],
                      fontSize: size,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  padding: EdgeInsets.all(6),
                  width: size * 2.14,
                  height: size * 2.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: steps[index]['background'] ?? Colors.transparent,
                    border: Border.all(
                      width: 10,
                      color: path['color'] ?? Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(size * 2.14),
                  ),
                ),
                steps[index]['content'] != null
                    ? direction == Axis.horizontal
                        ? steps[index]['content']
                        : Expanded(
                            child: steps[index]['content'],
                          )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
