import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_parser/http_parser.dart';

part 'upload_avatar_request.g.dart';

@JsonSerializable()
class UploadAvatarRequest {
  // @JsonKey(name: "file_path")
  @JsonKey(includeToJson: false)
  String filePath;

  @JsonKey(includeFromJson: false)
  late MultipartFile avatar;

  UploadAvatarRequest({
    required this.filePath,
  }) {
    final pickedFile = File(filePath);
    final fileName = filePath.split('/').last;
    avatar = MultipartFile.fromFileSync(pickedFile.path,
        filename: fileName, contentType: MediaType('image', 'jpeg'));
  }

  factory UploadAvatarRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadAvatarRequestFromJson(json);

  Map<String, dynamic> toJson() {
    debugPrint("filePath $filePath");
    debugPrint(avatar.length.toString());

    final formData = FormData();
    // FormData.fromMap({'extra': 'test data', 'avatar': avatar ?? 'no data'});

    formData.files.add(MapEntry('avatar', avatar));

    debugPrint(formData.fields.toString());

    final map = <String, dynamic>{};

    formData.fields.forEach((field) {
      map[field.key] = field.value;
    });

    debugPrint("map: ${map.toString()}");

    return map;
  }
}
