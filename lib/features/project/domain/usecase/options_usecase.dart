import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:pips/features/project/data/repository/project_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../../../constants/constants.dart';
import '../../options/options_response.dart';

class OptionsUseCase
    extends BaseUseCase<Void, Either<Failure, OptionsResponse>> {
  final ProjectRepository _repository;

  OptionsUseCase(this._repository);

  @override
  Future<Either<Failure, OptionsResponse>> execute(Void input) async {
    return await _repository.getOptions();
  }
}
