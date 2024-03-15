import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';

import 'package:weather_app/core/db_constants.dart';

class DbHelper<T> {
  DbHelper(this.name);

  Future<void> initializeBox() async {
    database = await Hive.openBox<T>(name);
  }

  static Future<void> initialize() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    var dbLocation = '${appDocDirectory.path}/${DbConstants.weatherName}';
    Hive
      ..init(dbLocation)
      ..registerAdapter(CurrentWeatherResponseDmAdapter())
      ..registerAdapter(CoordAdapter())
      ..registerAdapter(WeatherAdapter())
      ..registerAdapter(MainAdapter());
  }

  final String name;
  late final Box<T> database;

  Future<void> write({required String key, required T data}) async =>
      database.put(key, data);

  Future<dynamic> read({required String key, T? defaultData}) async =>
      database.get(key, defaultValue: defaultData);

  Future<void> delete({required String key}) async => database.delete(key);

  Future<void> reset() async => database.clear();

  Future<void> dispose() async => database.close();
}
