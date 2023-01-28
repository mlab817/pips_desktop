import 'package:flutter/material.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/schemas/population.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:pips/domain/models/user.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:realm/realm.dart';

import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

// repository implementer returns result class
class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImplementer(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<LoginResponse>> login(LoginRequest input) async {
    try {
      final LoginResponse response = await _remoteDataSource.login(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input) async {
    try {
      final ForgotPasswordResponse response =
          await _remoteDataSource.forgotPassword(input);

      return Result(data: response);
    } catch (e) {
      return Result(error: e.toString());
    }
  }

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
  RealmResults<Population> getPopulation() {
    // parse the data to return list
    return _localDataSource.getPopulation();
  }

  @override
  RealmResults<PovertyIncidence> getPovertyIncidence() {
    return _localDataSource.getPovertyIncidence();
  }

  @override
  Future<Result<ProjectsResponse>> getProjects(GetProjectsRequest input) async {
    try {
      final ProjectsResponse response =
          await _remoteDataSource.getProjects(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
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
  Future<Result<OfficesResponse>> getOffices(GetOfficesRequest input) async {
    try {
      final OfficesResponse response =
          await _remoteDataSource.getOffices(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<OfficeResponse>> getOffice(String input) async {
    try {
      final OfficeResponse response = await _remoteDataSource.getOffice(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<Result<ProjectResponse>> getProject(String input) async {
    try {
      final ProjectResponse response =
          await _remoteDataSource.getProject(input);

      debugPrint("from rep imp: ${response.toString()}");

      return Result(data: response);
    } catch (e) {
      debugPrint("from rep imp: ${e.toString()}");
      return Result(error: e.toString());
    }
  }

  @override
  Future<void> setLoggedInUser(UserModel value) async {
    await _localDataSource.setLoggedInUser(value);
  }
}
