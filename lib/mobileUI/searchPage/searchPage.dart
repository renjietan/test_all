/// @description: 使用方式如下
// Navigator.of(context).push(PageRouteBuilder(
//                       opaque: false,
//                       pageBuilder: (BuildContext context, _, __) {
//                         return SearchPage();
//                       },
//                       transitionsBuilder:
//                           (_, Animation<double> animation, __, Widget child) {
//                         return FadeTransition(
//                           alwaysIncludeSemantics: true,
//                           opacity: animation,
//                           child: child,
//                         );
//                       },
//                     ));
/// @params:
/// @fileName: searchPage.dart
/// @author: 谭人杰
/// @date: 2020-12-04 17:04:32
/// @后台人员:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/AppBar/searchAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchAppBar(
          inputHeight: kToolbarHeight - 25,
          onSearch: (v) {
            print(v);
          },
          action: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                child: Text("取消"),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(BaseConfig.basePadding),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  '最近搜索',
                  style: TextStyle(
                    fontSize: BaseConfig.baseFontSize + 4,
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: ScreenUtil().setWidth(3),
              ),
              Wrap(
                children: List.generate(7, (index) => null)
                    .map((key) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("提醒"),
                                  content: Text("点击后需跳转到结果页"),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(233, 233, 233, 0.9),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '蔬菜肉类',
                              style: TextStyle(
                                fontSize: BaseConfig.baseFontSize,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(13),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      '历史记录',
                      style: TextStyle(
                        fontSize: BaseConfig.baseFontSize + 4,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(Icons.delete_outline_outlined)
                  ],
                ),
              ),
              Divider(),
              Column(
                children: List.generate(20, (index) => null)
                    .asMap()
                    .keys
                    .map((index) => Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Colors.black12.withOpacity(0.07),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: ScreenUtil().setWidth(13),
                                color: Color(0xE6C8C8C8),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text("我是$index"))
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
