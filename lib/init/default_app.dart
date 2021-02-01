import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/utils/core/http.dart';

import 'package:flutter_appclient/init/splash.dart';
import 'package:flutter_appclient/router/route_map.dart';
import 'package:flutter_appclient/router/router.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:flutter_appclient/utils/sputils.dart';

import '../utils/utils.dart';

//默认App的启动
class DefaultApp {
  //运行app
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: BaseConfig.theme,
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    SPUtils.init().then((value) => runApp(Store.init(MyApp())));
    initApp();
  }

  //程序初始化操作
  static void initApp() {
    XHttp.init();
    CustomRouter.init();
  }
}

class MyApp extends StatelessWidget {
  @override

  ///  @date:2020-09-17 15:46:18 @author: 谭人杰
  /// 不可按照官方API逆行封装，导致root context指向问题
  /// 所以必须使MaterialApp作为element tree的root节点

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '互联网医院',
      debugShowCheckedModeBanner: false,
      navigatorKey: BaseConfig.navigatorKey,
      locale: const Locale("en", "US"), //设置这个可以使输入框文字垂直居中
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      localizationsDelegates: [],
      theme: ThemeData(
        fontFamily: "PingFang", // 统一指定应用的字体。
      ),
      home: SplashPage(),
      onGenerateRoute: CustomRouter.router.generator,
      builder: (BuildContext context, Widget child) => Material(
        child: FlutterEasyLoading(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: child,
          ),
        ),
      ),
      routes: RouteMap.routes,
    );
  }
}
