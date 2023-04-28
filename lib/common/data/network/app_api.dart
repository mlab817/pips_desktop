import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/responses/all_users/all_users.dart';
import 'package:retrofit/http.dart';

import '../../../data/responses/all_offices/all_offices_response.dart';
import '../../../data/responses/office_response/office_response.dart';
import '../../../features/dashboard/data/network/requests/filter_project/filterproject_request.dart';
import '../../../features/dashboard/data/network/responses/filter_project/filterproject_response.dart';
import '../../../features/dashboard/pips_statuses/pips_statuses_response.dart';
import '../../../features/project/data/network/responses/offices_response/offices_response.dart';
import '../../../features/project/domain/models/presets.dart';

part 'app_api.g.dart';

// note: annotation requires retrofit_generator
@RestApi(baseUrl: Config.baseApiUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

// add methods to retrieve data from api here

  @GET("/offices")
  Future<OfficesResponse> getOffices(
      @Query('per_page') int perPage, @Query('page') int page);

  @GET("/offices/{uuid}")
  Future<OfficeResponse> getOffice(@Path('uuid') String uuid);

  @GET("/all-users")
  Future<AllUsersResponse> getAllUsers();

  @GET("/all-offices")
  Future<AllOfficesResponse> getAllOffices();

  @GET("/filter-projects")
  Future<FilterProjectResponse> filterProjects(
      @Queries() FilterProjectRequest input);

  @GET("/pips-statuses")
  Future<PipsStatusesResponse> pipsStatuses();

  @GET("/presets")
  Future<PresetsResponse> presets();
}
