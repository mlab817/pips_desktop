import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/usecase/base_usecase.dart';
import 'package:pips/data/requests/users/get_users_request.dart';
import 'package:pips/features/chats/domain/repository/chat_repository.dart';

import '../../../../common/exceptions/failure.dart';
import '../../data/responses/users_response/users_response.dart';

/// Fetch a list of all users to show in the chat bottom sheet
///
class UsersUseCase
    extends BaseUseCase<GetUsersRequest, Either<Failure, UsersResponse>> {
  final ChatRepository _repository;

  UsersUseCase(this._repository);

  @override
  Future<Either<Failure, UsersResponse>> execute(GetUsersRequest input) async {
    return _repository.getUsers(input);
  }
}
