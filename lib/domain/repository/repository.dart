import 'package:pips/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips/data/requests/login/login_request.dart';
import 'package:pips/data/requests/offices/get_offices_request.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:pips/data/responses/office_response/office_response.dart';
import 'package:pips/data/responses/offices_response/offices_response.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/data/schemas/population.dart';
import 'package:pips/data/schemas/poverty_incidence.dart';
import 'package:realm/realm.dart';

import '../../data/responses/forgot_password/forgot_password.dart';
import '../usecase/base_usecase.dart';

/// The repository is responsible for abstracting the data access logic and providing a consistent interface for the domain layer to interact with the data.
/// This separation of concerns allows for more flexibility in terms of how the data is stored and retrieved, and makes it easier to make changes to the
/// data layer without affecting the rest of the application. Additionally, repositories allow to implement caching strategies, which is important for
/// performance and offline capabilities.

// define methods
// Future<Response> login();
abstract class Repository {
  Future<Result<LoginResponse>> login(LoginRequest input);

  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input);

  Future<Result<ProjectsResponse>> getProjects(GetProjectsRequest input);

  Future<Result<OfficesResponse>> getOffices(GetOfficesRequest input);

  Future<Result<OfficeResponse>> getOffice(String input); // uuid

  Future<Result<ProjectResponse>> getProject(String input);

  Future<String> getBearerToken();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<bool> getIsUserLoggedIn();

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  RealmResults<Population> getPopulation();

  RealmResults<PovertyIncidence> getPovertyIncidence();
}
