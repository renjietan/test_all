import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/config/enumSum.dart';
import 'package:flutter_appclient/page/blue/BlueUtils.dart';
import 'package:flutter_appclient/router/router.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Blue extends StatefulWidget {
  Blue({Key key}) : super(key: key);

  @override
  _BlueState createState() => _BlueState();
}

class _BlueState extends State<Blue> {
  List _devicesList = [];
  Timer _timer;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();

    super.dispose();
  }

  @override
  void initState() {
    // BlueUtils.init();
    // BlueUtils.startBle();
    _timer = Timer.periodic(Duration(seconds: 1), (res) async {
      setState(() {
        _devicesList = BlueUtils.allBlueDevice.keys.toList();
      });
    });
    // _test();
    super.initState();
  }

  _test() async {
    await BlueUtils.flutterBlue.connectedDevices.then((list) {
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onLongPress: () async {
            // BlueUtils.connectionBle(index);
            print(_devicesList[index]);
          },
          child: Container(
            height: ScreenUtil().setHeight(80),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              boxShadow: [BaseConfig.baseBoxShadow],
            ),
            child: Column(
              children: [
                Text("${_devicesList[index]}"),
              ],
            ),
          ),
        );
      },
      itemCount: _devicesList.length,
    );
  }
}
