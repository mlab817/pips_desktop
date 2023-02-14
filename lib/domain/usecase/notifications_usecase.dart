import 'dart:core';
import 'package:pips/domain/repository/repository.dart';
import 'package:pips/domain/usecase/base_usecase.dart';

import '../../data/responses/notifications/notifications_response.dart';

class NotificationsUseCase
    extends BaseUseCase<void, Result<NotificationsResponse>> {
  final Repository _repository;

  NotificationsUseCase(this._repository);

  @override
  Future<Result<NotificationsResponse>> execute(void input) async {
    return await _repository.listNotifications();
  }
}
