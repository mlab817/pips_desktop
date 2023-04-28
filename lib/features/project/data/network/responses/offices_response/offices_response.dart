import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../common/data/network/responses/meta_response/meta_response.dart';
import '../../../../domain/models/office.dart';

part 'offices_response.g.dart';

@JsonSerializable()
class OfficesResponse {
  @JsonKey(name: "data")
  List<Office>? data;

  @JsonKey(name: "meta")
  MetaResponse meta;

  OfficesResponse({
    required this.data,
    required this.meta,
  });

  factory OfficesResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfficesResponseToJson(this);
}
