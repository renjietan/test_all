import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:flutter_appclient/utils/sputils.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class BlueUtils {
  static FlutterBlue flutterBlue;
  static BluetoothDevice device;
  static Map<String, ScanResult> scanResults;
  static Map allBlueDevice;
  static BluetoothCharacteristic mCharacteristic;
  static Map<int, dynamic> test;
  static init() {
    BluetoothDevice device;
    flutterBlue = FlutterBlue.instance;
    BluetoothCharacteristic mCharacteristic;

    device = device;
    scanResults = new Map();
    allBlueDevice = {};
    mCharacteristic = mCharacteristic;
    test = {};
  }

  static startBle() async {
    // timeout: Duration(seconds: 60)
    await flutterBlue.stopScan();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      List keys = test.keys.toList();
      test[keys.length] =
          "${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}";
      print(test);
      for (ScanResult r in results) {
        if (r.device.name.length > 0 ||
            r.device.type == BluetoothDeviceType.le) {
          scanResults[r.device.id.id] = r;
          Provider.of<DeviceList>(BaseConfig.navigatorKey.currentContext,
                  listen: false)
              .deviceList = scanResults;
        }
      }
      String deviceId = SPUtils.getblueId();
      if (deviceId == "") {
        return;
      }
      ScanResult cr;
      if (scanResults.containsKey("$deviceId")) {
        if (scanResults["$deviceId"].device.name == "MEDXING-IRT") {
          cr = scanResults["$deviceId"];
        }
      }
      // allBlueDevice.forEach((key, value) {
      //   if (value == deviceId) {
      //     cr = scanResults[key];
      //   }
      // });

      if (cr != null && device == null) {
        device = cr.device;
        discoverServicesBle();
      }
    });
  }

  static connectionBle(String blueID) {
    ScanResult r = scanResults[blueID];
    device = r.device;
    SPUtils.saveBlueId(device.id.id);
    // 停止扫描
    // flutterBlue.stopScan();
    if (device.id.id != r.device.id.id && device.name != r.device.name) {
      discoverServicesBle();
    }
  }

  static discoverServicesBle() async {
    await device?.disconnect();
    await device.connect(autoConnect: false, timeout: Duration(seconds: 10));

    List<BluetoothService> services = await device.discoverServices();
    // var service = services[0].uuid.toString();
    services.forEach((service) {
      if (service.uuid.toString().toUpperCase().substring(4, 8) == "FFB0") {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        mCharacteristic = characteristics
            .where((item) =>
                item.uuid.toString().split("-")[0].indexOf("ffb") >= 0)
            .toList()[1];
        Timer(const Duration(seconds: 30), () {
          dataCallbackBle();
        });
      }
    });
  }

  // device.state.listen((BluetoothDeviceState status) async {
  //       print("状态：$status");
  //       if (status == BluetoothDeviceState.disconnected) {
  //         await mCharacteristic?.setNotifyValue(false);
  //       }
  //     });
  static dataCallbackBle() async {
    await mCharacteristic.setNotifyValue(true);
    mCharacteristic.value.listen((value) {
      if (value == null) {
        print("我是蓝牙返回数据 - 空！！");
        return;
      }
      List data = [];
      for (var i = 0; i < value.length; i++) {
        String dataStr = value[i].toRadixString(16);
        if (dataStr.length < 2) {
          dataStr = "0" + dataStr;
        }
        String dataEndStr = "0x" + dataStr;
        data.add(dataEndStr);
      }

      if (data.length >= 15 && data[5] == "0x65") {
        double wd = int.parse(
                "0x" + data[15].split("0x")[1] + data[14].split("0x")[1]) /
            10;

        print("温度：$wd");
        Provider.of<BlueData>(BaseConfig.navigatorKey.currentContext,
                listen: false)
            .blueData = "$wd";
      }
    });
  }
}
