import 'package:pips_desktop/data/requests/forgot_password/forgot_password_request.dart';
import 'package:pips_desktop/data/requests/login/login_request.dart';
import 'package:pips_desktop/data/responses/login/login_response.dart';

import '../../data/responses/forgot_password/forgot_password.dart';
import '../usecase/base_usecase.dart';

/// The repository is responsible for abstracting the data access logic and providing a consistent interface for the domain layer to interact with the data.
/// This separation of concerns allows for more flexibility in terms of how the data is stored and retrieved, and makes it easier to make changes to the
/// data layer without affecting the rest of the application. Additionally, repositories allow to implement caching strategies, which is important for
/// performance and offline capabilities.

// define methods
// Future<Response> login();
abstract class Repository {
  Future<Result<LoginResponse>> login(LoginRequest input);

  Future<Result<ForgotPasswordResponse>> forgotPassword(
      ForgotPasswordRequest input);
}
