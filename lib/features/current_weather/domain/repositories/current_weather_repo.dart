import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';

abstract class CurrentWeatherRepo {
  Future<ResultState> getCurrentWeather(CurrentWeatherRequestDm requestDm);

  Future<ResultState> getCurrentWeatherFromLocal();

  Future<ResultState> setCurrentWeatherInLocal(
    CurrentWeatherResponseDm requestDm,
  );

  Future<ResultState> getLastUpdateTime();

  Future<ResultState> setLastUpdateTime(DateTime time);
}
