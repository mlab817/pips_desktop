import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/pips_statuses/pips_statuses_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';

import '../../data/network/failure.dart';

class PipsStatusesUseCase
    extends BaseUseCase<Void, Either<Failure, PipsStatusesResponse>> {
  final Repository _repository;

  PipsStatusesUseCase(this._repository);

  @override
  Future<Either<Failure, PipsStatusesResponse>> execute(Void input) async {
    return _repository.pipsStatuses();
  }

}