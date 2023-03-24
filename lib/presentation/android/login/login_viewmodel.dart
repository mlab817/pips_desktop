import 'dart:async';

import 'package:pips/presentation/base/baseviewmodel.dart';
import 'package:pips/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<String>();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _usernameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  Sink get inputIsAllInputValid => throw UnimplementedError();

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => throw UnimplementedError();

  @override
  login() async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  Stream<bool> get outputIsAllInputsValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsUserNameValid => throw UnimplementedError();
}

abstract class LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

// two sinks for streams
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
