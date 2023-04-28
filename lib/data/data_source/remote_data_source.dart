import 'dart:io';

import 'package:pips/common/data/network/app_api.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/features/settings/data/responses/upload_avatar/upload_avatar.dart';

import '../../features/dashboard/data/network/responses/filter_project/filter_project_response.dart';
import '../../features/dashboard/pips_statuses/pips_statuses_response.dart';
import '../../features/settings/data/responses/update_password/update_password_response.dart';
import '../../features/settings/data/responses/update_profile/update_profile.dart';
import '../requests/filter_project/filter_project_request.dart';
import '../requests/update_profile/update_profile_request.dart';
import '../responses/all_offices/all_offices_response.dart';
import '../responses/all_users/all_users.dart';

// declare methods to get data from remote data source
abstract class RemoteDataSource {
  Future<UpdateProfileResponse> updateProfile(UpdateProfileRequest input);

  Future<UploadAvatarResponse> uploadAvatar(File input);

  Future<AllUsersResponse> getAllUsers();

  Future<UpdatePasswordResponse> updatePassword(UpdatePasswordRequest input);

  Future<AllOfficesResponse> getAllOffices();

  Future<FilterProjectResponse> filterProjects(FilterProjectRequest input);

  Future<PipsStatusesResponse> pipsStatuses();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequest input) async {
    return await _appServiceClient.updateProfile(input);
  }

  @override
  Future<UploadAvatarResponse> uploadAvatar(File input) async {
    return await _appServiceClient.uploadAvatar(input);
  }

  @override
  Future<AllUsersResponse> getAllUsers() async {
    return await _appServiceClient.getAllUsers();
  }

  @override
  Future<UpdatePasswordResponse> updatePassword(
      UpdatePasswordRequest input) async {
    return await _appServiceClient.updatePassword(input);
  }

  @override
  Future<AllOfficesResponse> getAllOffices() async {
    return await _appServiceClient.getAllOffices();
  }

  @override
  Future<FilterProjectResponse> filterProjects(
      FilterProjectRequest input) async {
    return await _appServiceClient.filterProjects(input);
  }

  @override
  Future<PipsStatusesResponse> pipsStatuses() async {
    return await _appServiceClient.pipsStatuses();
  }
}
