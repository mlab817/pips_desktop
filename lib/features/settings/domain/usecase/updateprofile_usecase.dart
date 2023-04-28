import 'package:dartz/dartz.dart';
import 'package:pips/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../../../data/requests/update_profile/update_profile_request.dart';
import '../../data/responses/updateprofile_response/update_profile.dart';

class UpdateProfileUseCase extends BaseUseCase<UpdateProfileRequest,
    Either<Failure, UpdateProfileResponse>> {
  final SettingsRepository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateProfileResponse>> execute(
      UpdateProfileRequest input) async {
    return _repository.updateProfile(input);
  }
}
