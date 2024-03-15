import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ContextExtension on BuildContext {
  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    if (!currentFocus.hasPrimaryFocus) {
      FocusScope.of(this).requestFocus(FocusNode());
    }
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  Size screenSizeFraction(double fraction) {
    final size = MediaQuery.sizeOf(this);
    return Size(size.width * fraction, size.height * fraction);
  }

  double screenWidthFraction(double fraction) =>
      MediaQuery.sizeOf(this).width * fraction;

  double screenHeightFraction(double fraction) =>
      MediaQuery.sizeOf(this).height * fraction;
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
