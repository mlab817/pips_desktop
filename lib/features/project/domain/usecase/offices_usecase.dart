import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../office/domain/repository/office_repository.dart';
import '../../data/network/responses/offices_response/offices_response.dart';

class OfficesUseCase
    extends BaseUseCase<GetOfficesRequest, Either<Failure, OfficesResponse>> {
  final OfficeRepository _repository;

  OfficesUseCase(this._repository);

  @override
  Future<Either<Failure, OfficesResponse>> execute(
      GetOfficesRequest input) async {
    return await _repository.getOffices(input);
  }
}
