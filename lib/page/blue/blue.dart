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
  @override
  void dispose() {
    // TODO: implement dispose
    // _timer.cancel();
    // BlueUtils.flutterBlue.stopScan();
    // BlueUtils.device?.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    // BlueUtils.init();
    // BlueUtils.startBle();
    // _autoConnTimer = Timer.periodic(Duration(seconds: 10), (res) {

    // });
    // BlueUtils.getBleScanNameAry();
    // _timer = Timer.periodic(Duration(seconds: 1), (res) {
    //   // _autoConnTimer.cancel();
    //   setState(() {
    //     _devicesList = BlueUtils.allBlueDevice.keys.toList();
    //   });
    //   // print(BlueUtils.allBlueDevice);
    //   // print(BlueUtils.scanResults);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("蓝牙"),
      ),
      body: Consumer(
        builder: (BuildContext context, DeviceList deviceList, Widget child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  String id =
                      "${deviceList.deviceList.values.toList()[index].device.id.id}";
                  await BlueUtils.flutterBlue.connectedDevices.then((connList) {
                    print(connList);
                    if (connList.length == 0) {
                      BlueUtils.connectionBle(id);
                    } else {
                      connList[0].disconnect().then((res) {
                        BlueUtils.connectionBle(id);
                      });
                    }
                    print(connList);
                    //
                  });
                },
                child: Container(
                  height: ScreenUtil().setHeight(80),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    boxShadow: [BaseConfig.baseBoxShadow],
                  ),
                  child: Column(
                    children: [
                      Text(
                          "${deviceList.deviceList.values.toList()[index].device.name}"),
                    ],
                  ),
                ),
              );
            },
            itemCount: deviceList.deviceList.values.toList().length,
          );
        },
      ),
    );
  }
}
