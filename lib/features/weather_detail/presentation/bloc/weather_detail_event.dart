part of 'weather_detail_bloc.dart';

sealed class WeatherDetailEvent extends Equatable {
  const WeatherDetailEvent();
}

final class FetchWeekForecast extends WeatherDetailEvent {
  const FetchWeekForecast(this.requestDm);

  final WeatherDetailRequestDm requestDm;

  @override
  List<Object> get props => [requestDm];
}
