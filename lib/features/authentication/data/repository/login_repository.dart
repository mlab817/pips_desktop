import 'package:dartz/dartz.dart';

import '../../../../common/exceptions/error_handler.dart';
import '../../../../common/exceptions/failure.dart';
import '../network/auth_api.dart';
import '../requests/login_request/login_request.dart';
import '../responses/login_response/login_response.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest input);
}

class LoginRepositoryImplementer extends LoginRepository {
  final AuthApi _client;

  LoginRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest input) async {
    try {
      final LoginResponse response = await _client.login(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
