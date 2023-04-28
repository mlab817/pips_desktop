import 'package:dartz/dartz.dart';
import 'package:pips/common/data/exceptions/error_handler.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../data/requests/sign_up/sign_up_request.dart';
import '../network/auth_api.dart';
import '../responses/signup_response/signup_response.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpResponse>> signup(SignUpRequest input);
}

class SignUpRepositoryImplementer extends SignUpRepository {
  final AuthApi _client;

  SignUpRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, SignUpResponse>> signup(SignUpRequest input) async {
    try {
      final SignUpResponse response = await _client.signup(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
