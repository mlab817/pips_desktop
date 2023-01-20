import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginRequest, Result<LoginResponse>> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Result<LoginResponse>> execute(LoginRequest input) async {
    return await _repository.login(input);
  }
}
