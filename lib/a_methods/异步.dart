import 'dart:async';
import 'dart:isolate';

// 第1步：定义主线程
main() async {
  int i = 0;
  // 第3步：编写回调Port
  ReceivePort receivePort = new ReceivePort();
  await Isolate.spawn(echo, receivePort.sendPort);

  // 第6步：保存隔离线程回调Port
  var sendPort = await receivePort.first;

  // 第7步：发送消息
  var msg = await sendReceive(sendPort, "foo");
  // print('received $msg');
  msg = await sendReceive(sendPort, "bar");
  // while (i == 10) {
  //   msg = awai
  // }
  // print('received $msg');
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
    print(msg);
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
