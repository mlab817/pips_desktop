import 'package:dartz/dartz.dart';
import 'package:pips/common/data/exceptions/error_handler.dart';
import 'package:pips/features/authentication/data/network/auth_api.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../requests/forgotpassword_request/forgotpassword_request.dart';
import '../responses/forgotpassword_response/forgotpassword_response.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input);
}

class ForgotPasswordRepositoryImplementer extends ForgotPasswordRepository {
  final AuthApi _client;

  ForgotPasswordRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input) async {
    try {
      final ForgotPasswordResponse response =
          await _client.forgotPassword(input.email);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
