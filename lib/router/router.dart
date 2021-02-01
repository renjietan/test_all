import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/enumSum.dart';
import 'package:flutter_appclient/mobileUI/Notify/SimpleNotify.dart';

import 'package:flutter_appclient/mobileUI/web_view_page.dart';
import 'package:flutter_appclient/router/async_animation.dart';

import 'switch_animation.dart';

///使用fluro进行路由管理
class CustomRouter {
  static FluroRouter router;
  static void init() {
    router = FluroRouter();
    configureRoutes(router);
  }

  ///路由配置
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("路由未找到");
      return null;
    });

    //网页加载
    router.define('/web', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(url, title);
    }));
  }

  static void goto(BuildContext context, String pageName) {
    Navigator.push(context, SlidePageRoute(routeName: pageName));
  }

  static void gotoWidget(BuildContext context, Widget widget) {
    Navigator.push(context, SlidePageRoute(widget: widget));
  }

  static Future asyncGotoWidget(BuildContext context, Widget widget) {
    return Navigator.push(
        context, AsyncSlidePageRouter(builder: (context) => widget));
  }

  static void openNotify(
    BuildContext context,
    String text, {
    SimpleNotifyType type = SimpleNotifyType.success,
    double minHeight = kToolbarHeight / 2,
    double paddingTop = kToolbarHeight,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        // 路由构造完成后路由是否会遮盖以前的路由。
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return SimpleNotify(
            text: "$text",
            type: type,
            minHeight: minHeight,
            paddingTop: paddingTop,
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
