part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();
}

final class LoadLocalWeatherData extends CurrentWeatherEvent {
  const LoadLocalWeatherData();

  @override
  List<Object> get props => List.empty();
}

final class FetchCurrentWeatherData extends CurrentWeatherEvent {
  const FetchCurrentWeatherData(this.requestDm);

  final CurrentWeatherRequestDm requestDm;

  @override
  List<Object> get props => [requestDm];
}
