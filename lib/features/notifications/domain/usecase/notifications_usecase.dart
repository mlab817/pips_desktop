import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:pips/features/notifications/domain/repository/notification_repository.dart';

import '../../../../common/domain/usecase/base_usecase.dart';
import '../../../../common/exceptions/failure.dart';
import '../../data/requests/notifications_request/notifications_request.dart';
import '../../data/responses/notifications_response/notifications_response.dart';

class NotificationsUseCase extends BaseUseCase<NotificationsRequest,
    Either<Failure, NotificationsResponse>> {
  final NotificationRepository _repository;

  NotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, NotificationsResponse>> execute(
      NotificationsRequest input) async {
    return await _repository.listNotifications(input);
  }
}
