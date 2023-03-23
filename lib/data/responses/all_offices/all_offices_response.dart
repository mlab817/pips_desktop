import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/office.dart';

part 'all_offices_response.g.dart';

@JsonSerializable()
class AllOfficesResponse {
  @JsonKey(name: "data")
  List<Office> data;

  AllOfficesResponse({
    required this.data,
  });

  factory AllOfficesResponse.fromJson(Map<String, dynamic> json) =>
      _$AllOfficesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllOfficesResponseToJson(this);
}
