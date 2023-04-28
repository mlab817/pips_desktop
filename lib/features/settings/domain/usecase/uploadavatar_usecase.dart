import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pips/features/settings/domain/repository/settings_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/responses/uploadavatar_response/upload_avatar.dart';

class UploadAvatarUseCase
    extends BaseUseCase<File, Either<Failure, UploadAvatarResponse>> {
  final SettingsRepository _repository;

  UploadAvatarUseCase(this._repository);

  @override
  Future<Either<Failure, UploadAvatarResponse>> execute(File input) async {
    return _repository.uploadAvatar(input);
  }
}
