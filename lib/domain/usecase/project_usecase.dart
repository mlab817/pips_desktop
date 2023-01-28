import 'package:pips/data/responses/project/project_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

class ProjectUseCase extends BaseUseCase<String, Result<ProjectResponse>> {
  final Repository _repository;

  ProjectUseCase(this._repository);

  @override
  Future<Result<ProjectResponse>> execute(String input) async {
    return await _repository.getProject(input);
  }
}
