import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:retrofit/http.dart';

import '../../../../data/responses/status/status_response.dart';
import '../requests/notifications_request/notifications_request.dart';
import '../responses/notifications_response/notifications_response.dart';

part 'notification_api.g.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class NotificationApi {
  factory NotificationApi(Dio dio, {String baseUrl}) = _NotificationApi;

  @GET("/notifications")
  Future<NotificationsResponse> listNotifications(
      @Body() NotificationsRequest input);

  @POST("/mark-notification-as-read")
  Future<StatusResponse> markNotificationAsRead(@Field("id") String id);
}
