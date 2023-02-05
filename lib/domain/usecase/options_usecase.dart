import 'dart:core';

import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/responses/options/options_response.dart';

class OptionsUseCase extends BaseUseCase<void, Result<OptionsResponse>> {
  final Repository _repository;

  OptionsUseCase(this._repository);

  @override
  Future<Result<OptionsResponse>> execute(void input) async {
    return await _repository.getOptions();
  }
}
