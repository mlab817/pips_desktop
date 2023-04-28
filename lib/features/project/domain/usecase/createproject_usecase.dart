import 'package:dartz/dartz.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../data/requests/fullproject_request/fullproject_request.dart';
import '../../data/network/responses/createproject_response/createproject_response.dart';
import '../repository/project_repository.dart';

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
