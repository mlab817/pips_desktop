import 'package:dartz/dartz.dart';
import 'package:pips/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../data/responses/logins_response/logins_response.dart';

class LoginsUseCase extends BaseUseCase<void, Either<Failure, LoginsResponse>> {
  final SettingsRepository _repository;

  LoginsUseCase(this._repository);

  @override
  Future<Either<Failure, LoginsResponse>> execute(void input) async {
    return _repository.getLogins();
  }
}
