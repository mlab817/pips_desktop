import 'package:dartz/dartz.dart';
import 'package:pips/features/project/data/repository/project_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
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
