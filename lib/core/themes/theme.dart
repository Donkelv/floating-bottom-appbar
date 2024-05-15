import 'package:flutter/material.dart';
import 'package:moniepoint/core/themes/text_theme.dart';

class CustomTheme {
  static ThemeData getLightThemeData(BuildContext context) {
    return _lightThemeData(context);
  }

  static ThemeData getDarkThemeData(BuildContext context) {
    return _darkThemeData(context);
  }

  static ThemeData _lightThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'Euclid Circular A',
      textTheme: AppTextTheme.darkTextTheme,
    );
  }

  static ThemeData _darkThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: 'Euclid Circular A',
      textTheme: AppTextTheme.darkTextTheme,
    );
  }
}
