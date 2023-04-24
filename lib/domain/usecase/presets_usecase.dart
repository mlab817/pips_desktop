import 'package:dartz/dartz.dart';
import 'package:pips/data/network/failure.dart';
import 'package:pips/data/responses/presets/presets.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import 'chatrooms_usecase.dart';

class PresetsUseCase
    extends BaseUseCase<Void, Either<Failure, PresetsResponse>> {
  final Repository _repository;

  PresetsUseCase(this._repository);

  @override
  Future<Either<Failure, PresetsResponse>> execute(Void input) async {
    return _repository.presets();
  }
}