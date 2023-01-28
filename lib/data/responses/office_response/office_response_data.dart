import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/office.dart';
import '../../../domain/models/project.dart';
import '../../../domain/models/user.dart';

part 'office_response_data.g.dart';

@JsonSerializable()
class OfficeResponseData extends Office {
  @JsonKey(name: "projects")
  List<Project>? projects;

  @JsonKey(name: "users")
  List<UserModel>? users;

  OfficeResponseData({
    required id,
    required uuid,
    required name,
    required acronym,
    required headName,
    required headPosition,
    required email,
    required phoneNumber,
    required this.projects,
    required this.users,
  }) : super(
          id: id,
          uuid: uuid,
          name: name,
          acronym: acronym,
          headName: headName,
          headPosition: headPosition,
          email: email,
          phoneNumber: phoneNumber,
        );

  factory OfficeResponseData.fromJson(Map<String, dynamic> json) =>
      _$OfficeResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OfficeResponseDataToJson(this);
}
