import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';

import '../../../../common/domain/repository/repository.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/network/responses/filter_project/filter_project_response.dart';

class FilterProjectUseCase
    implements
        BaseUseCase<FilterProjectRequest,
            Either<Failure, FilterProjectResponse>> {
  final Repository _repository;

  FilterProjectUseCase(this._repository);

  @override
  Future<Either<Failure, FilterProjectResponse>> execute(
      FilterProjectRequest input) async {
    return _repository.filterProjects(input);
  }
}
