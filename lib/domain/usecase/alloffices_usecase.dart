import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';

import '../../data/responses/all_offices/all_offices_response.dart';

class AllOfficesUseCase extends BaseUseCase<Void, Result<AllOfficesResponse>> {
  final Repository _repository;

  AllOfficesUseCase(this._repository);

  @override
  Future<Result<AllOfficesResponse>> execute(Void input) async {
    return _repository.getAllOffices();
  }
}
