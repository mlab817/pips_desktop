import 'package:dartz/dartz.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/responses/messages_response/messages_response.dart';
import '../repository/chat_repository.dart';

class MessagesUseCase
    extends BaseUseCase<int, Either<Failure, MessagesResponse>> {
  final ChatRepository _repository;

  MessagesUseCase(this._repository);

  @override
  Future<Either<Failure, MessagesResponse>> execute(int input) async {
    return await _repository.listMessages(input);
  }
}
