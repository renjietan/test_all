import 'package:flutter/material.dart';
import 'package:test_all/bloc/components/HandlerFunction.dart';

class CounterProvider extends InheritedWidget {
  CounterProvider({Key key, this.child, this.handleFunction})
      : super(key: key, child: child);

  final Widget child;
  final HandleFunction handleFunction;
  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return true;
  }
}
