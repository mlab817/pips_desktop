import 'package:dartz/dartz.dart';
import 'package:pips/domain/models/message.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class CreateMessageUseCase
    extends BaseUseCase<CreateMessageUseCaseInput, Either<Failure, Message>> {
  final Repository _repository;

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
