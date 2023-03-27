import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/filter_project/filter_project_request.dart';
import 'package:pips/data/responses/filter_project/filter_project_response.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';

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