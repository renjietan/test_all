import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/config/Avatar.dart';
import 'package:flutter_appclient/utils/verify.dart';

/// @description: 头像 地址支持网络图片以及本地图片
/// @params:
/// @fileName: simpleCircleAvatar.dart
/// @author: 谭人杰
/// @date: 2020-10-12 20:44:38
/// @后台人员:
class SimpleCirCleAvatar extends StatelessWidget {
  final double radius;
  final String url;
  final double borderWidth;
  final Color borderColor;
  const SimpleCirCleAvatar({
    Key key,
    @required this.url,
    this.radius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.radius == null ? AvatarConfig.radius : this.radius * 2,
      height: this.radius == null ? AvatarConfig.radius : this.radius * 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: this.borderWidth ?? AvatarConfig.borderWidth,
            color: this.borderColor ?? AvatarConfig.borderColor,
          ),
          shape: BoxShape.rectangle,
        ),
        child: CircleAvatar(
          backgroundImage: Verify.isHttp(this.url)
              ? NetworkImage("$url")
              : AssetImage(
                  "$url",
                ),
        ),
      ),
    );
  }
}
