import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appclient/mobileUI/Notify/SimpleNotify.dart';
import 'package:flutter_appclient/mobileUI/call/callpage.dart';
import 'package:flutter_appclient/mobileUI/searchPage/searchPage.dart';
import 'package:flutter_appclient/page/blue/blue.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/config/enumSum.dart';
import 'package:flutter_appclient/mobileUI/Button/simpleButton.dart';

import 'package:flutter_appclient/page/test/FriendList.dart';
import 'package:flutter_appclient/page/test/SumSimpleWidget.dart';
import 'package:flutter_appclient/page/test/test.dart';
import 'package:flutter_appclient/page/test/stickyPage.dart';
import 'package:flutter_appclient/router/router.dart';
// import 'package:permission_handler/permission_handler.dart';

const double boxSize = 40.0;

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  var _channel;
  @override
  void initState() {
    _channel = MethodChannel("com.example.flutter_app_client");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseConfig.baseContainerBackground,
      child: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {},
        onLoad: () async {},
        slivers: <Widget>[
          //=====轮播图=====//
          SliverToBoxAdapter(
            child: getBannerWidget(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "snackbar",
                  minWidth: 50,
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            Text('成功')
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "通讯录列表",
                  minWidth: 40,
                  callback: () {
                    CustomRouter.gotoWidget(context, FriendList());
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "小部件",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    CustomRouter.gotoWidget(context, SumSimpleWidget());
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "吸顶",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    CustomRouter.gotoWidget(context, StickyPage());
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "测试",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    // CustomRouter.gotoWidget(context, Qt());
                    CustomRouter.asyncGotoWidget(context, TestPage())
                        .then((value) {
                      print("1");
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "搜索页",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) {
                        return SearchPage();
                      },
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return FadeTransition(
                          alwaysIncludeSemantics: true,
                          opacity: animation,
                          child: child,
                        );
                      },
                    ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "提示框",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () {
                    CustomRouter.openNotify(
                      context,
                      "哈哈",
                      type: SimpleNotifyType.info,
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "聊天",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () async {
                    // await PermissionHandler().requestPermissions(
                    //   [PermissionGroup.camera, PermissionGroup.microphone],
                    // );
                    // Map<Permission, PermissionStatus> statuses = await [
                    //   Permission.camera,
                    //   Permission.microphone,
                    // ].request();
                    // bool cameraPermission =
                    //     statuses.containsKey(Permission.camera);
                    // bool microphonePermission =
                    //     statuses.containsKey(Permission.microphone);
                    // if (cameraPermission && microphonePermission) {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) => CallPage(
                    //         channelName: "111",
                    //       ),
                    //     ),
                    //   );
                    // } else {
                    //   CustomRouter.openNotify(context, "授权失败",
                    //       type: SimpleNotifyType.error);
                    // }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "跨apk调用activity",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () async {
                    var result = await _channel.invokeMethod(
                        'sendData', {'name': 'laomeng', 'age': 18});
                    print(result);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SimpleButton(
                  text: "蓝牙",
                  simpleButtonType: SimpleButtonType.ellipse,
                  callback: () async {
                    CustomRouter.gotoWidget(
                      context,
                      Blue(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<String> urls = [
    "assets/images/banner1.jpg",
    "assets/images/banner1.jpg",
    "assets/images/banner1.jpg",
    "assets/images/banner1.jpg",
    "assets/images/banner1.jpg",
    "assets/images/banner1.jpg",
  ];

  Widget getBannerWidget() {
    return SizedBox(
      height: ScreenUtil().setHeight(150),
      child: Swiper(
        autoplay: true,
        duration: 2000,
        autoplayDelay: 5000,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                urls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onTap: (value) {},
        itemCount: urls.length,
        pagination: SwiperPagination(),
      ),
    );
  }
}
