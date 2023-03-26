import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/projects/get_projects_request.dart';
import 'package:pips/data/responses/projects/projects_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class ProjectsUseCase
    extends BaseUseCase<GetProjectsRequest, Either<Failure, ProjectsResponse>> {
  final Repository _repository;

  ProjectsUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectsResponse>> execute(
      GetProjectsRequest input) async {
    return await _repository.getProjects(input);
  }
}
