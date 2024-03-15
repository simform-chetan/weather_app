import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_response_dm.dart';
import 'package:weather_app/features/weather_detail/data/repositories/weather_detail_repo_impl.dart';
import 'package:weather_app/features/weather_detail/domain/repositories/weather_detail_repo.dart';

@GenerateMocks([APIHelper])
import 'weather_detail_repo_impl_test.mocks.dart';

void main() {
  late final MockAPIHelper mockWeatherDetailApi;
  late final WeatherDetailRepo weatherDetailRepo;
  late final WeatherDetailTestMock apiMock;

  setUpAll(() {
    mockWeatherDetailApi = MockAPIHelper();
    weatherDetailRepo = WeatherDetailRepoImpl(apiHelper: mockWeatherDetailApi);
    apiMock = WeatherDetailTestMock(apiHelper: mockWeatherDetailApi);
  });

  group('weatherDetail', () {
    // Success response
    test(
      'Should succeed fetching data from server response.',
      () async {
        const param =
            WeatherDetailRequestDm(longitude: '24', latitude: '54', count: '2');

        // arrange
        apiMock.withSuccess(
          WeatherDetailTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await weatherDetailRepo.getWeatherDetail(param);

        // assert
        expect(result, isA<Success>());
      },
    );

    // Failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param =
            WeatherDetailRequestDm(longitude: 'ab', latitude: '54', count: '2');

        // arrange
        apiMock.withError(
          WeatherDetailTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await weatherDetailRepo.getWeatherDetail(param);

        // assert
        expect(result, isA<Failure>());
      },
    );

    // Parsing failure response
    test(
      'Should fail fetching data from server response',
      () async {
        const param =
            WeatherDetailRequestDm(longitude: '24', latitude: '54', count: '2');

        // arrange
        apiMock.withEmpty(
          WeatherDetailTestParameters(
            queryParams: param.toJson(),
          ),
        );

        // act
        final result = await weatherDetailRepo.getWeatherDetail(param);

        // assert
        expect(result, isA<Failure>());
      },
    );
  });
}

class WeatherDetailTestMock {
  const WeatherDetailTestMock({required this.apiHelper});

  final APIHelper apiHelper;

  void withEmpty(WeatherDetailTestParameters params) {
    _mock(params).thenAnswer((_) async => {});
  }

  void withSuccess(WeatherDetailTestParameters params) {
    _mock(params).thenAnswer(
      (_) async => WeatherDetailTestResponses.success.toJson(),
    );
  }

  void withError(WeatherDetailTestParameters params) {
    _mock(params).thenThrow((_) async => WeatherDetailTestResponses.error);
  }

  PostExpectation<Future<Map<String, dynamic>>> _mock(
      WeatherDetailTestParameters params) {
    return when(
      apiHelper.get(
        params.url,
        headers: params.header,
        queryParameters: params.queryParams,
      ),
    );
  }
}

class WeatherDetailTestParameters {
  const WeatherDetailTestParameters({
    this.url = ApiRoutes.forecastDaily,
    this.queryParams = const <String, String>{},
    this.header,
  });

  final String url;
  final Map<String, String> queryParams;
  final Map<String, String>? header;
}

class WeatherDetailTestResponses {
  const WeatherDetailTestResponses._();

  static const error = BadRequestException();

  static final success = WeatherDetailResponseDm(
    city: City(
      id: 290557,
      name: "United Arab Emirates",
      coord: Coord(lon: 54, lat: 24),
      country: "AE",
      population: 0,
      timezone: 14400,
    ),
    cod: "200",
    message: 0.0751459,
    cnt: 2,
    list: [
      ListElement(
        dt: 1710489600,
        sunrise: 1710469974,
        sunset: 1710513177,
        temp: Temp(
          day: 300.54,
          min: 294.64,
          max: 301.5,
          night: 296.49,
          eve: 298.8,
          morn: 294.68,
        ),
        feelsLike:
            FeelsLike(day: 300.1, night: 296.26, eve: 298.57, morn: 294.61),
        pressure: 1017,
        humidity: 36,
        weather: [
          Weather(
            id: 801,
            main: "Clouds",
            description: "few clouds",
            icon: "02d",
          ),
        ],
        speed: 7.53,
        deg: 347,
        gust: 6.3,
        clouds: 13,
        pop: 0,
      ),
      ListElement(
        dt: 1710576000,
        sunrise: 1710556313,
        sunset: 1710599602,
        temp: Temp(
          day: 303.71,
          min: 295.89,
          max: 305.48,
          night: 298.79,
          eve: 300.89,
          morn: 295.89,
        ),
        feelsLike:
            FeelsLike(day: 301.89, night: 298.58, eve: 300.36, morn: 295.29),
        pressure: 1014,
        humidity: 21,
        weather: [
          Weather(
            id: 801,
            main: "Clouds",
            description: "few clouds",
            icon: "02"
                "d",
          )
        ],
        speed: 4.96,
        deg: 146,
        gust: 5.82,
        clouds: 12,
        pop: 0,
      ),
    ],
  );
}
