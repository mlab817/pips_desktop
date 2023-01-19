import 'package:pips_desktop/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips_desktop/data/requests/login/login_request.dart';
import 'package:pips_desktop/data/responses/forgot_password/forgot_password.dart';
import 'package:pips_desktop/data/responses/login/login_response.dart';
import 'package:pips_desktop/domain/repository/repository.dart';
import 'package:pips_desktop/domain/usecase/base_usecase.dart';

import '../data_source/remote_data_source.dart';

// repository implementer returns result class
class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImplementer(this._remoteDataSource);

  @override
  Future<Result<LoginResponse>> login(LoginRequest input) async {
    try {
      final LoginResponse response = await _remoteDataSource.login(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input) async {
    try {
      final ForgotPasswordResponse response =
          await _remoteDataSource.forgotPassword(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
