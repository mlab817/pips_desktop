import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../common/exceptions/error_handler.dart';
import '../../../../common/exceptions/failure.dart';
import '../../../../data/requests/update_password/update_password_request.dart';
import '../../../../data/requests/update_profile/update_profile_request.dart';
import '../../data/network/api/settings_api.dart';
import '../../data/responses/logins_response/logins_response.dart';
import '../../data/responses/updatepassword_response/update_password_response.dart';
import '../../data/responses/updateprofile_response/update_profile.dart';
import '../../data/responses/uploadavatar_response/upload_avatar.dart';

abstract class SettingsRepository {
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      UpdatePasswordRequest input);

  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest input);

  Future<Either<Failure, UploadAvatarResponse>> uploadAvatar(File input);

  Future<Either<Failure, LoginsResponse>> getLogins(void input);
}

class SettingsRepositoryImplementer implements SettingsRepository {
  final SettingsApi _client;

  SettingsRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      UpdatePasswordRequest input) async {
    try {
      final UpdatePasswordResponse response =
      await _client.updatePassword(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler
          .handle(e)
          .failure);
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest input) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UploadAvatarResponse>> uploadAvatar(File input) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginsResponse>> getLogins(void input) async {
    try {
      final LoginsResponse response = await _client.getLogins();

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }
}
