import 'package:dartz/dartz.dart';
import 'package:pips/features/project/domain/repository/project_repository.dart';

import '../../../../common/data/exceptions/failure.dart';
import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../constants/constants.dart';
import '../models/presets.dart';

/// define encoding template for new paps
class PresetsUseCase
    extends BaseUseCase<Void, Either<Failure, PresetsResponse>> {
  final ProjectRepository _repository;

  PresetsUseCase(this._repository);

  @override
  Future<Either<Failure, PresetsResponse>> execute(Void input) async {
    return await _repository.presets();
  }
}
