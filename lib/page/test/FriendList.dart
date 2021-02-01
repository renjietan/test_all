import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/AppBar/searchAppBar.dart';
import 'package:flutter_appclient/mobileUI/Avatar/simpleCircleAvatar.dart';

import 'package:sticky_headers/sticky_headers.dart';

class AtUserProvider {
  List<Map> data = [
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "爸爸",
      "desc": "我是描述……",
      "groupCode": "baba"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "妈妈",
      "desc": "",
      "groupCode": "mama"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "马勒勒",
      "desc": "虎牙平台主播……",
      "groupCode": "malele"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "马冬梅",
      "desc": "马什么梅？？？？夏洛特烦恼",
      "groupCode": "madongmei"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "阿坝",
      "desc": "描述",
      "groupCode": "abei"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "北京",
      "desc": "",
      "groupCode": "beijing"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "韩佳佳",
      "desc": "",
      "groupCode": "hanjiajia"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "北方的神",
      "desc": "我是雷神托尔，北方的神",
      "groupCode": "beifangdeshen"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "韩信",
      "desc": "",
      "groupCode": "hanxin"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "弟弟",
      "desc": "你就是个弟弟",
      "groupCode": "didi"
    },
    {
      "avatarUrl": "assets/images/banner1.jpg",
      "userName": "弟媳啊",
      "desc": "描述",
      "groupCode": "dixi"
    }
  ];
  List pro = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
}

class FriendList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
        appBar: SearchAppBar(), body: genUserList(context, controller));
  }
}

genUserList(context, controller) {
  AtUserProvider provider = AtUserProvider();
  var data = provider.data;
  return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return StickyHeader(
          header: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width,
            height: 49,
            decoration: BoxDecoration(color: BaseConfig.theme),
            child: Text(
              provider.pro[index],
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          content: genContentList(data, context, controller),
        );
      });
}

genContentList(data, BuildContext context, controller) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 130 * rpx,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10 * rpx),
                child: SimpleCirCleAvatar(
                  url: "assets/images/banner1.jpg",
                  radius: 80 * rpx / 2,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20 * rpx),
                width: 420 * rpx,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(data[index]['userName'],
                          style: TextStyle(
                            fontSize: 32 * rpx,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    data[index]['desc'].toString().length == 0
                        ? Text('')
                        : Container(
                            child: Text(
                              data[index]['desc'],
                              style: TextStyle(
                                  color: BaseConfig.baseDisabledTextColor,
                                  fontSize: 32 * rpx),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(""),
              ),
              Container(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: BaseConfig.baseDisabledColor,
                ),
              ),
            ],
          ),
        );
      });
}
