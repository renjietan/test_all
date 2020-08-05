import 'package:flutter/material.dart';
import 'package:test_all/bloc/components/CounterProvider.dart';
import 'package:test_all/bloc/components/HandlerFunction.dart';

class CounterActionButton extends StatelessWidget {
  const CounterActionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HandleFunction _count = CounterProvider.of(context).handleFunction;
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          print("1");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
