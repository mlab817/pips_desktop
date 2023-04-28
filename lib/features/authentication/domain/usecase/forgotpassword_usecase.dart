import 'package:dartz/dartz.dart';
import 'package:pips/features/authentication/data/repository/forgotpassword_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/requests/forgotpassword_request/forgotpassword_request.dart';
import '../../data/responses/forgotpassword_response/forgotpassword_response.dart';

class ForgotPasswordUseCase extends BaseUseCase<ForgotPasswordRequest,
    Either<Failure, ForgotPasswordResponse>> {
  final ForgotPasswordRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> execute(
      ForgotPasswordRequest input) async {
    return _repository.forgotPassword(input);
  }
}
