import 'package:pips/data/responses/update_profile/update_profile.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/presentation/main/settings/screens/update_profile.dart';

class UpdateProfileUseCase
    extends BaseUseCase <UserProfile, Result<UpdateProfileResponse>> {
  final Repository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Result<UpdateProfileResponse>> execute(UserProfile input) async {
    return _repository.updateProfile(input);
  }
}