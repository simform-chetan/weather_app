part of 'search_city_bloc.dart';

sealed class SearchCityEvent extends Equatable {
  const SearchCityEvent();
}

final class FetchCitySearchResult extends SearchCityEvent {
  const FetchCitySearchResult(this.requestDm);

  final SearchCityRequestDm? requestDm;

  @override
  List<Object> get props => [if (requestDm != null) requestDm!];
}
