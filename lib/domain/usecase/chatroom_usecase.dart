import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/chat_room/chat_room.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class ChatRoomUseCase
    extends BaseUseCase<int, Either<Failure, ChatRoomResponse>> {
  final Repository _repository;

  ChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoomResponse>> execute(int input) async {
    return _repository.getChatRoomByUserId(input);
  }
}
