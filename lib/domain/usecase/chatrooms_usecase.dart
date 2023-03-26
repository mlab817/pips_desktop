import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/chat_rooms/chat_rooms.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class Void {}

class ChatRoomsUseCase
    extends BaseUseCase<Void, Either<Failure, ChatRoomsResponse>> {
  final Repository _repository;

  ChatRoomsUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoomsResponse>> execute(Void input) async {
    return await _repository.getChatRooms();
  }
}
