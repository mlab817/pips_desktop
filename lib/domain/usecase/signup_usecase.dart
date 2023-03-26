import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/sign_up/sign_up_request.dart';
import 'package:pips/data/responses/register/signup_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class SignUpUseCase
    extends BaseUseCase<SignUpRequest, Either<Failure, SignUpResponse>> {
  final Repository _repository;

  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, SignUpResponse>> execute(SignUpRequest input) async {
    return await _repository.register(input);
  }
}
