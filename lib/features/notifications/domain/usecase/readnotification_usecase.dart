import 'package:dartz/dartz.dart';
import 'package:pips/data/responses/status/status_response.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../repository/notification_repository.dart';

class ReadNotificationUseCase
    extends BaseUseCase<String, Either<Failure, StatusResponse>> {
  final NotificationRepository _repository;

  ReadNotificationUseCase(this._repository);

  @override
  Future<Either<Failure, StatusResponse>> execute(String input) async {
    return _repository.markNotificationAsRead(input);
  }
}
