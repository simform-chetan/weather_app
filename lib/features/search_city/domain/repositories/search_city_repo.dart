import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';

abstract class SearchCityRepo {
  Future<ResultState> searchCity(SearchCityRequestDm requestDm);
}
