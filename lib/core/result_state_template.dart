import 'package:weather_app/core/network_exception.dart';

abstract class ResultState<T> {
  final T? data;
  final NetworkException? error;

  const ResultState({this.data, this.error});
}

class Success<T> extends ResultState<T> {
  final T value;

  const Success(this.value) : super(data: value);
}

class Failure extends ResultState {
  final NetworkException value;

  const Failure([this.value = const FetchDataException()])
      : super(error: value);
}
