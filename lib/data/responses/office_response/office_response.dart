import 'package:freezed_annotation/freezed_annotation.dart';

import 'office_response_data.dart';

part 'office_response.g.dart';

@JsonSerializable()
class OfficeResponse {
  @JsonKey(name: "data")
  OfficeResponseData data;

  OfficeResponse({
    required this.data,
  });

  factory OfficeResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeResponseToJson(this);
}
