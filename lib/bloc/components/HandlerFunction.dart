import 'dart:async';

class HandleFunction {
  final _actionController = StreamController<int>();
  StreamSink<int> get counter => _actionController.sink;
  HandleFunction() {
    _actionController.stream.listen((event) {
      print(_actionController.sink);
    });
  }
}
