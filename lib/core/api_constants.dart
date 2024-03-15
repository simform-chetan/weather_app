import 'package:weather_app/core/api_helper.dart';

class ApiConstants {
  const ApiConstants._();

  static const String apiKey = 'db37bc9578464c302cec499ab6e16c5a';

  static const String baseUrl = 'api.openweathermap.org';
  static const String geoCodingBaseUrl = 'geocoding-api.open-meteo.com';

  static const APIHelper client = APIHelper(baseUrl: baseUrl, apiKey: apiKey);
  static const APIHelper geoCodingClient = APIHelper(baseUrl: geoCodingBaseUrl);

  static const Duration timeout = Duration(seconds: 5);
}
