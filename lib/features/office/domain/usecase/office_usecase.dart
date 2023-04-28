import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/features/office/domain/repository/office_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';

class OfficeUseCase
    extends BaseUseCase<String, Either<Failure, OfficeResponse>> {
  final OfficeRepository _repository;

  OfficeUseCase(this._repository);

  @override
  Future<Either<Failure, OfficeResponse>> execute(String input) async {
    return await _repository.getOffice(input);
  }
}
