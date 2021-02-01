import 'package:flutter/material.dart';
import 'package:flutter_appclient/page/index.dart';
import 'package:flutter_appclient/page/userManger/login.dart';

///页面路由映射表
class RouteMap {
  static final routes = <String, WidgetBuilder>{
    //主页菜单
    '/home': (BuildContext context) => MainHomePage(),
    '/login': (BuildContext context) => LoginPage(),
  };
}
