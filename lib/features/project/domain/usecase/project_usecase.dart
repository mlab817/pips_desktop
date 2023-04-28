import 'package:dartz/dartz.dart';
import 'package:pips/features/project/domain/repository/project_repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../data/network/responses/project_response/project_response.dart';

class ProjectUseCase
    extends BaseUseCase<String, Either<Failure, ProjectResponse>> {
  final ProjectRepository _repository;

  ProjectUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectResponse>> execute(String input) async {
    return await _repository.get(input);
  }
}
