import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_response_dm.dart';
import 'package:weather_app/features/weather_detail/domain/repositories/weather_detail_repo.dart';

class WeatherDetailRepoImpl implements WeatherDetailRepo {
  const WeatherDetailRepoImpl({required this.apiHelper});

  final APIHelper apiHelper;

  @override
  Future<ResultState> getWeatherDetail(WeatherDetailRequestDm requestDm) async {
    try {
      final response = await apiHelper.get(
        ApiRoutes.forecastDaily,
        queryParameters: requestDm.toJson(),
      );

      final parsed = WeatherDetailResponseDm.fromJson(response);
      if (parsed.list?.isEmpty ?? true) {
        throw const NotFoundException();
      } else {
        return Success(parsed);
      }
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }
}
