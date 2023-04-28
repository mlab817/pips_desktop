import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/data/responses/all_users/all_users.dart';

import '../../../../common/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../constants/constants.dart';

class AllUsersUseCase
    extends BaseUseCase<Void, Either<Failure, AllUsersResponse>> {
  final Repository _repository;

  AllUsersUseCase(this._repository);

  @override
  Future<Either<Failure, AllUsersResponse>> execute(input) async {
    return _repository.getAllUsers();
  }
}
