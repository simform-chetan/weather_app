 import 'package:weather_app/core/api_helper.dart';
import 'package:weather_app/core/api_routes.dart';
import 'package:weather_app/core/network_exception.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart';

class SearchCityRepoImpl implements SearchCityRepo {
  const SearchCityRepoImpl({required this.apiHelper});

  final APIHelper apiHelper;

  @override
  Future<ResultState> searchCity(SearchCityRequestDm requestDm) async {
    try {
      final response = await apiHelper.get(
        ApiRoutes.search,
        queryParameters: requestDm.toJson(),
      );
      return Success(SearchCityResponseDm.fromJson(response));
    } catch (e) {
      return Failure(e is NetworkException ? e : const FetchDataException());
    }
  }
}
