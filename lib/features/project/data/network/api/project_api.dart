import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:retrofit/http.dart';

import '../../../../../data/requests/fullproject_request/fullproject_request.dart';
import '../../../../../data/requests/projects/get_projects_request.dart';
import '../../../../dashboard/data/network/responses/projects/projects_response.dart';
import '../../../domain/models/presets.dart';
import '../responses/createproject_response/createproject_response.dart';
import '../responses/options_response/options_response.dart';
import '../responses/project_response/project_response.dart';

part 'project_api.g.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class ProjectApi {
  factory ProjectApi(Dio dio, {String baseUrl}) = _ProjectApi;

  @GET("/projects")
  Future<ProjectsResponse> getProjects(@Queries() GetProjectsRequest input);

  @GET("/projects/{uuid}")
  Future<ProjectResponse> get(@Path('uuid') String uuid);

  @POST("/projects")
  Future<CreateProjectResponse> create(@Body() FullProjectRequest input);

  @PUT("/projects/{uuid}")
  Future<ProjectResponse> update(
      @Path('uuid') String uuid, @Body() FullProjectRequest input);

  @DELETE("/projects/{uuid}")
  Future<void> delete(@Path('uuid') String uuid);

  @GET("/all-options")
  Future<OptionsResponse> getOptions();

  @GET("/presets")
  Future<PresetsResponse> presets();
}
