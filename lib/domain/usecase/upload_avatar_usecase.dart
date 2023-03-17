import 'dart:io';

import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class UploadAvatarUseCase
    extends BaseUseCase<File, Result<UploadAvatarResponse>> {
  final Repository _repository;

  UploadAvatarUseCase(this._repository);

  @override
  Future<Result<UploadAvatarResponse>> execute(File input) async {
    return _repository.uploadAvatar(input);
  }
}
