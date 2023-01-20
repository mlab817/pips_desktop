// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _ForgotPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordRequestCopyWith<$Res> {
  factory $ForgotPasswordRequestCopyWith(ForgotPasswordRequest value,
          $Res Function(ForgotPasswordRequest) then) =
      _$ForgotPasswordRequestCopyWithImpl<$Res, ForgotPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<$Res,
        $Val extends ForgotPasswordRequest>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgotPasswordRequestCopyWith<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$$_ForgotPasswordRequestCopyWith(_$_ForgotPasswordRequest value,
          $Res Function(_$_ForgotPasswordRequest) then) =
      __$$_ForgotPasswordRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$_ForgotPasswordRequestCopyWithImpl<$Res>
    extends _$ForgotPasswordRequestCopyWithImpl<$Res, _$_ForgotPasswordRequest>
    implements _$$_ForgotPasswordRequestCopyWith<$Res> {
  __$$_ForgotPasswordRequestCopyWithImpl(_$_ForgotPasswordRequest _value,
      $Res Function(_$_ForgotPasswordRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$_ForgotPasswordRequest(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ForgotPasswordRequest extends _ForgotPasswordRequest {
  _$_ForgotPasswordRequest({required this.email}) : super._();

  factory _$_ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$$_ForgotPasswordRequestFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgotPasswordRequest &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgotPasswordRequestCopyWith<_$_ForgotPasswordRequest> get copyWith =>
      __$$_ForgotPasswordRequestCopyWithImpl<_$_ForgotPasswordRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForgotPasswordRequestToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordRequest extends ForgotPasswordRequest {
  factory _ForgotPasswordRequest({required final String email}) =
      _$_ForgotPasswordRequest;
  _ForgotPasswordRequest._() : super._();

  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$_ForgotPasswordRequest.fromJson;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_ForgotPasswordRequestCopyWith<_$_ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
