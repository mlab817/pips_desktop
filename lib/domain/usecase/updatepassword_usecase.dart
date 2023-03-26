import 'package:dartz/dartz.dart';
import 'package:pips/data/requests/update_password/update_password_request.dart';
import 'package:pips/data/responses/update_password/update_password_response.dart';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class UpdatePasswordUseCase extends BaseUseCase<UpdatePasswordRequest,
    Either<Failure, UpdatePasswordResponse>> {
  final Repository _repository;

  UpdatePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, UpdatePasswordResponse>> execute(
      UpdatePasswordRequest input) async {
    return _repository.updatePassword(input);
  }
}
