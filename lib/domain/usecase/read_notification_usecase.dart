import 'package:pips/data/responses/status/status_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class ReadNotificationUseCase
    extends BaseUseCase<String, Result<StatusResponse>> {
  final Repository _repository;

  ReadNotificationUseCase(this._repository);

  @override
  Future<Result<StatusResponse>> execute(String input) async {
    return _repository.markNotificationAsRead(input);
  }
}
