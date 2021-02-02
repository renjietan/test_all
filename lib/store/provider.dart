import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import '../utils/sputils.dart';

//状态管理
class Store {
  Store._internal();

  //全局初始化
  static init(Widget child) {
    //多个Provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: UserInfoStore(SPUtils.getUserInfo())),
        ChangeNotifierProvider.value(value: AppStatus(TAB_HOME_INDEX)),
        ChangeNotifierProvider.value(
          value: BlueStatus(0),
        ),
        ChangeNotifierProvider.value(value: BlueData("0")),
        ChangeNotifierProvider.value(value: DeviceList({})),
      ],
      child: child,
    );
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T of<T>(BuildContext context, {bool listen = true}) {
    return Provider.of<T>(context, listen: listen);
  }

  // 不会引起页面的刷新，只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}

///用户账户信息
class UserInfoStore with ChangeNotifier {
  String _userInfo;

  UserInfoStore(this._userInfo);

  String get userInfo => _userInfo;

  set userInfo(String userInfo) {
    _userInfo = userInfo;
    SPUtils.saveUserInfo(userInfo);
    notifyListeners();
  }
}

///主页
const int TAB_HOME_INDEX = 0;

///我的
const int TAB_PROFILE_INDEX = 1;

///应用状态
class AppStatus with ChangeNotifier {
  //主页tab的索引
  int _tabIndex;

  AppStatus(this._tabIndex);

  int get tabIndex => _tabIndex;

  set tabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }
}

///蓝牙数据
class BlueData with ChangeNotifier {
  //主页tab的索引
  String _blueData;

  BlueData(this._blueData);

  String get blueData => _blueData;

  set blueData(String blueData) {
    _blueData = blueData;
    notifyListeners();
  }
}

class DeviceList with ChangeNotifier {
  //主页tab的索引
  Map<String, ScanResult> _deviceList;

  DeviceList(this._deviceList);

  Map<String, ScanResult> get deviceList => _deviceList;

  set deviceList(Map<String, ScanResult> deviceList) {
    _deviceList = deviceList;
    notifyListeners();
  }
}

///应用状态
class BlueStatus with ChangeNotifier {
  //主页tab的索引
  int _blueStatus;

  BlueStatus(this._blueStatus);

  int get blueStatus => _blueStatus;

  set blueStatus(int blueStatus) {
    _blueStatus = blueStatus;
    notifyListeners();
  }
}
