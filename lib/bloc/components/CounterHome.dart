import 'package:flutter/material.dart';
import 'package:test_all/bloc/components/CounterProvider.dart';
import 'package:test_all/bloc/components/HandlerFunction.dart';

class CounterHome extends StatelessWidget {
  const CounterHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HandleFunction _counterBloc = CounterProvider.of(context).handleFunction;
    return ActionChip(
        label: Text("1111"),
        onPressed: () {
          _counterBloc.counter.add(1);
        });
  }
}
