import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';

class GetLastUpdateTimeUseCase extends UseCase<ResultState, NoParams> {
  const GetLastUpdateTimeUseCase(this._repository);

  final CurrentWeatherRepo _repository;

  @override
  Future<ResultState> call(NoParams? params) async =>
      _repository.getLastUpdateTime();
}
