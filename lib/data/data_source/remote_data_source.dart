import 'package:pips/data/network/app_api.dart';
import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';

import '../responses/forgot_password/forgot_password.dart';
import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';

// declare methods to get data from remote data source
abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest input);

  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest input);

  Future<ProjectsResponse> getProjects(GetProjectsRequest input);

  Future<OfficesResponse> getOffices(GetOfficesRequest input);

  Future<OfficeResponse> getOffice(String input);

  Future<ProjectResponse> getProject(String input);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  //
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest input) {
    return _appServiceClient.login(input.username, input.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest input) async {
    return _appServiceClient.forgotPassword(input.email);
  }

  @override
  Future<ProjectsResponse> getProjects(GetProjectsRequest input) async {
    return await _appServiceClient.getProjects(input.perPage, input.page);
  }

  @override
  Future<OfficesResponse> getOffices(GetOfficesRequest input) async {
    return await _appServiceClient.getOffices(input.perPage, input.page);
  }

  @override
  Future<OfficeResponse> getOffice(String input) async {
    return await _appServiceClient.getOffice(input);
  }

  @override
  Future<ProjectResponse> getProject(String input) async {
    return await _appServiceClient.getProject(input);
  }
}
