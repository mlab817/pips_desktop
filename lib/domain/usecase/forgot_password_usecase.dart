import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class ForgotPasswordUseCase extends BaseUseCase<ForgotPasswordRequest,
    Either<Failure, ForgotPasswordResponse>> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> execute(
      ForgotPasswordRequest input) async {
    return _repository.forgotPassword(input);
  }
}
