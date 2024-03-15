import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_response_dm.dart';
import 'package:weather_app/features/weather_detail/domain/usecase/weather_detail_usecase.dart';

part 'weather_detail_event.dart';

part 'weather_detail_state.dart';

class WeatherDetailBloc extends Bloc<WeatherDetailEvent, WeatherDetailState> {
  WeatherDetailBloc(this.useCase) : super(const WeatherDetailWeekLoading()) {
    on<FetchWeekForecast>(_handleFetchWeekForecast);
  }

  final WeatherDetailUseCase useCase;

  Future<void> _handleFetchWeekForecast(
    FetchWeekForecast event,
    Emitter<WeatherDetailState> emit,
  ) async {
    emit(const WeatherDetailWeekLoading());

    final result = await useCase(event.requestDm);

    final state = switch (result) {
      Success() => WeatherDetailWeekSuccess(result.value),
      Failure() => WeatherDetailWeekFailure(result.value),
      ResultState() => const WeatherDetailWeekFailure(FetchDataException()),
    };
    emit(state);
  }
}
