import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/upload_avatar/upload_avatar.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class UploadAvatarUseCase
    extends BaseUseCase<File, Either<Failure, UploadAvatarResponse>> {
  final Repository _repository;

  UploadAvatarUseCase(this._repository);

  @override
  Future<Either<Failure, UploadAvatarResponse>> execute(File input) async {
    return _repository.uploadAvatar(input);
  }
}
