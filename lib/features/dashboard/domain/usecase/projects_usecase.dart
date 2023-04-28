import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/features/dashboard/data/network/responses/projects/projects_response.dart';
import 'package:pips/features/project/domain/repository/project_repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';

class ProjectsUseCase
    extends BaseUseCase<GetProjectsRequest, Either<Failure, ProjectsResponse>> {
  final ProjectRepository _repository;

  ProjectsUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectsResponse>> execute(
      GetProjectsRequest input) async {
    return await _repository.getAll(input);
  }
}
