import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/app_colors.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:weather_app/service_locator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.background,
  });

  final String background;

  @override
  Widget build(BuildContext context) {
    final bloc = getIt<SettingsBloc>();
    const textStyleMain =
        TextStyle(color: Colors.white, fontSize: 20, height: 1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: bloc,
          builder: (context, state) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(background),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Setting',
                              style: textStyleMain,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.colorffffff.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Temperature unit',
                                      style: textStyleMain,
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () => bloc
                                        .add(ChangeSettings(unit: state.unit)),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: AppColors.colorffffff),
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.unit.name,
                                          style: textStyleMain.copyWith(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flexible(
                                    child: Text(
                                      'Update Frequency',
                                      style: textStyleMain,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      bloc.add(ChangeSettings(
                                          frequency: state.frequency));
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: AppColors.colorffffff),
                                      ),
                                      child: Text(
                                        '${state.frequency.minutes} mins',
                                        style: textStyleMain.copyWith(
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
