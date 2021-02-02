import 'dart:math';
import 'package:flutter_appclient/utils/sputils.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

// class BlueUtils {
//   static FlutterBlue client = null;
//   static bool blueStatus = false;
//   static init() {
//     client = FlutterBlue.instance;
//   }

//   static scanDevices(Function callback) {
//     client.isOn.then((res) {
//       blueStatus = res;
//       if (res) {
//         client?.stopScan().then((res) {
//           client.startScan(timeout: Duration(seconds: 60));
//         });
//         client.scanResults.listen((res) {
//           callback(res);
//         });
//       } else {
//         callback("蓝牙暂为开启");
//       }
//     });
//   }
// }

class BlueUtils {
  static FlutterBlue flutterBlue;
  static BluetoothDevice device;
  static Map<String, ScanResult> scanResults;
  static Map allBlueDevice;
  static BluetoothCharacteristic mCharacteristic;
  static StreamSubscription _notifyListenControl;
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
    flutterBlue.startScan();
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        scanResults[r.device.name] = r;
        if (r.device.name.length > 0) {
          allBlueDevice["${r.device.name}"] = "${r.device.id.id}";
        }
      }
      String deviceId = SPUtils.getblueId();
      if (deviceId == "") {
        return;
      }
      ScanResult cr;
      allBlueDevice.forEach((key, value) {
        if (value == deviceId) {
          cr = scanResults[key];
        }
      });
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
  }

  static connectionBle(int blueIndex) {
    // device?.disconnect().then((res) {
    //   ScanResult r = scanResults[allBlueDevice.keys.toList()[blueIndex]];
    //   device = r.device;
    //   SPUtils.saveBlueId(device.id.id);
    //   // 停止扫描
    //   // flutterBlue.stopScan();

    //   discoverServicesBle();
    // });
    ScanResult r = scanResults[allBlueDevice.keys.toList()[blueIndex]];
    device = r.device;
    SPUtils.saveBlueId(device.id.id);
    // 停止扫描
    // flutterBlue.stopScan();

    discoverServicesBle();
  }

  static discoverServicesBle() async {
    await device.connect(autoConnect: false, timeout: Duration(seconds: 10));

    BluetoothDeviceState state = await device.state.first;
    device.state.listen((BluetoothDeviceState status) async {
      print("状态：${status}");
      if (status == BluetoothDeviceState.disconnected) {
        await mCharacteristic?.setNotifyValue(false);
        _notifyListenControl?.cancel();
      }
    });
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString().toUpperCase().substring(4, 8) == "FFB0") {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        List list = characteristics
            .where((item) =>
                item.uuid.toString().split("-")[0].indexOf("ffb") >= 0)
            .toList();
        if (list.length > 0) {
          mCharacteristic = list[0];
          Timer(const Duration(seconds: 30), () {
            dataCallbackBle();
          });
        }
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

      if (data2.length >= 14) {
        print("我是蓝牙返回数据 - $data");
        print("我是蓝牙2返回数据 - ${data2[14]}");
      }
    });
  }
}
