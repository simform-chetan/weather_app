import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';
import 'package:weather_app/features/search_city/domain/usecase/search_city_usecase.dart';

part 'search_city_event.dart';

part 'search_city_state.dart';

class SearchCityBloc extends Bloc<SearchCityEvent, SearchCityState> {
  SearchCityBloc(this.useCase) : super(const SearchCitySuccess()) {
    on<FetchCitySearchResult>(_handleFetchCitySearchResult);
  }

  final SearchCityUseCase useCase;

  Future<void> _handleFetchCitySearchResult(
    FetchCitySearchResult event,
    Emitter<SearchCityState> emit,
  ) async {
    final request = event.requestDm;
    if (request == null || request.name.trim().isEmpty) {
      emit(const SearchCitySuccess());
      return;
    }

    emit(const SearchCityLoading());

    final result = await useCase(request);
    final state = switch (result) {
      Success() => SearchCitySuccess(matches: result.value),
      Failure() => SearchCityFailure(result.value),
      ResultState() => const SearchCityFailure(),
    };

    emit(state);
  }
}
