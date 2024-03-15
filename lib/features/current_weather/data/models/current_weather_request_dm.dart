import 'package:json_annotation/json_annotation.dart';

part 'current_weather_request_dm.g.dart';

@JsonSerializable()
class CurrentWeatherRequestDm {
  const CurrentWeatherRequestDm({
    this.name,
    required this.longitude,
    required this.latitude,
  });

  @JsonKey(name: "name", includeIfNull: true, includeToJson: false)
  final String? name;
  @JsonKey(name: "lon")
  final String longitude;
  @JsonKey(name: "lat")
  final String latitude;

  factory CurrentWeatherRequestDm.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherRequestDmFromJson(json);

  Map<String, String> toJson() =>
      Map<String, String>.from(_$CurrentWeatherRequestDmToJson(this));
}
