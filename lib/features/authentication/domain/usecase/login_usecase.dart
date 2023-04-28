import 'package:dartz/dartz.dart';
import 'package:pips/features/authentication/data/repository/login_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/requests/login_request/login_request.dart';
import '../../data/responses/login_response/login_response.dart';

class LoginUseCase
    extends BaseUseCase<LoginRequest, Either<Failure, LoginResponse>> {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginResponse>> execute(LoginRequest input) async {
    return await _repository.login(input);
  }
}
