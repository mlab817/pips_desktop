import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class OfficeUseCase extends BaseUseCase<String, Result<OfficeResponse>> {
  final Repository _repository;

  OfficeUseCase(this._repository);

  @override
  Future<Result<OfficeResponse>> execute(String input) async {
    return await _repository.getOffice(input);
  }
}
