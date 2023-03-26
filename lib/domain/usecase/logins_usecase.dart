import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/logins/logins_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class LoginsUseCase extends BaseUseCase<void, Either<Failure, LoginsResponse>> {
  final Repository _repository;

  LoginsUseCase(this._repository);

  @override
  Future<Either<Failure, LoginsResponse>> execute(void input) async {
    return _repository.getLogins();
  }
}
