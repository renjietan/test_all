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

  static init() {
    BluetoothDevice device;
    flutterBlue = FlutterBlue.instance;
    BluetoothCharacteristic mCharacteristic;

    device = device;
    scanResults = new Map();
    allBlueDevice = {};
    mCharacteristic = mCharacteristic;
  }

  static startBle() {
    // timeout: Duration(seconds: 60)
    flutterBlue.stopScan().then((res) {
      flutterBlue.startScan();
      flutterBlue.scanResults.listen((results) {
        for (ScanResult r in results) {
          if (r.device.name.length > 0 ||
              r.device.type == BluetoothDeviceType.le) {
            scanResults[r.device.id.id] = r;
            Provider.of<DeviceList>(BaseConfig.navigatorKey.currentContext,
                    listen: false)
                .deviceList = scanResults;
            // allBlueDevice.add(r.device.name);
            // allBlueDevice["${r.device.name}"] = "${r.device.id.id}";
            // getBleScanNameAry();
          }
        }
        String deviceId = SPUtils.getblueId();
        if (deviceId == "") {
          return;
        }
        ScanResult cr;
        if (scanResults.containsKey("$deviceId")) {
          cr = scanResults["$deviceId"];
        }
        // allBlueDevice.forEach((key, value) {
        //   if (value == deviceId) {
        //     cr = scanResults[key];
        //   }
        // });

        if (cr != null && device == null) {
          device = cr.device;
          // device.disconnect().then((res) {
          //   discoverServicesBle();
          // }).catchError((err) {
          //   print(err);
          // });
          discoverServicesBle();
        }
      });
    });
  }

  static connectionBle(String blueID) {
    // device?.disconnect().then((res) {
    //   ScanResult r = scanResults[allBlueDevice.keys.toList()[blueIndex]];
    //   device = r.device;
    //   SPUtils.saveBlueId(device.id.id);
    //   // 停止扫描
    //   // flutterBlue.stopScan();

    //   discoverServicesBle();
    // });
    ScanResult r = scanResults[blueID];
    device = r.device;
    SPUtils.saveBlueId(device.id.id);
    // 停止扫描
    // flutterBlue.stopScan();

    discoverServicesBle();
  }

  static discoverServicesBle() async {
    await device
        .connect(autoConnect: false, timeout: Duration(seconds: 10))
        .then((res) {})
        .catchError((err) {
      print(err);
    });
    // device.state.listen((BluetoothDeviceState status) async {
    //   print("状态：${status}");
    //   if (status == BluetoothDeviceState.disconnected) {
    //     await mCharacteristic.setNotifyValue(false);
    //   } else if (status == BluetoothDeviceState.connected) {}
    // });
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

  static dataCallbackBle() async {
    await mCharacteristic.setNotifyValue(true);

    mCharacteristic.value.listen((value) {
      if (value == null) {
        print("我是蓝牙返回数据 - 空！！");
        return;
      }
      List data = [];
      List data2 = [];
      for (var i = 0; i < value.length; i++) {
        String dataStr = value[i].toRadixString(16);
        if (dataStr.length < 2) {
          dataStr = "0" + dataStr;
        }
        String dataEndStr = "0x" + dataStr;
        data.add(dataEndStr);
        data2.add(value[i].toRadixString(10));
      }

      if (data2.length >= 14 && data[5] == "0x65") {
        print("我是蓝牙返回数据 - $data");
        print("我是蓝牙2返回数据 - ${data2[14]}");
        Provider.of<BlueData>(BaseConfig.navigatorKey.currentContext,
                listen: false)
            .blueData = "${int.parse(data2[14]) / 10}";
      }
    });
  }
}
