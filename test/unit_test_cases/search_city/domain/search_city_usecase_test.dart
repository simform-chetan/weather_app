import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart';
import 'package:weather_app/features/search_city/domain/usecase/search_city_usecase.dart';

@GenerateMocks([SearchCityRepo])
import 'search_city_usecase_test.mocks.dart';

void main() {
  late final MockSearchCityRepo mockSearchCityRepo;
  late final SearchCityUseCase searchCityUseCase;
  late final SearchCityTestMock testMock;

  setUpAll(() {
    mockSearchCityRepo = MockSearchCityRepo();
    searchCityUseCase = SearchCityUseCase(mockSearchCityRepo);
    testMock = SearchCityTestMock(repository: mockSearchCityRepo);
  });

  group('searchCity', () {
    // Success Response
    test(
      'Should succeed fetching data from server response.',
      () async {
        const param = SearchCityRequestDm(name: 'Abu ', count: '2');

        // arrange
        testMock.withSuccess(param);

        // act
        final result = await searchCityUseCase.call(param);

        // assert
        expect(result, isA<Success>());

        verify(mockSearchCityRepo.searchCity(param));

        verifyNoMoreInteractions(mockSearchCityRepo);
      },
    );

    // Failure Response
    test(
      'Should fail to fetch data from server response.',
      () async {
        const param = SearchCityRequestDm(name: '1340315', count: '-49');

        // arrange
        testMock.withError(param);

        // act
        final result = await searchCityUseCase.call(param);

        // assert
        expect(result, isA<Failure>());

        verify(mockSearchCityRepo.searchCity(param));

        verifyNoMoreInteractions(mockSearchCityRepo);
      },
    );
  });
}

class SearchCityTestMock {
  const SearchCityTestMock({required this.repository});

  final SearchCityRepo repository;

  void withSuccess(SearchCityRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => Success(SearchCityTestResponses.success),
    );
  }

  void withError(SearchCityRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => const Failure(SearchCityTestResponses.error),
    );
  }

  PostExpectation<Future<ResultState>> _mock(SearchCityRequestDm params) {
    return when(repository.searchCity(params));
  }
}

class SearchCityTestResponses {
  const SearchCityTestResponses._();

  static const error = UnauthorisedException();

  static final success = SearchCityResponseDm(
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
}
