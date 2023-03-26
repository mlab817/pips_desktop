import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class ReadNotificationUseCase
    extends BaseUseCase<String, Either<Failure, StatusResponse>> {
  final Repository _repository;

  ReadNotificationUseCase(this._repository);

  @override
  Future<Either<Failure, StatusResponse>> execute(String input) async {
    return _repository.markNotificationAsRead(input);
  }
}
