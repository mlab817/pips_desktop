import 'package:dartz/dartz.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../models/chat_room.dart';

class CreateChatRoomUseCase
    extends BaseUseCase<int, Either<Failure, ChatRoom>> {
  final Repository _repository;

  CreateChatRoomUseCase(this._repository);

  @override
  Future<Either<Failure, ChatRoom>> execute(int input) async {
    return await _repository.createChatRoom(input);
  }
}
