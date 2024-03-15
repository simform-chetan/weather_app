// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_detail_request_dm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDetailRequestDm _$WeatherDetailRequestDmFromJson(
        Map<String, dynamic> json) =>
    WeatherDetailRequestDm(
      longitude: json['lon'] as String,
      latitude: json['lat'] as String,
      count: json['cnt'] as String,
    );

Map<String, dynamic> _$WeatherDetailRequestDmToJson(
        WeatherDetailRequestDm instance) =>
    <String, dynamic>{
      'lon': instance.longitude,
      'lat': instance.latitude,
      'cnt': instance.count,
    };
