import 'package:json_annotation/json_annotation.dart';
import 'package:pips/features/project/domain/models/options.dart';

part 'options_response.g.dart';

@JsonSerializable()
class OptionsResponse {
  @JsonKey(name: "data")
  Options? data;

  OptionsResponse({
    this.data,
  });

  factory OptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OptionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsResponseToJson(this);
}
