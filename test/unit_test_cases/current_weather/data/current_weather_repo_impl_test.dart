import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/db_helper.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/current_weather/data/repositories/current_weather_repo_impl.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';

@GenerateMocks([
  APIHelper,
  DbHelper,
])
import 'current_weather_repo_impl_test.mocks.dart';

void main() {
  late final MockAPIHelper mockCurrentWeatherApi;
  late final MockDbHelper<CurrentWeatherResponseDm> mockWeatherDb;
  late final MockDbHelper<DateTime> mockTimeDb;
  late final CurrentWeatherRepo currentWeatherRepo;
  late final CurrentWeatherTestMock apiMock;

  setUpAll(() {
    mockCurrentWeatherApi = MockAPIHelper();
    mockWeatherDb = MockDbHelper<CurrentWeatherResponseDm>();
    mockTimeDb = MockDbHelper<DateTime>();

    currentWeatherRepo = CurrentWeatherRepoImpl(
      apiHelper: mockCurrentWeatherApi,
      weatherDb: mockWeatherDb,
      timeDb: mockTimeDb,
    );
    apiMock = CurrentWeatherTestMock(apiHelper: mockCurrentWeatherApi);
  });

  group('weatherDetail', () {
    // Success response
    test(
      'Should succeed fetching from server response.',
      () async {
        const param = CurrentWeatherRequestDm(longitude: '24', latitude: '54');

        // arrange
        apiMock.withSuccess(
          CurrentWeatherTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await currentWeatherRepo.getCurrentWeather(param);

        // assert
        expect(result, isA<Success>());
      },
    );

    // Failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param = CurrentWeatherRequestDm(longitude: 'ab', latitude: '54');

        // arrange
        apiMock.withError(
          CurrentWeatherTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await currentWeatherRepo.getCurrentWeather(param);

        // assert
        expect(result, isA<Failure>());
      },
    );

    // Parsing failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param = CurrentWeatherRequestDm(longitude: '24', latitude: '54');

        // arrange
        apiMock.withEmpty(
          CurrentWeatherTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await currentWeatherRepo.getCurrentWeather(param);

        // assert
        expect(result, isA<Failure>());
      },
    );
  });
}

class CurrentWeatherTestMock {
  const CurrentWeatherTestMock({required this.apiHelper});

  final APIHelper apiHelper;

  void withEmpty(CurrentWeatherTestParameters params) {
    _mock(params).thenAnswer((_) async => {});
  }

  void withSuccess(CurrentWeatherTestParameters params) {
    _mock(params).thenAnswer(
      (_) async => CurrentWeatherTestResponses.success.toJson(),
    );
  }

  void withError(CurrentWeatherTestParameters params) {
    _mock(params).thenThrow((_) async => CurrentWeatherTestResponses.error);
  }

  PostExpectation<Future<Map<String, dynamic>>> _mock(
      CurrentWeatherTestParameters params) {
    return when(
      apiHelper.get(
        params.url,
        headers: params.header,
        queryParameters: params.queryParams,
      ),
    );
  }
}

class CurrentWeatherTestParameters {
  const CurrentWeatherTestParameters({
    this.url = ApiRoutes.weather,
    this.queryParams = const <String, String>{},
    this.header,
  });

  final String url;
  final Map<String, String> queryParams;
  final Map<String, String>? header;
}

class CurrentWeatherTestResponses {
  const CurrentWeatherTestResponses._();

  static const error = BadRequestException();

  static final success = CurrentWeatherResponseDm(
    coord: Coord(lon: 10.99, lat: 44.34),
    weather: [
      Weather(
        id: 802,
        main: "Clouds",
        description: "scattered clouds",
        icon: "03d",
      ),
    ],
    base: "stations",
    main: Main(
      temp: 284.43,
      feelsLike: 283.31,
      tempMin: 281.8,
      tempMax: 285.73,
      pressure: 1018,
      humidity: 65,
      seaLevel: 1018,
      grndLevel: 932,
    ),
    timezone: 3600,
    id: 3163858,
    name: "Zocca",
    cod: 200,
  );
}
