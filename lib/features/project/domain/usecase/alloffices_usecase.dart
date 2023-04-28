import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/repository/repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../constants/constants.dart';
import '../../../../data/responses/all_offices/all_offices_response.dart';

class AllOfficesUseCase
    extends BaseUseCase<Void, Either<Failure, AllOfficesResponse>> {
  final Repository _repository;

  AllOfficesUseCase(this._repository);

  @override
  Future<Either<Failure, AllOfficesResponse>> execute(Void input) async {
    return _repository.getAllOffices();
  }
}
