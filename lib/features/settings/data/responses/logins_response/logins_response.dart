import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/logins.dart';

part 'logins_response.g.dart';

@JsonSerializable()
class LoginsResponse {
  @JsonKey(name: "data")
  List<Logins> data;

  LoginsResponse({
    required this.data,
  });

  factory LoginsResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginsResponseToJson(this);
}
