import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/AppBar/simpleAppBar.dart';


class TabTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "测试",
      ),
    );
  }
}
