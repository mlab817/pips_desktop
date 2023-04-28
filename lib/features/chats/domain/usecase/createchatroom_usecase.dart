import 'package:dartz/dartz.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../models/chat_room/chat_room.dart';
import '../repository/chat_repository.dart';

class CreateChatRoomUseCase
    extends BaseUseCase<int, Either<Failure, ChatRoom>> {
  final ChatRepository _repository;

  CreateChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoom>> execute(int input) async {
    return await _repository.createChatRoom(input);
  }
}
