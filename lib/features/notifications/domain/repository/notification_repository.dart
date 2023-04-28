import 'package:dartz/dartz.dart';
import 'package:pips/features/notifications/data/api/notification_api.dart';

import '../../../../common/data/exceptions/error_handler.dart';
import '../../../../common/data/exceptions/failure.dart';
import '../../../../data/responses/status/status_response.dart';
import '../../data/requests/notifications_request/notifications_request.dart';
import '../../data/responses/notifications_response/notifications_response.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationsResponse>> listNotifications(
      NotificationsRequest input);

  Future<Either<Failure, StatusResponse>> markNotificationAsRead(String input);
}

class NotificationRepositoryImplementer implements NotificationRepository {
  final NotificationApi _client;

  NotificationRepositoryImplementer(this._client);

  @override
  Future<Either<Failure, NotificationsResponse>> listNotifications(
      NotificationsRequest input) async {
    try {
      final NotificationsResponse response =
          await _client.listNotifications(input);

      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> markNotificationAsRead(
      String input) async {
    try {
      final StatusResponse response =
          await _client.markNotificationAsRead(input);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
