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
  Timer _timer;
  List<BluetoothDevice> _connectedDevices = [];
  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // _timer = Timer.periodic(Duration(seconds: 1), (res) async {
    //   List<BluetoothDevice> connectedDevices =
    //       await BlueUtils.flutterBlue.connectedDevices;
    //   setState(() {
    //     _connectedDevices = connectedDevices;
    //   });
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
              BluetoothDevice devices =
                  deviceList.deviceList.values.toList()[index].device;
              bool isContains = _connectedDevices
                      .where((item) => item.id.id == devices.id.id)
                      .length >
                  0;
              return InkWell(
                onTap: () async {
                  String id = "${devices.id.id}";
                  BlueUtils.connectionBle(id);
                  // await BlueUtils.flutterBlue.connectedDevices.then((connList) {
                  //   if (connList.length == 0) {

                  //   } else {
                  //     BlueUtils.connectionBle(id);
                  //   }

                  //   //
                  // });
                },
                child: Container(
                  // height: ScreenUtil().setHeight(80),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    boxShadow: [BaseConfig.baseBoxShadow],
                  ),
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(20),
                    ScreenUtil().setWidth(10),
                    ScreenUtil().setWidth(20),
                    ScreenUtil().setWidth(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${devices.name}"),
                          SizedBox(
                            height: 3,
                          ),
                          Text("${devices.id.id}"),
                        ],
                      ),
                      Container(
                        child: Text("${isContains ? '已连接' : ''}"),
                      ),
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
