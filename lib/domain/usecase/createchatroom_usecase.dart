import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../models/chat_room.dart';

class CreateChatRoomUseCase extends BaseUseCase<int, Result<ChatRoom>> {
  final Repository _repository;

  CreateChatRoomUseCase(this._repository);

  @override
  Future<Result<ChatRoom>> execute(int input) async {
    return await _repository.createChatRoom(input);
  }
}
