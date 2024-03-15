part of 'search_city_bloc.dart';

sealed class SearchCityState extends Equatable {
  const SearchCityState();
}

final class SearchCityLoading extends SearchCityState {
  const SearchCityLoading();

  @override
  List<Object> get props => List.empty();
}

final class SearchCitySuccess extends SearchCityState {
  const SearchCitySuccess({this.matches});

  final SearchCityResponseDm? matches;

  @override
  List<Object> get props => [if (matches != null) matches!];
}

final class SearchCityFailure extends SearchCityState {
  const SearchCityFailure([this.error = const FetchDataException()]);

  final NetworkException error;

  @override
  List<Object> get props => [error];
}
