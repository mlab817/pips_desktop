import 'dart:core';

import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/requests/notifications/notifications_request.dart';
import '../../data/responses/notifications/notifications_response.dart';

class NotificationsUseCase
    extends BaseUseCase<NotificationsRequest, Result<NotificationsResponse>> {
  final Repository _repository;

  NotificationsUseCase(this._repository);

  @override
  Future<Result<NotificationsResponse>> execute(
      NotificationsRequest input) async {
    return await _repository.listNotifications(input);
  }
}
