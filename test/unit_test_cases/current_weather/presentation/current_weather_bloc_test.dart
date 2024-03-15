import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/current_weather/domain/usecase/current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/get_current_weather_local_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/set_current_weather_local_usecase.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';

@GenerateMocks([
  CurrentWeatherUseCase,
  GetCurrentWeatherLocalUseCase,
  SetCurrentWeatherLocalUseCase,
])
import 'current_weather_bloc_test.mocks.dart';

void main() {
  late MockCurrentWeatherUseCase mockCurrentWeatherUseCase;
  late MockGetCurrentWeatherLocalUseCase mockGetCurrentWeatherLocalUseCase;
  late MockSetCurrentWeatherLocalUseCase mockSetCurrentWeatherLocalUseCase;
  late CurrentWeatherBloc currentWeatherBloc;

  setUp(() {
    mockCurrentWeatherUseCase = MockCurrentWeatherUseCase();
    mockGetCurrentWeatherLocalUseCase = MockGetCurrentWeatherLocalUseCase();
    mockSetCurrentWeatherLocalUseCase = MockSetCurrentWeatherLocalUseCase();
    currentWeatherBloc = CurrentWeatherBloc(
      weatherUseCase: mockCurrentWeatherUseCase,
      localGetUseCase: mockGetCurrentWeatherLocalUseCase,
      localSetUseCase: mockSetCurrentWeatherLocalUseCase,
    );
  });

  group('FetchWeekForecast', () {
    final successResponse = CurrentWeatherResponseDm(
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

    const errorResponse = BadRequestException();

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherSuccess] '
      'when FetchCurrentWeatherData is added and weatherUseCase call '
      'succeeds.',
      build: () {
        when(currentWeatherBloc.weatherUseCase.call(any))
            .thenAnswer((_) async => Success(successResponse));
        return currentWeatherBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchCurrentWeatherData(
            CurrentWeatherRequestDm(longitude: '24', latitude: '54'),
          ),
        );
      },
      expect: () => [
        const CurrentWeatherLoading(),
        CurrentWeatherSuccess(successResponse),
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      'emits [CurrentWeatherLoading, CurrentWeatherFailure] '
      'when FetchCurrentWeatherData is added and weatherUseCase call '
      'fails.',
      build: () {
        when(currentWeatherBloc.weatherUseCase.call(any)).thenAnswer(
          (_) async => const Failure(errorResponse),
        );
        return currentWeatherBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchCurrentWeatherData(
            CurrentWeatherRequestDm(longitude: 'ab', latitude: '54'),
          ),
        );
      },
      expect: () => const [
        CurrentWeatherLoading(),
        LocalWeatherFailure(errorResponse),
      ],
    );
  });
}
