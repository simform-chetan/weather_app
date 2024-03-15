import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/domain/repositories/weather_detail_repo.dart';

class WeatherDetailUseCase
    extends UseCase<ResultState, WeatherDetailRequestDm> {
  const WeatherDetailUseCase(this._repository);

  final WeatherDetailRepo _repository;

  @override
  Future<ResultState> call(WeatherDetailRequestDm? params) async {
    return params == null
        ? Future.value(const Failure())
        : _repository.getWeatherDetail(params);
  }
}
