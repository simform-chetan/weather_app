import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app_colors.dart';
import 'package:weather_app/core/app_strings.dart';
import 'package:weather_app/core/widgets/weather_view.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_response_dm.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/features/weather_detail/data/models/weather_detail_request_dm.dart';
import 'package:weather_app/features/weather_detail/presentation/bloc/weather_detail_bloc.dart';
import 'package:weather_app/service_locator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.currentWeather,
  });

  final CurrentWeatherResponseDm currentWeather;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final bloc = getIt<WeatherDetailBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(
      FetchWeekForecast(
        WeatherDetailRequestDm(
          latitude: widget.currentWeather.coord?.lat.toString() ?? '24.466667',
          longitude: widget.currentWeather.coord?.lon.toString() ?? '54.366669',
          count: '8',
        ),
      ),
    );
  }

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    String x = DateFormat.E().format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<WeatherDetailBloc, WeatherDetailState>(
          bloc: bloc,
          builder: (context, state) {
            final background =
                'assets/images/${widget.currentWeather.weather?.firstOrNull?.icon ?? '01d'}.jpeg';
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SafeArea(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: AppColors.colorffffff,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    WeatherView(data: widget.currentWeather),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 415,
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                child: Container(
                                  height: 415,
                                  padding: const EdgeInsets.all(5),
                                  color: AppColors.colorffffff.withOpacity(0.1),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.calendar,
                                              size: 18,
                                              color: Colors.white54,
                                            ),
                                            Text(
                                              ' 8-DAY FORECAST',
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.white54,
                                      ),
                                      Flexible(
                                        child: BlocBuilder<WeatherDetailBloc,
                                            WeatherDetailState>(
                                          bloc: bloc,
                                          builder: (context, state) {
                                            if (state
                                                is WeatherDetailWeekLoading) {
                                              return Center(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: AppColors.colorffffff
                                                        .withOpacity(0.5),
                                                  ),
                                                  child:
                                                      const CupertinoActivityIndicator(),
                                                ),
                                              );
                                            } else if (state
                                                is WeatherDetailWeekSuccess) {
                                              final itemCount =
                                                  (state.detail.list?.length ??
                                                              0) >
                                                          10
                                                      ? 10
                                                      : (state.detail.list
                                                              ?.length ??
                                                          0);
                                              return ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                itemCount: itemCount,
                                                itemBuilder: (context, index) {
                                                  final currentItem =
                                                      state.detail.list?[index];
                                                  final day =
                                                      getDay(currentItem?.dt);
                                                  final icon =
                                                      "assets/icons/${currentItem?.weather?[0].icon}.png";
                                                  final temperatureMax =
                                                      currentItem
                                                              ?.temp?.max
                                                              ?.toStringAsFixed(
                                                                  0) ??
                                                          '-';
                                                  final temperatureMin =
                                                      currentItem
                                                              ?.temp?.min
                                                              ?.toStringAsFixed(
                                                                  0) ??
                                                          '-';
                                                  return BlocBuilder<
                                                      SettingsBloc,
                                                      SettingsState>(
                                                    bloc: getIt<SettingsBloc>(),
                                                    builder:
                                                        (context, settings) {
                                                      var processedTempMax =
                                                          temperatureMax;
                                                      var processedTempMin =
                                                          temperatureMin;
                                                      if (settings
                                                          is SettingsUpdate) {
                                                        final parsedTempMax =
                                                            double.tryParse(
                                                                temperatureMax);
                                                        final parsedTempMin =
                                                            double.tryParse(
                                                                temperatureMin);
                                                        processedTempMax =
                                                            parsedTempMax == null
                                                                ? temperatureMax
                                                                : settings.unit
                                                                    .fromKelvin(
                                                                        parsedTempMax)
                                                                    .toStringAsFixed(
                                                                        0);
                                                        processedTempMin =
                                                            parsedTempMin == null
                                                                ? temperatureMin
                                                                : settings.unit
                                                                    .fromKelvin(
                                                                        parsedTempMin)
                                                                    .toStringAsFixed(
                                                                        0);
                                                      }
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        8),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: 80,
                                                                  child: Text(
                                                                    day,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Image(
                                                                  image:
                                                                      AssetImage(
                                                                          icon),
                                                                  height: 30,
                                                                  width: 33,
                                                                ),
                                                                Text(
                                                                  '$processedTempMax'
                                                                  '\u00B0 / '
                                                                  '$processedTempMin'
                                                                  '\u00B0',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    child: Divider(
                                                      height: 0,
                                                      color: Colors.white54,
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (state
                                                is WeatherDetailWeekFailure) {
                                              return Center(
                                                child: Text(
                                                  state.error.prefix ??
                                                      AppStrings
                                                          .somethingWentWrong,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.colorffffff,
                                                  ),
                                                ),
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
