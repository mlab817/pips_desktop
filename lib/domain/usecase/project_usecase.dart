import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class ProjectUseCase
    extends BaseUseCase<String, Either<Failure, ProjectResponse>> {
  final Repository _repository;

  ProjectUseCase(this._repository);

  @override
  Future<Either<Failure, ProjectResponse>> execute(String input) async {
    return await _repository.getProject(input);
  }
}
