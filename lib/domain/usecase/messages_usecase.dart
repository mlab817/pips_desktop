import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/messages/messages_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class MessagesUseCase
    extends BaseUseCase<int, Either<Failure, MessagesResponse>> {
  final Repository _repository;

  MessagesUseCase(this._repository);

  @override
  Future<Either<Failure, MessagesResponse>> execute(int input) async {
    return await _repository.listMessages(input);
  }
}
