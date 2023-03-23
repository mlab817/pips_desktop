import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutputs {
  final StreamController _inputStreamController = BehaviorSubject();

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream get outputState => _inputStreamController.stream.map((state) => state);

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInput {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream get outputState;
}
