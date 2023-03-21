import 'package:pips/data/requests/update_password_request.dart';
import 'package:pips/data/responses/update_password/update_password_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class UpdatePasswordUseCase
    extends BaseUseCase<UpdatePasswordRequest, Result<UpdatePasswordResponse>> {
  final Repository _repository;

  UpdatePasswordUseCase(this._repository);

  @override
  Future<Result<UpdatePasswordResponse>> execute(
      UpdatePasswordRequest input) async {
    return _repository.updatePassword(input);
  }
}
