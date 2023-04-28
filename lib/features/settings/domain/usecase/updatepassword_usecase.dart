import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/responses/updatepassword_response/update_password_response.dart';

class UpdatePasswordUseCase extends BaseUseCase<UpdatePasswordRequest,
    Either<Failure, UpdatePasswordResponse>> {
  final SettingsRepository _repository;

  UpdatePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, UpdatePasswordResponse>> execute(
      UpdatePasswordRequest input) async {
    return _repository.updatePassword(input);
  }
}
