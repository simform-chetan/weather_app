part of 'weather_detail_bloc.dart';

sealed class WeatherDetailState extends Equatable {
  const WeatherDetailState();
}

final class WeatherDetailInitial extends WeatherDetailState {
  const WeatherDetailInitial(this.currentWeather);

  final CurrentWeatherResponseDm currentWeather;

  @override
  List<Object> get props => [currentWeather];
}

final class WeatherDetailWeekLoading extends WeatherDetailState {
  const WeatherDetailWeekLoading();

  @override
  List<Object> get props => List.empty();
}

final class WeatherDetailWeekSuccess extends WeatherDetailState {
  const WeatherDetailWeekSuccess(this.detail);

  final WeatherDetailResponseDm detail;

  @override
  List<Object> get props => [detail];
}

final class WeatherDetailWeekFailure extends WeatherDetailState {
  const WeatherDetailWeekFailure(this.error);

  final NetworkException error;

  @override
  List<Object> get props => [error];
}
