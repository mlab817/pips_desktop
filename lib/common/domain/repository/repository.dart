import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/data/responses/all_offices/all_offices_response.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:pips/features/authentication/domain/models/user/user.dart';
import 'package:pips/features/dashboard/pips_statuses/pips_statuses_response.dart';

import '../../../features/dashboard/data/network/responses/filter_project/filter_project_response.dart';
import '../../exceptions/failure.dart';

/// The repository is responsible for abstracting the data access logic and providing a consistent interface for the domain layer to interact with the data.
/// This separation of concerns allows for more flexibility in terms of how the data is stored and retrieved, and makes it easier to make changes to the
/// data layer without affecting the rest of the application. Additionally, repositories allow to implement caching strategies, which is important for
/// performance and offline capabilities.

// define methods
// Future<Response> login();
abstract class Repository {
  Future<Either<Failure, FilterProjectResponse>> filterProjects(
      FilterProjectRequest input);

  Future<Either<Failure, PipsStatusesResponse>> pipsStatuses();

  Future<String> getBearerToken();

  Future<Either<Failure, AllUsersResponse>> getAllUsers();

  Future<bool> getIsOnboardingScreenViewed();

  Future<void> setBearerToken(String value);

  Future<void> setIsUserLoggedIn();

  Future<void> setImageUrl(String value);

  Future<String?> getImageUrl();

  Future<bool> getIsUserLoggedIn();

  Future<void> setLoggedInUser(User value);

  Future<bool> getDatabaseLoaded();

  Future<void> setDatabaseLoaded();

  Future<void> resetDatabaseLoaded();

  Future<void> setIsOnboardingScreenViewed(bool value);

  Future<Either<Failure, AllOfficesResponse>> getAllOffices();

  Future<void> clear();

  Future<User?> getLoggedInUser();
}
