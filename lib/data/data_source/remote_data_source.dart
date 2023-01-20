import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/responses/login/login_response.dart';

import '../responses/forgot_password/forgot_password.dart';

// declare methods to get data from remote data source
abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest input);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest input);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  //
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest input) {
    return _appServiceClient.login(input.username, input.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest input) async {
    return _appServiceClient.forgotPassword(input.email);
  }

// methods to call _appServiceClient methods
}
