// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_response_dm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherResponseDmAdapter
    extends TypeAdapter<CurrentWeatherResponseDm> {
  @override
  final int typeId = 1;

  @override
  CurrentWeatherResponseDm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeatherResponseDm(
      coord: fields[1] as Coord?,
      weather: (fields[3] as List?)?.cast<Weather>(),
      base: fields[5] as String?,
      main: fields[7] as Main?,
      dt: fields[15] as int?,
      timezone: fields[19] as int?,
      id: fields[21] as int?,
      name: fields[23] as String?,
      cod: fields[25] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherResponseDm obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.coord)
      ..writeByte(3)
      ..write(obj.weather)
      ..writeByte(5)
      ..write(obj.base)
      ..writeByte(7)
      ..write(obj.main)
      ..writeByte(15)
      ..write(obj.dt)
      ..writeByte(19)
      ..write(obj.timezone)
      ..writeByte(21)
      ..write(obj.id)
      ..writeByte(23)
      ..write(obj.name)
      ..writeByte(25)
      ..write(obj.cod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherResponseDmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CloudsAdapter extends TypeAdapter<Clouds> {
  @override
  final int typeId = 2;

  @override
  Clouds read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clouds(
      all: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Clouds obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.all);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CloudsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordAdapter extends TypeAdapter<Coord> {
  @override
  final int typeId = 3;

  @override
  Coord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coord(
      lon: fields[1] as double?,
      lat: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Coord obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(3)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MainAdapter extends TypeAdapter<Main> {
  @override
  final int typeId = 4;

  @override
  Main read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Main(
      temp: fields[1] as double?,
      feelsLike: fields[3] as double?,
      tempMin: fields[5] as double?,
      tempMax: fields[7] as double?,
      pressure: fields[9] as int?,
      humidity: fields[11] as int?,
      seaLevel: fields[13] as int?,
      grndLevel: fields[15] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Main obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(3)
      ..write(obj.feelsLike)
      ..writeByte(5)
      ..write(obj.tempMin)
      ..writeByte(7)
      ..write(obj.tempMax)
      ..writeByte(9)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(13)
      ..write(obj.seaLevel)
      ..writeByte(15)
      ..write(obj.grndLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SysAdapter extends TypeAdapter<Sys> {
  @override
  final int typeId = 5;

  @override
  Sys read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sys(
      type: fields[1] as int?,
      id: fields[3] as int?,
      country: fields[5] as String?,
      sunrise: fields[7] as int?,
      sunset: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Sys obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.sunrise)
      ..writeByte(9)
      ..write(obj.sunset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 6;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      id: fields[1] as int?,
      main: fields[3] as String?,
      description: fields[5] as String?,
      icon: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.main)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WindAdapter extends TypeAdapter<Wind> {
  @override
  final int typeId = 7;

  @override
  Wind read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wind(
      speed: fields[1] as double?,
      deg: fields[3] as int?,
      gust: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Wind obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.speed)
      ..writeByte(3)
      ..write(obj.deg)
      ..writeByte(5)
      ..write(obj.gust);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WindAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherResponseDm _$CurrentWeatherResponseDmFromJson(
        Map<String, dynamic> json) =>
    CurrentWeatherResponseDm(
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      base: json['base'] as String?,
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      dt: json['dt'] as int?,
      timezone: json['timezone'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      cod: json['cod'] as int?,
    );

Map<String, dynamic> _$CurrentWeatherResponseDmToJson(
        CurrentWeatherResponseDm instance) =>
    <String, dynamic>{
      'coord': instance.coord?.toJson(),
      'weather': instance.weather?.map((e) => e.toJson()).toList(),
      'base': instance.base,
      'main': instance.main?.toJson(),
      'dt': instance.dt,
      'timezone': instance.timezone,
      'id': instance.id,
      'name': instance.name,
      'cod': instance.cod,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
      all: json['all'] as int?,
    );

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      pressure: json['pressure'] as int?,
      humidity: json['humidity'] as int?,
      seaLevel: json['sea_level'] as int?,
      grndLevel: json['grnd_level'] as int?,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };

Sys _$SysFromJson(Map<String, dynamic> json) => Sys(
      type: json['type'] as int?,
      id: json['id'] as int?,
      country: json['country'] as String?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );

Map<String, dynamic> _$SysToJson(Sys instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      id: json['id'] as int?,
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
      gust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
