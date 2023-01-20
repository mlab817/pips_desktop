import 'package:dio/dio.dart';
import 'package:pips/app/config.dart';
import 'package:pips/data/responses/forgot_password/forgot_password.dart';
import 'package:pips/data/responses/login/login_response.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

// note: annotation requires retrofit_generator
@RestApi(baseUrl: Config.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

// add methods to retrieve data from api here
  @POST("/auth/login")
  Future<LoginResponse> login(
      @Field("username") String username, @Field("password") String password);

  @POST("/auth/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
}
