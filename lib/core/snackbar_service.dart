import 'package:flutter/material.dart';
import 'package:weather_app/core/app_colors.dart';

class SnackbarService {
  const SnackbarService._();

  static final GlobalKey<ScaffoldMessengerState> _key =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get key => _key;

  static ScaffoldMessengerState? showSnack(
    String message, {
    TextStyle? textStyle,
  }) {
    return _key.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          content: Text(
            message,
            style: const TextStyle(color: AppColors.color101010),
          ),
        ),
      );
  }
}
