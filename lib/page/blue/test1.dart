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
          scanResults[r.device.name] = r;
          if (r.device.name.length > 0) {
            // allBlueDevice.add(r.device.name);
            allBlueDevice["${r.device.name}"] = "${r.device.id.id}";
            // getBleScanNameAry();
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
          device.disconnect().then((res) {
            discoverServicesBle();
          }).catchError((err) {
            print(err);
          });
        }
      });
    });
  }

  // static List getBleScanNameAry() {
  //   //更新过滤蓝牙名字
  //   List distinctIds = allBlueDevice.toSet().toList();
  //   allBlueDevice = distinctIds;
  //   return allBlueDevice;
  // }

  // static autoConnectionBle() {
  //   String deviceId = SPUtils.getblueId();
  //   if (deviceId == "") {
  //     return;
  //   }
  //   ScanResult r = scanResults[
  //       allBlueDevice.values.toList().indexWhere((item) => item == deviceId)];
  //   print(r);
  // }

  static connectionBle(int blueIndex) {
    device?.disconnect().then((res) {
      ScanResult r = scanResults[allBlueDevice.keys.toList()[blueIndex]];
      device = r.device;
      SPUtils.saveBlueId(device.id.id);
      // 停止扫描
      // flutterBlue.stopScan();

      discoverServicesBle();
    });

    // for (var i = 0; i < allBlueDevice.length; i++) {
    //   bool isBleName = allBlueDevice[i].contains("bleName");
    //   if (isBleName) {

    //   }
    // }
  }

  static discoverServicesBle() async {
    await device
        .connect(autoConnect: false, timeout: Duration(seconds: 10))
        .then((res) {
      
    }).catchError((err) {
      print(err);
    });
    List<BluetoothService> services = await device.discoverServices();
    // var service = services[0].uuid.toString();
    services.forEach((service) {
      if (service.uuid.toString().toUpperCase().substring(4, 8) == "FFB0") {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        mCharacteristic = characteristics
            .where((item) =>
                item.uuid.toString().split("-")[0].indexOf("ffb") >= 0)
            .toList()[0];
        Timer(const Duration(seconds: 30), () {
          dataCallbackBle();
        });
        // characteristics.forEach((characteristic) {
        //   var valuex = characteristic.uuid.toString();
        //   print("所有特征值 --- $valuex");
        //   mCharacteristic = characteristic;

        // });
      }
    });
    // print("${services[2].uuid.toString()}");

    // services.forEach((service) {
    //   var value = service.uuid.toString();
    //   print("所有服务值 --- $value");
    //   if (service.uuid.toString().toUpperCase().substring(4, 8) == "FFF0") {
    //     List<BluetoothCharacteristic> characteristics = service.characteristics;
    //     characteristics.forEach((characteristic) {
    //       var valuex = characteristic.uuid.toString();
    //       print("所有特征值 --- $valuex");
    //       if (characteristic.uuid.toString() ==
    //           "0000fff1-0000-1000-8000-xxxxxxxx") {
    //         print("匹配到正确的特征值");
    //         mCharacteristic = characteristic;

    //         const timeout = const Duration(seconds: 30);
    //         Timer(timeout, () {
    //           dataCallbackBle();
    //         });
    //       }
    //     });
    //   }
    //   // do something with service
    // });
  }

  static dataCallbackBle() async {
    await mCharacteristic.setNotifyValue(true);
    // device.state.listen(
    //   (BluetoothDeviceState newState) {
    //     if (newState == BluetoothDeviceState.disconnected) {
    //       // 取消之前的监听函数
    //       _notifyListenControl?.cancel();
    //       // 取消监听
    //       mCharacteristic.setNotifyValue(false);
    //     }
    //   },
    // );

    mCharacteristic.value.listen((value) {
      // do something with new value
      // print("我是蓝牙返回数据 - $value");
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
