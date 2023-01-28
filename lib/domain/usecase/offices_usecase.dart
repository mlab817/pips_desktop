import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class OfficesUseCase
    extends BaseUseCase<GetOfficesRequest, Result<OfficesResponse>> {
  final Repository _repository;

  OfficesUseCase(this._repository);

  @override
  Future<Result<OfficesResponse>> execute(GetOfficesRequest input) async {
    return await _repository.getOffices(input);
  }
}
