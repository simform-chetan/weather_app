import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';
import 'package:weather_app/features/search_city/data/repositories/search_city_repo_impl.dart';
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart';

@GenerateMocks([APIHelper])
import 'search_city_repo_impl_test.mocks.dart';

void main() {
  late final MockAPIHelper mockSearchCityApi;
  late final SearchCityRepo searchCityRepo;
  late final SearchCityTestMock apiMock;

  setUpAll(() {
    mockSearchCityApi = MockAPIHelper();
    searchCityRepo = SearchCityRepoImpl(apiHelper: mockSearchCityApi);
    apiMock = SearchCityTestMock(apiHelper: mockSearchCityApi);
  });

  group('searchCity', () {
    // Success response
    test(
      'Should succeed fetching data from server response.',
      () async {
        const param = SearchCityRequestDm(name: 'Abu ', count: '2');

        // arrange
        apiMock.withSuccess(
          SearchCityTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await searchCityRepo.searchCity(param);

        // assert
        expect(result, isA<Success>());
      },
    );

    // Failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param = SearchCityRequestDm(name: '984425', count: '-41');

        // arrange
        apiMock.withError(
          SearchCityTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await searchCityRepo.searchCity(param);

        // assert
        expect(result, isA<Failure>());
      },
    );

    // Parsing failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param = SearchCityRequestDm(name: '', count: '0');

        // arrange
        apiMock.withEmpty(
          SearchCityTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await searchCityRepo.searchCity(param);

        // assert
        expect(result, isA<Success>());
      },
    );
  });
}

class SearchCityTestMock {
  const SearchCityTestMock({required this.apiHelper});

  final APIHelper apiHelper;

  void withEmpty(SearchCityTestParameters params) {
    _mock(params).thenAnswer((_) async => {});
  }

  void withSuccess(SearchCityTestParameters params) {
    _mock(params).thenAnswer(
      (_) async => SearchCityTestResponses.success.toJson(),
    );
  }

  void withError(SearchCityTestParameters params) {
    _mock(params).thenThrow((_) async => SearchCityTestResponses.error);
  }

  PostExpectation<Future<Map<String, dynamic>>> _mock(
      SearchCityTestParameters params) {
    return when(
      apiHelper.get(
        params.url,
        headers: params.header,
        queryParameters: params.queryParams,
      ),
    );
  }
}

class SearchCityTestParameters {
  const SearchCityTestParameters({
    this.url = ApiRoutes.search,
    this.queryParams = const <String, String>{},
    this.header,
  });

  final String url;
  final Map<String, String> queryParams;
  final Map<String, String>? header;
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
