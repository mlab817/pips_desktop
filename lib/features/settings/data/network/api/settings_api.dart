import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:retrofit/http.dart';

import '../../requests/updatepassword_request/updatepassword_request.dart';
import '../../requests/updateprofile_request/updateprofile_request.dart';
import '../../responses/logins_response/logins_response.dart';
import '../../responses/updatepassword_response/update_password_response.dart';
import '../../responses/updateprofile_response/update_profile.dart';
import '../../responses/uploadavatar_response/upload_avatar.dart';

part 'settings_api.g.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class SettingsApi {
  factory SettingsApi(Dio dio, {String baseUrl}) = _SettingsApi;

  @POST("/upload-avatar")
  @MultiPart()
  Future<UploadAvatarResponse> uploadAvatar(@Part(name: "avatar") File file);

  @GET("/logins")
  Future<LoginsResponse> getLogins();

  @POST("/update-password")
  Future<UpdatePasswordResponse> updatePassword(
      @Body() UpdatePasswordRequest input);

  @POST("/update-profile")
  Future<UpdateProfileResponse> updateProfile(
      @Body() UpdateProfileRequest input);
}
