import 'package:weather_app/core/db_helper.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';

class DbConstants {
  const DbConstants._();

  static const String weatherName = 'WeatherDb';
  static const String timeDb = 'TimeDb';

  static final DbHelper<CurrentWeatherResponseDm> weatherStorage =
      DbHelper<CurrentWeatherResponseDm>(weatherName);
  static final DbHelper<DateTime> timeStorage = DbHelper<DateTime>(timeDb);

  static const String currentWeatherKey = 'currentWeather';
  static const String lastUpdateTime = 'lastUpdateTime';
}
