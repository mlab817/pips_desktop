import 'package:pips/common/data/network/app_api.dart';

import '../../features/dashboard/data/network/requests/filter_project/filterproject_request.dart';
import '../../features/dashboard/data/network/responses/filter_project/filterproject_response.dart';
import '../../features/dashboard/pips_statuses/pips_statuses_response.dart';
import '../responses/all_offices/all_offices_response.dart';
import '../responses/all_users/all_users.dart';

// declare methods to get data from remote data source
abstract class RemoteDataSource {
  Future<AllUsersResponse> getAllUsers();

  Future<AllOfficesResponse> getAllOffices();

  Future<FilterProjectResponse> filterProjects(FilterProjectRequest input);

  Future<PipsStatusesResponse> pipsStatuses();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AllUsersResponse> getAllUsers() async {
    return await _appServiceClient.getAllUsers();
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
