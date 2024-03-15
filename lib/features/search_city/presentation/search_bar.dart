import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_app/core/app_colors.dart';
import 'package:weather_app/core/app_strings.dart';
import 'package:weather_app/core/extensions.dart';
import 'package:weather_app/core/result_state_template.dart';
import 'package:weather_app/features/current_weather/data/models/current_weather_request_dm.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart';
import 'package:weather_app/features/search_city/presentation/bloc/search_city_bloc.dart';
import 'package:weather_app/service_locator.dart';

import 'package:weather_app/features/search_city/data/models/search_city_response_dm.dart';

class SearchBarWithSuggestions extends StatefulWidget {
  const SearchBarWithSuggestions({super.key});

  @override
  State<SearchBarWithSuggestions> createState() =>
      _SearchBarWithSuggestionsState();
}

class _SearchBarWithSuggestionsState extends State<SearchBarWithSuggestions> {
  TextEditingController searchController = TextEditingController();
  late final bloc = getIt<SearchCityBloc>();
  late final currentWeatherBloc = getIt<CurrentWeatherBloc>();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Result>(
      debounceDuration: const Duration(milliseconds: 300),
      builder: (context, controller, focusNode) {
        searchController = controller;
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 51),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: const TextStyle(
                color: AppColors.colorffffff,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: AppStrings.city,
                hintStyle: TextStyle(color: AppColors.colorffffff),
              ),
            ),
          ),
        );
      },
      hideOnEmpty: true,
      itemBuilder: (context, value) => ListTile(
        title: Text(value.name ?? '-'),
        onTap: () {
          currentWeatherBloc.add(
            FetchCurrentWeatherData(
              CurrentWeatherRequestDm(
                name: value.name,
                longitude: value.longitude.toString(),
                latitude: value.latitude.toString(),
              ),
            ),
          );
          searchController.clear();
          context.hideKeyboard();
        },
      ),
      suggestionsCallback: (search) async {
        final state = await bloc.useCase
            .call(SearchCityRequestDm(name: search, count: '10'));
        if (state is Success) {
          return (state.value as SearchCityResponseDm).results;
        } else {
          return List<Result>.empty();
        }
      },
      onSelected: (Result? value) {},
    );
  }
}
