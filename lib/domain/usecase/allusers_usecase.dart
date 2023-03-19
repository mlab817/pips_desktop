import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import 'chatrooms_usecase.dart';

class AllUsersUseCase extends BaseUseCase<Void, Result<AllUsersResponse>> {
  final Repository _repository;

  AllUsersUseCase(this._repository);

  @override
  Future<Result<AllUsersResponse>> execute(input) async {
    return _repository.getAllUsers();
  }
}
