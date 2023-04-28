import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/usecase/base_usecase.dart';

import '../../../../common/exceptions/failure.dart';
import '../models/message/message.dart';
import '../repository/chat_repository.dart';

class CreateMessageUseCase
    extends BaseUseCase<CreateMessageUseCaseInput, Either<Failure, Message>> {
  final ChatRepository _repository;

  CreateMessageUseCase(this._repository);

  @override
  Future<Either<Failure, Message>> execute(
      CreateMessageUseCaseInput input) async {
    return await _repository.createMessage(input);
  }
}

class CreateMessageUseCaseInput {
  int id;

  String content;

  CreateMessageUseCaseInput({
    required this.id,
    required this.content,
  });
}
