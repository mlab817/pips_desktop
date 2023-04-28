import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/project/full_project_request.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../create_project/create_project_response.dart';
import '../../data/repository/project_repository.dart';

class CreateProjectUseCase extends BaseUseCase<FullProjectRequest,
    Either<Failure, CreateProjectResponse>> {
  final ProjectRepository _repository;

  CreateProjectUseCase(this._repository);

  @override
  Future<Either<Failure, CreateProjectResponse>> execute(
      FullProjectRequest input) async {
    return await _repository.create(input);
  }
}
