import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';
import 'package:pips/domain/usecase/chatrooms_usecase.dart';

import '../../data/network/failure.dart';
import '../../data/responses/options/options_response.dart';

class OptionsUseCase
    extends BaseUseCase<Void, Either<Failure, OptionsResponse>> {
  final Repository _repository;

  OptionsUseCase(this._repository);

  @override
  Future<Either<Failure, OptionsResponse>> execute(Void input) async {
    return await _repository.getOptions();
  }
}
