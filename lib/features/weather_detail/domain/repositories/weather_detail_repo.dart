import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';

abstract class WeatherDetailRepo {
  Future<ResultState> getWeatherDetail(WeatherDetailRequestDm requestDm);
}
