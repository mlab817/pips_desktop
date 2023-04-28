import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../app/config.dart';
import '../../../../data/requests/sign_up/sign_up_request.dart';
import '../requests/login_request/login_request.dart';
import '../responses/forgotpassword_response/forgotpassword_response.dart';
import '../responses/login_response/login_response.dart';
import '../responses/signup_response/signup_response.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Config.baseApiUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest input);

  @POST("/forgot-password")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/signup")
  Future<SignUpResponse> signup(@Body() SignUpRequest formData);
}
