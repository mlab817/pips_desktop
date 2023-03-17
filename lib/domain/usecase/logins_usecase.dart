import 'package:pips/data/responses/logins/logins_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class LoginsUseCase extends BaseUseCase<void, Result<LoginsResponse>> {
  final Repository _repository;

  LoginsUseCase(this._repository);

  @override
  Future<Result<LoginsResponse>> execute(void input) async {
    // TODO: implement execute
    return _repository.getLogins();
  }
}