import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class ProjectsUseCase
    extends BaseUseCase<GetProjectsRequest, Result<ProjectsResponse>> {
  final Repository _repository;

  ProjectsUseCase(this._repository);

  @override
  Future<Result<ProjectsResponse>> execute(GetProjectsRequest input) async {
    return await _repository.getProjects(input);
  }
}
