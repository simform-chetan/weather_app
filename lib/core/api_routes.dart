class ApiRoutes {
  const ApiRoutes._();

  static const String version = '/data/2.5';
  static const String geoCodingVersion = '/v1';
  static const String weather = '$version/weather';
  static const String forecastDaily = '$version/forecast/daily';
  static const String search = '$geoCodingVersion/search';
}
