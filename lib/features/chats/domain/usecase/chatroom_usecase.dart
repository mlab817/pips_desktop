import 'package:dartz/dartz.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/responses/chat_room_response/chatroom_response.dart';
import '../repository/chat_repository.dart';

class ChatRoomUseCase
    extends BaseUseCase<int, Either<Failure, ChatRoomResponse>> {
  final ChatRepository _repository;

  ChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoomResponse>> execute(int input) async {
    return _repository.getChatRoomByUserId(input);
  }
}
