import 'package:dartz/dartz.dart';
import 'package:pips/features/project/data/repository/project_repository.dart';
import 'package:pips/features/project/project/project_response.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';

class ProjectUseCase
    extends BaseUseCase<String, Either<Failure, ProjectResponse>> {
  final ProjectRepository _repository;

  ProjectUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectResponse>> execute(String input) async {
    return await _repository.get(input);
  }
}
