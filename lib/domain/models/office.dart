import 'package:freezed_annotation/freezed_annotation.dart';

part 'office.g.dart';

@JsonSerializable()
class Office {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "uuid")
  String uuid;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "acronym")
  String acronym;

  @JsonKey(name: "head_name")
  String headName;

  @JsonKey(name: "head_position")
  String headPosition;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "phone_number")
  String phoneNumber;

  Office({
    required this.id,
    required this.uuid,
    required this.name,
    required this.acronym,
    required this.headName,
    required this.headPosition,
    required this.email,
    required this.phoneNumber,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);
}
