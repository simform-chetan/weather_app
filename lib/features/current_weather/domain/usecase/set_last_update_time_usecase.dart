import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';

class SetLastUpdateTimeUseCase
    extends UseCase<ResultState, DateTime> {
  const SetLastUpdateTimeUseCase(this._repository);

  final CurrentWeatherRepo _repository;

  @override
  Future<ResultState> call(DateTime? params) async {
    return params == null
        ? Future.value(const Failure())
        : _repository.setLastUpdateTime(params);
  }
}
