import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/db_constants.dart';
import 'package:weather_app/core/db_helper.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/current_weather/domain/repositories/current_weather_repo.dart';

class CurrentWeatherRepoImpl implements CurrentWeatherRepo {
  const CurrentWeatherRepoImpl({
    required this.apiHelper,
    required this.weatherDb,
    required this.timeDb,
  });

  final APIHelper apiHelper;
  final DbHelper<CurrentWeatherResponseDm> weatherDb;
  final DbHelper<DateTime> timeDb;

  @override
  Future<ResultState> getCurrentWeather(
    CurrentWeatherRequestDm requestDm,
  ) async {
    try {
      final response = await apiHelper.get(
        ApiRoutes.weather,
        queryParameters: requestDm.toJson(),
      );

      final result = CurrentWeatherResponseDm.fromJson(response);
      if (result.weather?.isEmpty ?? true) {
        throw const NotFoundException();
      }
      return Success(result);
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }

  @override
  Future<ResultState> getCurrentWeatherFromLocal() async {
    try {
      final response = await weatherDb.read(key: DbConstants.currentWeatherKey);
      if (response == null) throw const NotFoundException();
      return Success(response);
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }

  @override
  Future<ResultState> setCurrentWeatherInLocal(
    CurrentWeatherResponseDm responseDm,
  ) async {
    try {
      await weatherDb.write(
        key: DbConstants.currentWeatherKey,
        data: responseDm,
      );
      return const Success(null);
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }

  @override
  Future<ResultState> getLastUpdateTime() async {
    try {
      final response = await timeDb.read(key: DbConstants.lastUpdateTime);
      if (response == null) throw const NotFoundException();
      return Success(response);
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }

  @override
  Future<ResultState> setLastUpdateTime(DateTime time) async {
    try {
      await timeDb.write(key: DbConstants.lastUpdateTime, data: time);
      return const Success(null);
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }
}
