import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/update_profile/update_profile.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/requests/update_profile/update_profile_request.dart';

class UpdateProfileUseCase extends BaseUseCase<UpdateProfileRequest,
    Either<Failure, UpdateProfileResponse>> {
  final Repository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateProfileResponse>> execute(
      UpdateProfileRequest input) async {
    return _repository.updateProfile(input);
  }
}
