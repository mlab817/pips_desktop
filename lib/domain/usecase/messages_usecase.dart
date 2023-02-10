import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class MessagesUseCase extends BaseUseCase<int, Result<MessagesResponse>> {
  final Repository _repository;

  MessagesUseCase(this._repository);

  @override
  Future<Result<MessagesResponse>> execute(int input) async {
    return await _repository.listMessages(input);
  }
}
