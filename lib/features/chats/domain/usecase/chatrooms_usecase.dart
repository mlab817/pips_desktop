import 'package:dartz/dartz.dart';
import 'package:pips/constants/constants.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../models/chat_rooms/chat_rooms.dart';
import '../repository/chat_repository.dart';

class ChatRoomsUseCase
    extends BaseUseCase<Void, Either<Failure, ChatRoomsResponse>> {
  final ChatRepository _repository;

  ChatRoomsUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoomsResponse>> execute(Void input) async {
    return await _repository.getChatRooms();
  }
}
