import 'package:pips/domain/models/message.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class CreateMessageUseCase
    extends BaseUseCase<CreateMessageUseCaseInput, Result<Message>> {
  final Repository _repository;

  CreateMessageUseCase(this._repository);

  @override
  Future<Result<Message>> execute(CreateMessageUseCaseInput input) async {
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
