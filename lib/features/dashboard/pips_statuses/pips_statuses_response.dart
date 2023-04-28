import 'package:freezed_annotation/freezed_annotation.dart';

import '../../project/domain/models/pips_status.dart';

part 'pips_statuses_response.g.dart';

@JsonSerializable()
class PipsStatusesResponse {
  @JsonKey(name: "data")
  List<PipsStatus> data;

  PipsStatusesResponse({
    required this.data,
  });

  factory PipsStatusesResponse.fromJson(Map<String, dynamic> json) =>
      _$PipsStatusesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PipsStatusesResponseToJson(this);
}
