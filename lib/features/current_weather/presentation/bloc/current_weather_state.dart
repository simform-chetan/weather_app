part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
}

final class CurrentWeatherLoading extends CurrentWeatherState {
  const CurrentWeatherLoading();

  @override
  List<Object> get props => List.empty();
}

final class CurrentWeatherSuccess extends CurrentWeatherState {
  const CurrentWeatherSuccess(this.weather);

  final CurrentWeatherResponseDm weather;

  @override
  List<Object> get props => [weather];
}

final class CurrentWeatherFailure extends CurrentWeatherState {
  const CurrentWeatherFailure([this.error = const FetchDataException()]);

  final NetworkException error;

  @override
  List<Object> get props => [error];
}

final class LocalWeatherFailure extends CurrentWeatherState {
  const LocalWeatherFailure([this.error = const FetchDataException()]);

  final NetworkException error;

  @override
  List<Object> get props => [error];
}
