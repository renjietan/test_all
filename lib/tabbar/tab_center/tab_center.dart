import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/AppBar/simpleAppBar.dart';
import 'package:flutter_appclient/mobileUI/config/appbar.dart';

class TabCenter extends StatefulWidget {
  TabCenter({Key key}) : super(key: key);

  @override
  _TabCenterState createState() => _TabCenterState();
}

class _TabCenterState extends State<TabCenter> {
  double _appBarAlpha = 0;
  void _onScroll(offset) {
    double alpha = offset / 100;
    //把 alpha 值控制值 0-1 之间
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
    print(alpha);
    // print(alpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: Text(
          "中心",
          style: TextStyle(
            fontSize: AppBarConfig.textFontSize,
            color: _appBarAlpha <= 0.1
                ? Colors.white
                : Color.fromARGB((_appBarAlpha * 255).toInt(), 0, 0, 0),
          ),
        ),
        elevation: _appBarAlpha,
        // backgroundColor: Colors.white.withOpacity(_appBarAlpha),
        // backgroundColor: Colors.red,
        linearGradient: [
          Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
          Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
        ],
      ),
      body: NotificationListener(
        onNotification: (scrollNotification) {
          // print("scrollNotification.depth:${scrollNotification.depth}");
          if (scrollNotification is ScrollUpdateNotification &&
              scrollNotification.depth == 0) {
            _onScroll(scrollNotification.metrics.pixels);
          }
          return true;
        },
        child: ListView(
          children: List.generate(
            100,
            (index) => Container(
              height: 20,
              child: Text("1"),
            ),
          ),
        ),
      ),
    );
  }
}
