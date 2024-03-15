import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';
import 'package:weather_app/features/search_city/domain/usecase/search_city_usecase.dart';
import 'package:weather_app/features/search_city/presentation/bloc/search_city_bloc.dart';

@GenerateMocks([SearchCityUseCase])
import 'search_city_bloc_test.mocks.dart';

void main() {
  late MockSearchCityUseCase mockSearchCityUseCase;
  late SearchCityBloc searchCityBloc;

  setUp(() {
    mockSearchCityUseCase = MockSearchCityUseCase();
    searchCityBloc = SearchCityBloc(mockSearchCityUseCase);
  });

  group('FetchCitySearchResult', () {
    final successResponse = SearchCityResponseDm(
      results: [
        Result(
          id: 292968,
          name: "Abu Dhabi",
          latitude: 24.45118,
          longitude: 54.39696,
          elevation: 6,
          featureCode: "PPLC",
          countryCode: "AE",
          admin1Id: 292969,
          timezone: "Asia/Dubai",
          population: 603492,
          countryId: 290557,
          country: "United Arab Emirates",
          admin1: "Abu Dhabi",
        ),
        Result(
          id: 100077,
          name: "Abu Ghraib",
          latitude: 33.30563,
          longitude: 44.18477,
          elevation: 42,
          featureCode: "PPLA2",
          countryCode: "IQ",
          admin1Id: 98180,
          admin2Id: 9166542,
          timezone: "Asia/Baghdad",
          population: 900000,
          countryId: 99237,
          country: "Iraq",
          admin1: "Baghdad",
          admin2: "Abu Ghraib District",
        ),
      ],
      generationtimeMs: 2,
    );

    const errorResponse = UnauthorisedException();

    blocTest<SearchCityBloc, SearchCityState>(
      'emits [SearchCitySuccess] '
      'when FetchCitySearchResult is added and SearchCityUseCase call '
      'succeeds but returns an empty list.',
      build: () {
        when(searchCityBloc.useCase.call(any))
            .thenAnswer((_) async => const Success([]));
        return searchCityBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchCitySearchResult(
            SearchCityRequestDm(name: '', count: '10'),
          ),
        );
      },
      expect: () => const [SearchCitySuccess()],
    );

    blocTest<SearchCityBloc, SearchCityState>(
      'emits [SearchCityLoading, SearchCitySuccess] '
      'when FetchCitySearchResult is added and SearchCityUseCase call '
      'succeeds.',
      build: () {
        when(searchCityBloc.useCase.call(any))
            .thenAnswer((_) async => Success(successResponse));
        return searchCityBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchCitySearchResult(
            SearchCityRequestDm(name: 'Abu ', count: '2'),
          ),
        );
      },
      expect: () => [
        const SearchCityLoading(),
        SearchCitySuccess(matches: successResponse),
      ],
    );

    blocTest<SearchCityBloc, SearchCityState>(
      'emits [SearchCityLoading, SearchCityFailure] '
      'when FetchCitySearchResult is added and SearchCityUseCase call '
      'fails.',
      build: () {
        when(searchCityBloc.useCase.call(any)).thenAnswer(
          (_) async => const Failure(errorResponse),
        );
        return searchCityBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchCitySearchResult(
            SearchCityRequestDm(name: '109384', count: '-10'),
          ),
        );
      },
      expect: () => const [
        SearchCityLoading(),
        SearchCityFailure(errorResponse),
      ],
    );
  });
}
