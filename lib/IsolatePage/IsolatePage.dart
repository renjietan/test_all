import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage1 extends StatefulWidget {
  IsolatePage1({Key key}) : super(key: key);

  @override
  _IsolatePage1State createState() => _IsolatePage1State();
}

class _IsolatePage1State extends State<IsolatePage1> {
  Future sendReceive(SendPort port, msg) {
    ReceivePort response = new ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线程跨页面"),
      ),
      body: Container(
        child: FlatButton(
            onPressed: () async {
              // ReceivePort receivePort = new ReceivePort();
              // var sendPort = await receivePort.first;

              // // 第7步：发送消息
              // var msg;
              // // print('received $msg');
              // for (int i = 0; i < 10; i++) {
              //   msg = await sendReceive(sendPort, "foo");
              // }
              // print(msg);
            },
            child: Text("线程跨页面发送消息")),
      ),
    );
  }
}
