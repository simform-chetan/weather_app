import 'package:weather_app/core/api_helper.dart';

class ApiConstants {
  const ApiConstants._();

  //TODO: Insert your 'OpenWeather map'
  static const String apiKey = '';

  static const String baseUrl = 'api.openweathermap.org';
  static const String geoCodingBaseUrl = 'geocoding-api.open-meteo.com';

  static const APIHelper client = APIHelper(baseUrl: baseUrl, apiKey: apiKey);
  static const APIHelper geoCodingClient = APIHelper(baseUrl: geoCodingBaseUrl);

  static const Duration timeout = Duration(seconds: 5);
}
