import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class Void {}

class ChatRoomsUseCase extends BaseUseCase<Void, Result<ChatRoomsResponse>> {
  final Repository _repository;

  ChatRoomsUseCase(this._repository);

  @override
  Future<Result<ChatRoomsResponse>> execute(Void input) async {
    return await _repository.getChatRooms();
  }
}
