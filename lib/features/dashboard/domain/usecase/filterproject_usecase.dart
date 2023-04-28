import 'package:dartz/dartz.dart';
import 'package:pips/features/dashboard/data/network/requests/filter_project/filterproject_request.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/repository/repository.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../data/network/responses/filter_project/filterproject_response.dart';

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
