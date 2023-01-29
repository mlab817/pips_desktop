import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:retrofit/http.dart';

import '../responses/office_response/office_response.dart';
import '../responses/offices_response/offices_response.dart';
import '../responses/project/project_response.dart';
import '../responses/projects/projects_response.dart';
import '../responses/users/users_response.dart';

part 'app_api.g.dart';

// note: annotation requires retrofit_generator
@RestApi(baseUrl: Config.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

// add methods to retrieve data from api here
  @POST("/auth/login")
  Future<LoginResponse> login(
      @Field("username") String username, @Field("password") String password);

  @POST("/auth/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @GET("/projects")
  Future<ProjectsResponse> getProjects(
      @Query('per_page') int perPage, @Query('page') int page);

  @GET("/offices")
  Future<OfficesResponse> getOffices(
      @Query('per_page') int perPage, @Query('page') int page);

  @GET("/offices/{uuid}")
  Future<OfficeResponse> getOffice(@Path('uuid') String uuid);

  @GET("/projects/{uuid}")
  Future<ProjectResponse> getProject(@Path('uuid') String uuid);

  @GET("/users")
  Future<UsersResponse> getUsers(
      @Query('per_page') int perPage, @Query('page') int page);
}
