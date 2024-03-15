import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/extensions.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/service_locator.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    super.key,
    required this.data,
  });

  final CurrentWeatherResponseDm? data;

  @override
  Widget build(BuildContext context) {
    final icon = data?.weather?.firstOrNull?.icon ?? '01d';
    final backgroundIcon = 'assets/icons/$icon.png';
    final city = data?.name ?? '-';

    final description = data?.weather?.firstOrNull?.description ?? '-';
    var temperature = data?.main?.temp?.toStringAsFixed(0) ?? '-';
    var temperatureMax = data?.main?.tempMax?.toStringAsFixed(0) ?? '-';
    var temperatureMin = data?.main?.tempMin?.toStringAsFixed(0) ?? '-';
    return BlocBuilder(
      bloc: getIt<SettingsBloc>(),
      builder: (BuildContext context, state) {
        var processedTemp = temperature;
        var processedTempMax = temperatureMax;
        var processedTempMin = temperatureMin;
        if (state is SettingsUpdate) {
          final parsedTemp = double.tryParse(temperature);
          final parsedTempMax = double.tryParse(temperatureMax);
          final parsedTempMin = double.tryParse(temperatureMin);
          processedTemp = parsedTemp == null
              ? temperature
              : state.unit.fromKelvin(parsedTemp).toStringAsFixed(0);
          processedTempMax = parsedTempMax == null
              ? temperatureMax
              : state.unit.fromKelvin(parsedTempMax).toStringAsFixed(0);
          processedTempMin = parsedTempMin == null
              ? temperatureMin
              : state.unit.fromKelvin(parsedTempMin).toStringAsFixed(0);
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(backgroundIcon),
                fit: BoxFit.none,
              ),
              Text(
                city,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                '$processedTemp\u00B0 | ${description.toTitleCase()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              Text(
                'H:$processedTempMax\u00B0  L:$processedTempMin\u00B0',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
