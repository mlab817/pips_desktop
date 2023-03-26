import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/data/responses/users/users_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class UsersUseCase
    extends BaseUseCase<GetUsersRequest, Either<Failure, UsersResponse>> {
  final Repository _repository;

  UsersUseCase(this._repository);

  @override
  Future<Either<Failure, UsersResponse>> execute(GetUsersRequest input) async {
    return _repository.getUsers(input);
  }
}
