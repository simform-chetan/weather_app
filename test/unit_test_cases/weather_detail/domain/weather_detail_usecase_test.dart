import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_response_dm.dart';
import 'package:weather_app/features/weather_detail/domain/repositories/weather_detail_repo.dart';
import 'package:weather_app/features/weather_detail/domain/usecase/weather_detail_usecase.dart';

@GenerateMocks([WeatherDetailRepo])
import 'weather_detail_usecase_test.mocks.dart';

void main() {
  late final MockWeatherDetailRepo mockWeatherDetailRepo;
  late final WeatherDetailUseCase weatherDetailUseCase;
  late final WeatherDetailTestMock testMock;

  setUpAll(() {
    mockWeatherDetailRepo = MockWeatherDetailRepo();
    weatherDetailUseCase = WeatherDetailUseCase(mockWeatherDetailRepo);
    testMock = WeatherDetailTestMock(repository: mockWeatherDetailRepo);
  });

  group('searchCity', () {
    // Success Response
    test(
      'Should succeed fetching data from server response.',
      () async {
        const param =
            WeatherDetailRequestDm(longitude: '24', latitude: '54', count: '2');

        // arrange
        testMock.withSuccess(param);

        // act
        final result = await weatherDetailUseCase.call(param);

        // assert
        expect(result, isA<Success>());

        verify(mockWeatherDetailRepo.getWeatherDetail(param));

        verifyNoMoreInteractions(mockWeatherDetailRepo);
      },
    );

    // Failure Response
    test(
      'Should fail to fetch data from server response.',
      () async {
        const param =
            WeatherDetailRequestDm(longitude: 'ab', latitude: '54', count: '2');

        // arrange
        testMock.withError(param);

        // act
        final result = await weatherDetailUseCase.call(param);

        // assert
        expect(result, isA<Failure>());

        verify(mockWeatherDetailRepo.getWeatherDetail(param));

        verifyNoMoreInteractions(mockWeatherDetailRepo);
      },
    );
  });
}

class WeatherDetailTestMock {
  const WeatherDetailTestMock({required this.repository});

  final WeatherDetailRepo repository;

  void withSuccess(WeatherDetailRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => Success(WeatherDetailTestResponses.success),
    );
  }

  void withError(WeatherDetailRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => const Failure(WeatherDetailTestResponses.error),
    );
  }

  PostExpectation<Future<ResultState>> _mock(WeatherDetailRequestDm params) {
    return when(repository.getWeatherDetail(params));
  }
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
