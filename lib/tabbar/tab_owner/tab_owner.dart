import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/mobileUI/TestField/simpleField.dart';
import 'package:flutter_appclient/mobileUI/icon/iconText.dart';
import 'package:flutter_appclient/mobileUI/list/listItem.dart';
import 'package:flutter_appclient/store/provider.dart';
import 'package:provider/provider.dart';

class TabOwner extends StatefulWidget {
  TabOwner({Key key}) : super(key: key);

  @override
  _TabOwnerState createState() => _TabOwnerState();
}

class _TabOwnerState extends State<TabOwner>
    with SingleTickerProviderStateMixin {
  ScrollController _controller = ScrollController();
  bool _isShow = false;
  List<Widget> _getGridBar() => List.generate(
        4,
        (index) => Expanded(
          child: Container(
            color: Colors.red,
            child: IconText(
              "首页",
              style: TextStyle(color: Colors.white, fontSize: 11),
              direction: Axis.vertical,
              icon: Icon(Icons.home),
              iconSize: 20,
            ),
            alignment: Alignment.center,
          ),
        ),
      ).toList();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isShow =
            _controller.offset + kToolbarHeight + ScreenUtil().setHeight(45) >=
                    160
                ? true
                : false;
        print(_isShow);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _controller,
      headerSliverBuilder: (context, bool) {
        return [
          SliverAppBar(
            expandedHeight: kToolbarHeight + 50,
            pinned: true,
            flexibleSpace: SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: (kToolbarHeight - 35) / 2,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SimpleField(
                            height: 35,
                          ),
                        ),
                      ]..addAll(
                          !_isShow
                              ? []
                              : [
                                  Icon(Icons.home),
                                  Icon(Icons.home),
                                  Icon(Icons.home),
                                  Icon(Icons.home),
                                ],
                        ),
                    ),
                    Expanded(
                      child: Row(
                        children: _isShow ? [] : _getGridBar(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          ListItem(
            title: "退出",
            callback: () {
              Provider.of<UserInfoStore>(context, listen: false).userInfo =
                  null;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (Route route) => false);
            },
          ),
        ],
      ),
    );
  }
}
