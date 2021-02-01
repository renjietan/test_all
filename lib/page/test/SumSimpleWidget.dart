import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/config/enumSum.dart';
import 'package:flutter_appclient/mobileUI/AppBar/simpleAppBar.dart';
import 'package:flutter_appclient/mobileUI/Avatar/simpleCircleAvatar.dart';
import 'package:flutter_appclient/mobileUI/Button/iconTextButton.dart';
import 'package:flutter_appclient/mobileUI/Button/simpleButton.dart';
import 'package:flutter_appclient/mobileUI/Counter/SimpleCounter.dart';
import 'package:flutter_appclient/mobileUI/Tab/custom_tab_indicator.dart';
import 'package:flutter_appclient/mobileUI/TestField/simpleField.dart';
import 'package:flutter_appclient/mobileUI/TestField/simpleTextFormField.dart';
import 'package:flutter_appclient/mobileUI/config/appbar.dart';
import 'package:flutter_appclient/mobileUI/icon/iconText.dart';
import 'package:flutter_appclient/mobileUI/list/listItem.dart';
import 'package:flutter_appclient/router/router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SumSimpleWidget extends StatefulWidget {
  SumSimpleWidget({Key key}) : super(key: key);

  @override
  _SumSimpleWidgetState createState() => _SumSimpleWidgetState();
}

class _SumSimpleWidgetState extends State<SumSimpleWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _tabs = [
    Tab(
      text: "tab1",
    ),
    Tab(
      text: "tab2",
    ),
    // Tab(
    //   text: "tab34444444",
    // ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: Text(
          "1",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          child: TabBar(
            controller: _tabController,
            tabs: _tabs,
            // indicatorWeight: 20,
            // indicatorSize: TabBarIndicatorSize.label,
            // indicatorPadding: EdgeInsets.symmetric(
            //   horizontal: 50,
            // ),
            indicator: SimpleTabIndicator(
                width: 30,
                insets: EdgeInsets.only(
                  bottom: 2,
                )),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight + 30),
        ),
      ),
      // appBar: AppBar(
      //   bottom: TabBar(
      //     controller: _tabController,
      //     tabs: _tabs,
      //     // indicatorWeight: 20,
      //     // indicatorSize: TabBarIndicatorSize.label,
      //     // indicatorPadding: EdgeInsets.symmetric(
      //     //   horizontal: 50,
      //     // ),
      //     indicator: SimpleTabIndicator(
      //         width: 30,
      //         insets: EdgeInsets.only(
      //           bottom: 2,
      //         )),
      //   ),
      // ),
      body: Container(
        color: BaseConfig.baseContainerBackground,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            SimpoleCountter(
              initvalue: 20,
              // background: Colors.red,
              callback: (value) {
                print("============$value===========");
              },
              // buttonType: SimpleCounterButtonType.rectangle,
            ),
            Row(
              children: [
                SimpleCirCleAvatar(
                  borderColor: Colors.red,
                  url:
                      "https://nimg.ws.126.net/?url=http%3A%2F%2Fautodealer.ws.126.net%2Fupload%2Fdealer%2Fimg%2F202011%2Fcef464723109f76cebfd2c9cf2b8f356.jpg&thumbnail=660x2147483647&quality=80&type=jpg",
                  radius: 15.0,
                ),
                Text("11111"),
              ],
            ),
            Row(
              children: [
                IconText(
                  "图标文字横向",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  ),
                ),
                IconText(
                  "图标文字竖向",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  direction: Axis.vertical,
                  icon: Icon(
                    Icons.home,
                    size: 20,
                  ),
                ),
              ],
            ),

            /// 任意界面返回应用首页。
            IconTextButton(
              icon: Icon(
                Icons.add_alarm,
                size: 20,
              ),
              label: Text(
                "图标按钮",
              ),
              callback: () {
                CustomRouter.gotoWidget(context, widget);
              },
            ),
            SizedBox(
              height: 12,
            ),
            SimpleButton(
              callback: () {},
            ),
            SizedBox(
              height: 12,
            ),
            SimpleField(
              borderRadius: 20,
              onSearch: (value) {
                print(value);
              },
              boxShadow: [
                BaseConfig.baseBoxShadow,
              ],
            ),
            SizedBox(
              height: 12,
            ),
            SimpleTextFormField(
              title: "1",
              // boxShadow: [
              //   BaseConfig.baseBoxShadow,
              // ],
            ),
            SizedBox(
              height: 12,
            ),
            ListItem(
              title: "12312",
              // horizontalPadding: 20,
              // background: Colors.red,
              // borderWidth: 20,
              // height: 100,
              // borderRadius: 20,
              // borderColor: Colors.black,
              callback: () {},
              // titleWidget: Icon(Icons.ac_unit_rounded),
              // iconWidget: Icon(Icons.ac_unit_rounded),
              contentWidget: Container(
                child: TextField(
                  style: TextStyle(fontSize: 5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Slidable(
              actionPane: SlidableStrechActionPane(), //滑出选项的面板 动画
              actionExtentRatio: 0.15,
              child: ListItem(title: "1"),
              fastThreshold: 2.0,
              actions: <Widget>[
                //左侧按钮列表
                IconSlideAction(
                  // caption: 'Archive',
                  color: Colors.blue,
                  icon: Icons.archive,
                  onTap: () {},
                ),
                IconSlideAction(
                  // caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  // iconWidget: Text("1"),
                  onTap: () {},
                ),
              ],
              secondaryActions: <Widget>[
                //右侧按钮列表
                IconSlideAction(
                  // caption: '更多',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: () {},
                ),
                IconSlideAction(
                  // caption: '删除',
                  color: Colors.red,
                  icon: Icons.delete,
                  closeOnTap: false,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
