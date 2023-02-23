// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return _SignUpRequest.fromJson(json);
}

/// @nodoc
mixin _$SignUpRequest {
  @JsonKey(name: "office_id")
  int? get officeId => throw _privateConstructorUsedError;
  @JsonKey(name: "first_name")
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: "last_name")
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: "position")
  String get position => throw _privateConstructorUsedError;
  @JsonKey(name: "email")
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: "contact_number")
  String get contactNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "endorsement")
  String get endorsementPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpRequestCopyWith<SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpRequestCopyWith<$Res> {
  factory $SignUpRequestCopyWith(
          SignUpRequest value, $Res Function(SignUpRequest) then) =
      _$SignUpRequestCopyWithImpl<$Res, SignUpRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "office_id") int? officeId,
      @JsonKey(name: "first_name") String firstName,
      @JsonKey(name: "last_name") String lastName,
      @JsonKey(name: "position") String position,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "contact_number") String contactNumber,
      @JsonKey(name: "endorsement") String endorsementPath});
}

/// @nodoc
class _$SignUpRequestCopyWithImpl<$Res, $Val extends SignUpRequest>
    implements $SignUpRequestCopyWith<$Res> {
  _$SignUpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officeId = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? position = null,
    Object? email = null,
    Object? contactNumber = null,
    Object? endorsementPath = null,
  }) {
    return _then(_value.copyWith(
      officeId: freezed == officeId
          ? _value.officeId
          : officeId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      endorsementPath: null == endorsementPath
          ? _value.endorsementPath
          : endorsementPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignUpRequestCopyWith<$Res>
    implements $SignUpRequestCopyWith<$Res> {
  factory _$$_SignUpRequestCopyWith(
          _$_SignUpRequest value, $Res Function(_$_SignUpRequest) then) =
      __$$_SignUpRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "office_id") int? officeId,
      @JsonKey(name: "first_name") String firstName,
      @JsonKey(name: "last_name") String lastName,
      @JsonKey(name: "position") String position,
      @JsonKey(name: "email") String email,
      @JsonKey(name: "contact_number") String contactNumber,
      @JsonKey(name: "endorsement") String endorsementPath});
}

/// @nodoc
class __$$_SignUpRequestCopyWithImpl<$Res>
    extends _$SignUpRequestCopyWithImpl<$Res, _$_SignUpRequest>
    implements _$$_SignUpRequestCopyWith<$Res> {
  __$$_SignUpRequestCopyWithImpl(
      _$_SignUpRequest _value, $Res Function(_$_SignUpRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? officeId = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? position = null,
    Object? email = null,
    Object? contactNumber = null,
    Object? endorsementPath = null,
  }) {
    return _then(_$_SignUpRequest(
      officeId: freezed == officeId
          ? _value.officeId
          : officeId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      endorsementPath: null == endorsementPath
          ? _value.endorsementPath
          : endorsementPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SignUpRequest implements _SignUpRequest {
  _$_SignUpRequest(
      {@JsonKey(name: "office_id") this.officeId,
      @JsonKey(name: "first_name") required this.firstName,
      @JsonKey(name: "last_name") required this.lastName,
      @JsonKey(name: "position") required this.position,
      @JsonKey(name: "email") required this.email,
      @JsonKey(name: "contact_number") required this.contactNumber,
      @JsonKey(name: "endorsement") required this.endorsementPath});

  factory _$_SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$$_SignUpRequestFromJson(json);

  @override
  @JsonKey(name: "office_id")
  final int? officeId;
  @override
  @JsonKey(name: "first_name")
  final String firstName;
  @override
  @JsonKey(name: "last_name")
  final String lastName;
  @override
  @JsonKey(name: "position")
  final String position;
  @override
  @JsonKey(name: "email")
  final String email;
  @override
  @JsonKey(name: "contact_number")
  final String contactNumber;
  @override
  @JsonKey(name: "endorsement")
  final String endorsementPath;

  @override
  String toString() {
    return 'SignUpRequest(officeId: $officeId, firstName: $firstName, lastName: $lastName, position: $position, email: $email, contactNumber: $contactNumber, endorsementPath: $endorsementPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignUpRequest &&
            (identical(other.officeId, officeId) ||
                other.officeId == officeId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.endorsementPath, endorsementPath) ||
                other.endorsementPath == endorsementPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, officeId, firstName, lastName,
      position, email, contactNumber, endorsementPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignUpRequestCopyWith<_$_SignUpRequest> get copyWith =>
      __$$_SignUpRequestCopyWithImpl<_$_SignUpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignUpRequestToJson(
      this,
    );
  }
}

abstract class _SignUpRequest implements SignUpRequest {
  factory _SignUpRequest(
      {@JsonKey(name: "office_id")
          final int? officeId,
      @JsonKey(name: "first_name")
          required final String firstName,
      @JsonKey(name: "last_name")
          required final String lastName,
      @JsonKey(name: "position")
          required final String position,
      @JsonKey(name: "email")
          required final String email,
      @JsonKey(name: "contact_number")
          required final String contactNumber,
      @JsonKey(name: "endorsement")
          required final String endorsementPath}) = _$_SignUpRequest;

  factory _SignUpRequest.fromJson(Map<String, dynamic> json) =
      _$_SignUpRequest.fromJson;

  @override
  @JsonKey(name: "office_id")
  int? get officeId;
  @override
  @JsonKey(name: "first_name")
  String get firstName;
  @override
  @JsonKey(name: "last_name")
  String get lastName;
  @override
  @JsonKey(name: "position")
  String get position;
  @override
  @JsonKey(name: "email")
  String get email;
  @override
  @JsonKey(name: "contact_number")
  String get contactNumber;
  @override
  @JsonKey(name: "endorsement")
  String get endorsementPath;
  @override
  @JsonKey(ignore: true)
  _$$_SignUpRequestCopyWith<_$_SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
