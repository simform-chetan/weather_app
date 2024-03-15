// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_request_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherRequestDm _$CurrentWeatherRequestDmFromJson(
        Map<String, dynamic> json) =>
    CurrentWeatherRequestDm(
      name: json['name'] as String?,
      longitude: json['lon'] as String,
      latitude: json['lat'] as String,
    );

Map<String, dynamic> _$CurrentWeatherRequestDmToJson(
        CurrentWeatherRequestDm instance) =>
    <String, dynamic>{
      'lon': instance.longitude,
      'lat': instance.latitude,
    };
