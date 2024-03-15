import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/core/usecase_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/current_weather/domain/usecase/current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/get_current_weather_local_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/set_current_weather_local_usecase.dart';

part 'current_weather_event.dart';

part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc({
    required this.weatherUseCase,
    required this.localGetUseCase,
    required this.localSetUseCase,
  }) : super(CurrentWeatherSuccess(CurrentWeatherResponseDm())) {
    on<LoadLocalWeatherData>(_handleLoadLocalWeatherData);
    on<FetchCurrentWeatherData>(_handleFetchCurrentWeatherData);
  }

  final CurrentWeatherUseCase weatherUseCase;
  final GetCurrentWeatherLocalUseCase localGetUseCase;
  final SetCurrentWeatherLocalUseCase localSetUseCase;

  Future<void> _handleLoadLocalWeatherData(
    LoadLocalWeatherData event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(const CurrentWeatherLoading());

    final result = await localGetUseCase(NoParams());

    final state = switch (result) {
      Success() => CurrentWeatherSuccess(result.value),
      Failure() => LocalWeatherFailure(result.value),
      ResultState() => const LocalWeatherFailure(),
    };
    emit(state);
  }

  Future<void> _handleFetchCurrentWeatherData(
    FetchCurrentWeatherData event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(const CurrentWeatherLoading());

    final result = await weatherUseCase(event.requestDm);

    if (result is Success) {
      await localSetUseCase((result.value as CurrentWeatherResponseDm)
          .copyWith(name: event.requestDm.name));
    }

    final state = switch (result) {
      Success() => CurrentWeatherSuccess(
          (result.value as CurrentWeatherResponseDm)
              .copyWith(name: event.requestDm.name),
        ),
      Failure() => CurrentWeatherFailure(result.value),
      ResultState() => const CurrentWeatherFailure(),
    };
    emit(state);
  }
}
