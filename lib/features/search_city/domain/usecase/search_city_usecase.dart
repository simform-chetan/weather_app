import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart';

class SearchCityUseCase extends UseCase<ResultState, SearchCityRequestDm> {
  const SearchCityUseCase(this._repository);

  final SearchCityRepo _repository;

  @override
  Future<ResultState> call(SearchCityRequestDm? params) async {
    return params == null
        ? Future.value(const Failure())
        : _repository.searchCity(params);
  }
}
