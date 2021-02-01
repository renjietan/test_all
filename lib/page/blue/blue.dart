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
  Timer _autoConnTimer;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    BlueUtils.flutterBlue.stopScan();
    BlueUtils.device?.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    BlueUtils.init();
    BlueUtils.startBle();
    // _autoConnTimer = Timer.periodic(Duration(seconds: 10), (res) {

    // });
    // BlueUtils.getBleScanNameAry();
    _timer = Timer.periodic(Duration(seconds: 1), (res) {
      // _autoConnTimer.cancel();
      setState(() {
        _devicesList = BlueUtils.allBlueDevice.keys.toList();
      });
      // print(BlueUtils.allBlueDevice);
      // print(BlueUtils.scanResults);
    });
    // BlueUtils.client.state.listen((res) {
    //   Provider.of<BlueStatus>(context, listen: false).blueStatus = res.index;
    // });
    // BlueUtils.scanDevices((res) {
    //   if (res == "蓝牙暂为开启") {
    //     CustomRouter.openNotify(
    //       context,
    //       "蓝牙未开启",
    //       type: SimpleNotifyType.warn,
    //     );
    //   } else {
    //     if (res == null) {
    //       print("1");
    //     }
    //     if (res.length != 0) {
    //       List temp = res;
    //       setState(() {
    //         _devicesList = temp;
    //         print(_devicesList);
    //       });
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {
            BlueUtils.connectionBle(index);
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
