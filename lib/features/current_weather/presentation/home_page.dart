import 'dart:async';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app_colors.dart';
import 'package:weather_app/core/app_constants.dart';
import 'package:weather_app/core/app_strings.dart';
import 'package:weather_app/core/db_constants.dart';
import 'package:weather_app/core/extensions.dart';
import 'package:weather_app/core/helper.dart';
import 'package:weather_app/core/snackbar_service.dart';
import 'package:weather_app/core/widgets/weather_view.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weather_app/features/search_city/presentation/search_bar.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/features/settings/presentation/settings_page.dart';
import 'package:weather_app/features/weather_detail/detail_page.dart';
import 'package:weather_app/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final bloc = getIt<CurrentWeatherBloc>();
  late final settingsBloc = getIt<SettingsBloc>();
  CancelableOperation? getLocationOperation;

  @override
  void initState() {
    bloc.add(const LoadLocalWeatherData());
    _fetchCurrentLocationWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<CurrentWeatherBloc, CurrentWeatherState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is CurrentWeatherFailure) {
            SnackbarService.showSnack(
              state.error.prefix ?? AppStrings.somethingWentWrong,
            );
            bloc.add(const LoadLocalWeatherData());
          } else if (state is LocalWeatherFailure) {
            bloc.add(
              FetchCurrentWeatherData(
                CurrentWeatherRequestDm(
                  longitude: AppConstants.defaultLongitude.toString(),
                  latitude: AppConstants.defaultLatitude.toString(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final icon = state is CurrentWeatherSuccess
              ? state.weather.weather?.firstOrNull?.icon ?? '01d'
              : '01d';
          final background = 'assets/images/$icon.jpeg';
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(icon),
                  height: context.screenHeight,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(background),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: context.screenHeight,
                  width: context.screenWidth,
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                context.hideKeyboard();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    maintainState: true,
                                    builder: (context) => SettingsPage(
                                      background: background,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 28,
                                color: AppColors.colorffffff,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16, left: 16),
                          child: SearchBarWithSuggestions(),
                        ),
                        const Spacer(),
                        if (state is CurrentWeatherLoading)
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: CupertinoActivityIndicator(),
                          )
                        else
                          WeatherView(
                            data: state is CurrentWeatherSuccess
                                ? state.weather
                                : null,
                          ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (state is CurrentWeatherSuccess) {
                              context.hideKeyboard();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  maintainState: true,
                                  builder: (context) => DetailPage(
                                    currentWeather: state.weather,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 52,
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColors.colorffffff,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: FittedBox(
                                          child: Text(
                                            'See More Forecast',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _fetchCurrentLocationWeather() async {
    await getLocationOperation?.cancel();
    getLocationOperation = CancelableOperation.fromFuture(getCurrentLocation());
    getLocationOperation?.then((value) async {
      final time =
          await DbConstants.timeStorage.read(key: DbConstants.lastUpdateTime);
      if (time is DateTime &&
          DateTime.now().difference(time).inMinutes <
              settingsBloc.state.frequency.minutes) return;
      DbConstants.timeStorage.write(
        key: DbConstants.lastUpdateTime,
        data: DateTime.now(),
      );
      bloc.add(
        FetchCurrentWeatherData(
          CurrentWeatherRequestDm(
            longitude:
                (value?.longitude ?? AppConstants.defaultLongitude).toString(),
            latitude:
                (value?.latitude ?? AppConstants.defaultLatitude).toString(),
          ),
        ),
      );
    });
  }
}
