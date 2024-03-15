import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_response_dm.dart';
import 'package:weather_app/features/weather_detail/domain/usecase/weather_detail_usecase.dart';
import 'package:weather_app/features/weather_detail/presentation/bloc/weather_detail_bloc.dart';

@GenerateMocks([WeatherDetailUseCase])
import 'weather_detail_bloc_test.mocks.dart';

void main() {
  late MockWeatherDetailUseCase mockWeatherDetailUseCase;
  late WeatherDetailBloc weatherDetailBloc;

  setUp(() {
    mockWeatherDetailUseCase = MockWeatherDetailUseCase();
    weatherDetailBloc = WeatherDetailBloc(mockWeatherDetailUseCase);
  });

  group('FetchWeekForecast', () {
    final successResponse = WeatherDetailResponseDm(
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

    const errorResponse = BadRequestException();

    blocTest<WeatherDetailBloc, WeatherDetailState>(
      'emits [WeatherDetailWeekLoading, WeatherDetailWeekSuccess] '
      'when FetchWeekForecast is added and WeatherDetailUseCase call '
      'succeeds.',
      build: () {
        when(weatherDetailBloc.useCase.call(any))
            .thenAnswer((_) async => Success(successResponse));
        return weatherDetailBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchWeekForecast(
            WeatherDetailRequestDm(
              longitude: '24',
              latitude: '54',
              count: '2',
            ),
          ),
        );
      },
      expect: () => [
        const WeatherDetailWeekLoading(),
        WeatherDetailWeekSuccess(successResponse),
      ],
    );

    blocTest<WeatherDetailBloc, WeatherDetailState>(
      'emits [WeatherDetailWeekLoading, WeatherDetailWeekFailure] '
      'when FetchWeekForecast is added and WeatherDetailUseCase call '
      'fails.',
      build: () {
        when(weatherDetailBloc.useCase.call(any)).thenAnswer(
          (_) async => const Failure(errorResponse),
        );
        return weatherDetailBloc;
      },
      act: (bloc) {
        bloc.add(
          const FetchWeekForecast(
            WeatherDetailRequestDm(
              longitude: 'ab',
              latitude: '54',
              count: '2',
            ),
          ),
        );
      },
      expect: () => const [
        WeatherDetailWeekLoading(),
        WeatherDetailWeekFailure(errorResponse),
      ],
    );
  });
}
