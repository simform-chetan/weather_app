import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';
import 'package:weather_app/features/current_weather/domain/usecase/current_weather_usecase.dart';

@GenerateMocks([CurrentWeatherRepo])
import 'current_weather_usecase_test.mocks.dart';

void main() {
  late final MockCurrentWeatherRepo mockCurrentWeatherRepo;
  late final CurrentWeatherUseCase currentWeatherUseCase;
  late final CurrentWeatherTestMock testMock;

  setUpAll(() {
    mockCurrentWeatherRepo = MockCurrentWeatherRepo();
    currentWeatherUseCase = CurrentWeatherUseCase(mockCurrentWeatherRepo);
    testMock = CurrentWeatherTestMock(repository: mockCurrentWeatherRepo);
  });

  group('currentWeather', () {
    // Success Response
    test(
      'Should succeed fetching data from server response.',
      () async {
        const param = CurrentWeatherRequestDm(longitude: '24', latitude: '54');

        // arrange
        testMock.withSuccess(param);

        // act
        final result = await currentWeatherUseCase.call(param);

        // assert
        expect(result, isA<Success>());

        verify(mockCurrentWeatherRepo.getCurrentWeather(param));

        verifyNoMoreInteractions(mockCurrentWeatherRepo);
      },
    );

    // Failure Response
    test(
      'Should fail to fetch data from server response.',
      () async {
        const param = CurrentWeatherRequestDm(longitude: 'ab', latitude: '54');

        // arrange
        testMock.withError(param);

        // act
        final result = await currentWeatherUseCase.call(param);

        // assert
        expect(result, isA<Failure>());

        verify(mockCurrentWeatherRepo.getCurrentWeather(param));

        verifyNoMoreInteractions(mockCurrentWeatherRepo);
      },
    );
  });
}

class CurrentWeatherTestMock {
  const CurrentWeatherTestMock({required this.repository});

  final CurrentWeatherRepo repository;

  void withSuccess(CurrentWeatherRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => Success(CurrentWeatherTestResponses.success),
    );
  }

  void withError(CurrentWeatherRequestDm params) {
    _mock(params).thenAnswer(
      (_) async => const Failure(CurrentWeatherTestResponses.error),
    );
  }

  PostExpectation<Future<ResultState>> _mock(CurrentWeatherRequestDm params) {
    return when(repository.getCurrentWeather(params));
  }
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
