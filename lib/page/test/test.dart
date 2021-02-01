import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/AppBar/simpleAppBar.dart';
import 'package:flutter_appclient/mobileUI/Button/simpleButton.dart';
import 'package:flutter_appclient/page/test/SumSimpleWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.addRect(
      Rect.fromCircle(
        center: Offset(0.0, 0.0),
        radius: 200,
      ),
    );
    Paint paint = Paint();
    paint.strokeWidth = 1;
    paint.color = Colors.red[200];
    canvas.drawCircle(Offset(20.0, 20.0), 20, paint);

    Path path2 = Path();
    path2.addOval(Rect.fromLTWH(100, 100, 100, 100));
    canvas.drawOval(Rect.fromLTRB(80, 10, 10, 80), paint);
  }

  @override
  bool shouldRepaint(TestPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TestPainter oldDelegate) => true;
}

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _value = 0;
  List<Color> _colorList = [
    Color(0xFF30B735),
    Color(0xFF5DBE2F),
    Color(0xFF96C62C),
    Color(0xFFF5BF27),
    Color(0xFFFDAA25),
    Color(0xFFFD9024),
    Color(0xFFFD7C23),
    Color(0xFFF75F25),
    Color(0xFFF04126),
    Color(0xFFE92629),
  ];

  @override
  Widget build(BuildContext context) {
    print(BaseConfig.navigatorKey);
    return Scaffold(
      // appBar: SimpleAppBar(
      //   title: "测试页面1",
      // ),
      appBar: SimpleAppBar(
        title: "111",
        // leading: Icon(
        //   Icons.ac_unit,
        // ),
        actions: [
          Icon(
            Icons.ac_unit_rounded,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        linearGradient: [
          Colors.black,
          Colors.black,
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              CustomPaint(
                size: Size(300, 300),
                painter: TestPainter(),
              ),
              SimpleButton(
                callback: () {
                  // Navigator.of(context).popUntil(ModalRoute.withName("/home"));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => SumSimpleWidget()),
                      (Route<dynamic> route) {
                    //返回的事false的都会被从路由队列里面清除掉
                    return route.isFirst;
                  });
                },
              )
            ],
          )),
    );
  }
}
