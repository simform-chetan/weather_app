import 'package:get_it/get_it.dart';
import 'package:weather_app/core/api_constants.dart';
import 'package:weather_app/core/db_constants.dart';
import 'package:weather_app/features/current_weather/data/repositories/current_weather_repo_impl.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';
import 'package:weather_app/features/current_weather/domain/usecase/current_weather_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/get_current_weather_local_usecase.dart';
import 'package:weather_app/features/current_weather/domain/usecase/set_current_weather_local_usecase.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weather_app/features/search_city/data/repositories/search_city_repo_impl.dart';
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart';
import 'package:weather_app/features/search_city/domain/usecase/search_city_usecase.dart';
import 'package:weather_app/features/search_city/presentation/bloc/search_city_bloc.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/features/weather_detail/data/repositories/weather_detail_repo_impl.dart';
import 'package:weather_app/features/weather_detail/domain/repositories/weather_detail_repo.dart';
import 'package:weather_app/features/weather_detail/domain/usecase/weather_detail_usecase.dart';
import 'package:weather_app/features/weather_detail/presentation/bloc/weather_detail_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await DbConstants.weatherStorage.initializeBox();
  await DbConstants.timeStorage.initializeBox();

  // Repositories
  getIt.registerLazySingleton<CurrentWeatherRepo>(
    () => CurrentWeatherRepoImpl(
      apiHelper: ApiConstants.client,
      weatherDb: DbConstants.weatherStorage,
      timeDb: DbConstants.timeStorage,
    ),
  );

  getIt.registerLazySingleton<WeatherDetailRepo>(
    () => const WeatherDetailRepoImpl(
      apiHelper: ApiConstants.client,
    ),
  );

  getIt.registerLazySingleton<SearchCityRepo>(
    () => const SearchCityRepoImpl(
      apiHelper: ApiConstants.geoCodingClient,
    ),
  );

  // Use cases
  getIt.registerLazySingleton<CurrentWeatherUseCase>(
    () => CurrentWeatherUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetCurrentWeatherLocalUseCase>(
    () => GetCurrentWeatherLocalUseCase(getIt()),
  );

  getIt.registerLazySingleton<SetCurrentWeatherLocalUseCase>(
    () => SetCurrentWeatherLocalUseCase(getIt()),
  );

  getIt.registerLazySingleton<WeatherDetailUseCase>(
    () => WeatherDetailUseCase(getIt()),
  );

  getIt.registerLazySingleton<SearchCityUseCase>(
    () => SearchCityUseCase(getIt()),
  );

  // Blocs
  getIt.registerLazySingleton<CurrentWeatherBloc>(
    () => CurrentWeatherBloc(
      weatherUseCase: getIt(),
      localGetUseCase: getIt(),
      localSetUseCase: getIt(),
    ),
  );

  getIt.registerLazySingleton<WeatherDetailBloc>(
    () => WeatherDetailBloc(getIt()),
  );

  getIt.registerLazySingleton<SearchCityBloc>(
    () => SearchCityBloc(getIt()),
  );

  getIt.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
}
