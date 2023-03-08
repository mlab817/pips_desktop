import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "id")
  int id;

  Attribute({
    required this.name,
    required this.id,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) =>
      _$AttributeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
