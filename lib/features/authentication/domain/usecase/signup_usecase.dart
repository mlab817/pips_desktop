import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../data/repository/signup_repository.dart';
import '../../data/responses/signup_response/signup_response.dart';

class SignUpUseCase
    extends BaseUseCase<SignUpRequest, Either<Failure, SignUpResponse>> {
  final SignUpRepository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, SignUpResponse>> execute(SignUpRequest input) async {
    return await _repository.signup(input);
  }
}
