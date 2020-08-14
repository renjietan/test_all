import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:test_all/IsolatePage/IsolatePage.dart';
import 'package:test_all/bloc/index.dart';
import 'package:test_all/tab/homePage.dart';

void main() {
  runApp(MyApp());
  run1();
}

void run1() async {
  // 第3步：编写回调Port
  ReceivePort receivePort = new ReceivePort();
  await Isolate.spawn(echo, receivePort.sendPort);

  // 第6步：保存隔离线程回调Port
  var sendPort = await receivePort.first;
  // 第7步：发送消息
  var msg;
  // print('received $msg');

  msg = await sendReceive(sendPort, "foo");
  for (int i = 0; i < 10; i++) {}
  // msg = await sendReceive(sendPort, "bar");

  print('received $msg');
  // 第6步：保存隔离线程回调Port

  // msg = await sendReceive(sendPort, "bar");
}

// 第2步：定义隔离线程的入口点
echo(SendPort sendPort) async {
  // 第4步：编写回调Port
  var port = new ReceivePort();

  // 第5步：告诉主线程回调入口点
  sendPort.send(port.sendPort);

  // 第8步：循环接收消息
  await for (var msg in port) {
    // 数组 msg[0] 是数据
    var data = msg[0];
    // 数组 msg[1] 是发送方Port
    SendPort replyTo = msg[1];
    // 回传发送方 数据
    replyTo.send(data);

    // 如果数据时 bar 关闭当前回调
    if (data == "bar") port.close();
  }
}

/*
主线程 发送消息函数
数组 msg[0] 是数据
数组 msg[1] 是发送方Port
返回 隔离线程 Port
*/
Future sendReceive(SendPort port, msg) {
  ReceivePort response = new ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/bloc_page": (BuildContext context) => BlocPage(),
        "/isolate_page": (BuildContext context) => IsolatePage1(),
      },
    );
  }
}
