import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_all/bloc/components/CounterActionButton.dart';
import 'package:test_all/bloc/components/CounterHome.dart';
import 'package:test_all/bloc/components/CounterProvider.dart';
import 'package:test_all/bloc/components/HandlerFunction.dart';

//业务逻辑组件，  将业务组件单独分离到Bloc中去
class BlocPage extends StatefulWidget {
  BlocPage({Key key}) : super(key: key);

  @override
  _BlocPageState createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      handleFunction: HandleFunction(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("BLOC使用例子"),
          ),
          body: Container(
            child: CounterHome(),
          ),
          floatingActionButton: CounterActionButton()),
    );
  }
}


