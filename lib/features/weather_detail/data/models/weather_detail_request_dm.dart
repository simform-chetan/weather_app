import 'package:json_annotation/json_annotation.dart';

part 'weather_detail_request_dm.g.dart';

@JsonSerializable()
class WeatherDetailRequestDm {
  const WeatherDetailRequestDm({
    required this.longitude,
    required this.latitude,
    required this.count,
  });

  @JsonKey(name: "lon")
  final String longitude;
  @JsonKey(name: "lat")
  final String latitude;
  @JsonKey(name: "cnt")
  final String count;

  factory WeatherDetailRequestDm.fromJson(Map<String, dynamic> json) =>
      _$WeatherDetailRequestDmFromJson(json);

  Map<String, String> toJson() =>
      Map<String, String>.from(_$WeatherDetailRequestDmToJson(this));
}
