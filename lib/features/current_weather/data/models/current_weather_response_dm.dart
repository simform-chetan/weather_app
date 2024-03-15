// To parse this JSON data, do
//
//     final currentWeatherResponseDm = currentWeatherResponseDmFromJson(jsonString);

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'current_weather_response_dm.g.dart';

CurrentWeatherResponseDm currentWeatherResponseDmFromJson(String str) => CurrentWeatherResponseDm.fromJson(json.decode(str));

String currentWeatherResponseDmToJson(CurrentWeatherResponseDm data) => json.encode(data.toJson());

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class CurrentWeatherResponseDm {
  @HiveField(1)
  @JsonKey(name: "coord")
  final Coord? coord;
  @HiveField(3)
  @JsonKey(name: "weather")
  final List<Weather>? weather;
  @HiveField(5)
  @JsonKey(name: "base")
  final String? base;
  @HiveField(7)
  @JsonKey(name: "main")
  final Main? main;
  @HiveField(15)
  @JsonKey(name: "dt")
  final int? dt;
  @HiveField(19)
  @JsonKey(name: "timezone")
  final int? timezone;
  @HiveField(21)
  @JsonKey(name: "id")
  final int? id;
  @HiveField(23)
  @JsonKey(name: "name")
  final String? name;
  @HiveField(25)
  @JsonKey(name: "cod")
  final int? cod;

  CurrentWeatherResponseDm({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.dt,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeatherResponseDm copyWith({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) =>
      CurrentWeatherResponseDm(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        base: base ?? this.base,
        main: main ?? this.main,
        dt: dt ?? this.dt,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
      );

  factory CurrentWeatherResponseDm.fromJson(Map<String, dynamic> json) => _$CurrentWeatherResponseDmFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherResponseDmToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Clouds {
  @HiveField(1)
  @JsonKey(name: "all")
  final int? all;

  Clouds({
    this.all,
  });

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()
class Coord {
  @HiveField(1)
  @JsonKey(name: "lon")
  final double? lon;
  @HiveField(3)
  @JsonKey(name: "lat")
  final double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  Coord copyWith({
    double? lon,
    double? lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class Main {
  @HiveField(1)
  @JsonKey(name: "temp")
  final double? temp;
  @HiveField(3)
  @JsonKey(name: "feels_like")
  final double? feelsLike;
  @HiveField(5)
  @JsonKey(name: "temp_min")
  final double? tempMin;
  @HiveField(7)
  @JsonKey(name: "temp_max")
  final double? tempMax;
  @HiveField(9)
  @JsonKey(name: "pressure")
  final int? pressure;
  @HiveField(11)
  @JsonKey(name: "humidity")
  final int? humidity;
  @HiveField(13)
  @JsonKey(name: "sea_level")
  final int? seaLevel;
  @HiveField(15)
  @JsonKey(name: "grnd_level")
  final int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        seaLevel: seaLevel ?? this.seaLevel,
        grndLevel: grndLevel ?? this.grndLevel,
      );

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class Sys {
  @HiveField(1)
  @JsonKey(name: "type")
  final int? type;
  @HiveField(3)
  @JsonKey(name: "id")
  final int? id;
  @HiveField(5)
  @JsonKey(name: "country")
  final String? country;
  @HiveField(7)
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @HiveField(9)
  @JsonKey(name: "sunset")
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@HiveType(typeId: 6)
@JsonSerializable()
class Weather {
  @HiveField(1)
  @JsonKey(name: "id")
  final int? id;
  @HiveField(3)
  @JsonKey(name: "main")
  final String? main;
  @HiveField(5)
  @JsonKey(name: "description")
  final String? description;
  @HiveField(7)
  @JsonKey(name: "icon")
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class Wind {
  @HiveField(1)
  @JsonKey(name: "speed")
  final double? speed;
  @HiveField(3)
  @JsonKey(name: "deg")
  final int? deg;
  @HiveField(5)
  @JsonKey(name: "gust")
  final double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
      );

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
