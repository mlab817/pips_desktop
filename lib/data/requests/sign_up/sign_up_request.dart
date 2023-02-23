import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

@freezed
class SignUpRequest with _$SignUpRequest {
  factory SignUpRequest({
    @JsonKey(name: "office_id") int? officeId,
    @JsonKey(name: "first_name") required String firstName,
    @JsonKey(name: "last_name") required String lastName,
    @JsonKey(name: "position") required String position,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "contact_number") required String contactNumber,
    @JsonKey(name: "endorsement") required String endorsementPath,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final formData = FormData.fromMap({
      'office_id': officeId,
      'first_name': firstName,
      'last_name': lastName,
      'position': position,
      'email': email,
      'contact_number': contactNumber,
      'endorsement': endorsementPath != null
          ? MultipartFile.fromFileSync(endorsementPath)
          : null,
    });

    final map = <String, dynamic>{};

    formData.fields.forEach((field) {
      map[field.name] = field.value;
    });

    formData.files.forEach((file) {
      map[file.field] = file.value;
    });

    return map;
  }
}

class FileConverter implements JsonConverter<File?, String?> {
  const FileConverter();

  @override
  File? fromJson(String? json) {
    if (json == null) return null;
    return File(json);
  }

  @override
  String? toJson(File? file) {
    if (file == null) return null;
    return file.path;
  }
}

extension Converter on File? {
  String? toJson() {
    if (this == null) return null;
    return this?.path;
  }
}
