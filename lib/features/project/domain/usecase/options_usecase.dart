import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:pips/features/project/domain/repository/project_repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../constants/constants.dart';
import '../../data/network/responses/options_response/options_response.dart';

class OptionsUseCase
    extends BaseUseCase<Void, Either<Failure, OptionsResponse>> {
  final ProjectRepository _repository;

  OptionsUseCase(this._repository);

  @override
  Future<Either<Failure, OptionsResponse>> execute(Void input) async {
    return await _repository.getOptions();
  }
}
