import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pips/common/domain/repository/repository.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/all_offices/all_offices_response.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/features/authentication/domain/models/user/user.dart';
import 'package:pips/features/dashboard/data/network/responses/projects/projects_response.dart';
import 'package:pips/features/dashboard/pips_statuses/pips_statuses_response.dart';
import 'package:pips/features/settings/data/responses/logins/logins_response.dart';
import 'package:pips/features/settings/data/responses/update_profile/update_profile.dart';
import 'package:pips/features/settings/data/responses/upload_avatar/upload_avatar.dart';

import '../../common/exceptions/error_handler.dart';
import '../../common/exceptions/failure.dart';
import '../../features/dashboard/data/network/responses/filter_project/filter_project_response.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../requests/update_profile/update_profile_request.dart';

// repository implementer returns result class
class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource);

  @override
  Future<String> getBearerToken() async {
    return _localDataSource.getBearerToken();
  }

  @override
  Future<bool> getDatabaseLoaded() async {
    return _localDataSource.getDatabaseLoaded();
  }

  @override
  Future<void> setDatabaseLoaded() async {
    return _localDataSource.setDatabaseLoaded();
  }

  @override
  Future<void> resetDatabaseLoaded() {
    return _localDataSource.resetDatabaseLoaded();
  }

  @override
  Future<void> setBearerToken(String value) async {
    await _localDataSource.setBearerToken(value);
  }

  @override
  Future<void> setIsUserLoggedIn() async {
    await _localDataSource.setIsUserLoggedIn();
  }

  @override
  Future<bool> getIsUserLoggedIn() async {
    return _localDataSource.getIsUserLoggedIn();
  }

  @override
  Future<void> setLoggedInUser(User value) async {
    await _localDataSource.setLoggedInUser(value);
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest input) async {
    try {
      final UpdateProfileResponse response =
          await _remoteDataSource.updateProfile(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UploadAvatarResponse>> uploadAvatar(File input) async {
    try {
      final UploadAvatarResponse response =
          await _remoteDataSource.uploadAvatar(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<String?> getImageUrl() async {
    return _localDataSource.getImageUrl();
  }

  @override
  Future<void> setImageUrl(String value) async {
    return _localDataSource.setImageUrl(value);
  }

  @override
  Future<Either<Failure, AllUsersResponse>> getAllUsers() async {
    try {
      final AllUsersResponse response = await _remoteDataSource.getAllUsers();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<bool> getIsOnboardingScreenViewed() async {
    return _localDataSource.getIsOnboardingScreenViewed();
  }

  @override
  Future<void> setIsOnboardingScreenViewed(bool value) async {
    return _localDataSource.setIsOnboardingScreenViewed(value);
  }

  @override
  Future<void> clear() async {
    _localDataSource.clear();
  }

  @override
  Future<User?> getLoggedInUser() async {
    return _localDataSource.getLoggedInUser();
  }

  @override
  Future<Either<Failure, FilterProjectResponse>> filterProjects(
      FilterProjectRequest input) async {
    try {
      final FilterProjectResponse response =
          await _remoteDataSource.filterProjects(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, PipsStatusesResponse>> pipsStatuses() async {
    try {
      final PipsStatusesResponse response =
          await _remoteDataSource.pipsStatuses();

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, AllOfficesResponse>> getAllOffices() {
    // TODO: implement getAllOffices
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LoginsResponse>> getLogins() {
    // TODO: implement getLogins
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProjectsResponse>> getProjects(
      GetProjectsRequest input) {
    // TODO: implement getProjects
    throw UnimplementedError();
  }
}
