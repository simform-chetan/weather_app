import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';

class CurrentWeatherUseCase
    extends UseCase<ResultState, CurrentWeatherRequestDm> {
  const CurrentWeatherUseCase(this._repository);

  final CurrentWeatherRepo _repository;

  @override
  Future<ResultState> call(CurrentWeatherRequestDm? params) async {
    return params == null
        ? Future.value(const Failure())
        : _repository.getCurrentWeather(params);
  }
}
