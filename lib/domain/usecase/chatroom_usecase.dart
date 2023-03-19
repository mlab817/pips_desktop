import 'package:pips/data/responses/chat_room/chat_room.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class ChatRoomUseCase extends BaseUseCase<int, Result<ChatRoomResponse>> {
  final Repository _repository;

  ChatRoomUseCase(this._repository);

  @override
  Future<Result<ChatRoomResponse>> execute(int input) async {
    return _repository.getChatRoomByUserId(input);
  }
}
