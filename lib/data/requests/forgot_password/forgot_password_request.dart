import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_request.freezed.dart';
part 'forgot_password_request.g.dart';

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  factory ForgotPasswordRequest({
    required String email,
  }) = _ForgotPasswordRequest;

  ForgotPasswordRequest._();

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}
