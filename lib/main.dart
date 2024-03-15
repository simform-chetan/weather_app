import 'package:flutter/material.dart';
import 'package:weather_app/core/app_theme.dart';
import 'package:weather_app/core/db_helper.dart';
import 'package:weather_app/core/extensions.dart';
import 'package:weather_app/core/snackbar_service.dart';
import 'package:weather_app/features/current_weather/presentation/home_page.dart';
import 'package:weather_app/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initialize();
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: MaterialApp(
        title: 'Weather App',
        theme: AppTheme.lightTheme,
        scaffoldMessengerKey: SnackbarService.key,
        home: const HomePage(),
      ),
    );
  }
}
