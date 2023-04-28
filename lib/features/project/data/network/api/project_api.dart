import 'package:pips/app/config.dart';
import 'package:retrofit/http.dart';

import '../../../../../data/requests/project/full_project_request.dart';
import '../../../../../data/requests/projects/get_projects_request.dart';
import '../../../../dashboard/data/network/responses/projects/projects_response.dart';
import '../../../create_project/create_project_response.dart';
import '../../../domain/models/presets.dart';
import '../../../options/options_response.dart';
import '../../../project/project_response.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class ProjectApi {
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
