import 'package:pips/data/responses/update_profile/update_profile.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/requests/update_profile/update_profile_request.dart';

class UpdateProfileUseCase
    extends BaseUseCase<UpdateProfileRequest, Result<UpdateProfileResponse>> {
  final Repository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Result<UpdateProfileResponse>> execute(
      UpdateProfileRequest input) async {
    return _repository.updateProfile(input);
  }
}
