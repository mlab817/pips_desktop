import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/features/dashboard/pips_statuses/pips_statuses_response.dart';

import '../../../../common/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../constants/constants.dart';

class PipsStatusesUseCase
    extends BaseUseCase<Void, Either<Failure, PipsStatusesResponse>> {
  final Repository _repository;

  PipsStatusesUseCase(this._repository);

  @override
  Future<Either<Failure, PipsStatusesResponse>> execute(Void input) async {
    return _repository.pipsStatuses();
  }
}
