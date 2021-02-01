import 'package:flutter/material.dart';
import 'package:flutter_appclient/mobileUI/AppBar/simpleAppBar.dart';
import 'package:flutter_appclient/page/blue/BlueUtils.dart';
import 'package:flutter_appclient/page/blue/blue.dart';
import 'package:flutter_appclient/tabbar/tab_center/tab_center.dart';
import 'package:flutter_appclient/tabbar/tab_home/tab_home.dart';
import 'package:flutter_appclient/tabbar/tab_owner/tab_owner.dart';
import 'package:flutter_appclient/tabbar/tab_test/tab_test.dart';
import 'package:flutter_appclient/utils/core/click.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<BottomNavigationBarItem> getTabs(BuildContext context) => [
        BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "中心", icon: Icon(Icons.center_focus_weak)),
        BottomNavigationBarItem(label: "测试", icon: Icon(Icons.textsms)),
        BottomNavigationBarItem(label: "我的", icon: Icon(Icons.person)),
      ];

  List getTitle(BuildContext context) => [
        SimpleAppBar(
          title: "首页",
        ),
        null,
        null,
        null,
      ];

  List<Widget> getTabWidget(BuildContext context) => [
        TabHome(),
        TabCenter(),
        TabTest(),
        TabOwner(),
      ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // BlueUtils.init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // BlueUtils.client?.
  }

  @override
  Widget build(BuildContext context) {
    var tabs = getTabs(context);
    var titles = getTitle(context);
    return Consumer(
        builder: (BuildContext context, AppStatus status, Widget child) {
      return WillPopScope(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: titles[status.tabIndex],
            body: IndexedStack(
              index: status.tabIndex,
              children: getTabWidget(context),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: tabs,
              //高亮  被点击高亮
              currentIndex: status.tabIndex,
              //修改 页面
              onTap: (index) {
                status.tabIndex = index;
              },

              type: BottomNavigationBarType.fixed,
            ),
          ),
          //监听导航栏返回,类似onKeyEvent
          onWillPop: () =>
              ClickUtils.exitBy2Click(status: _scaffoldKey.currentState));
    });
  }
}
