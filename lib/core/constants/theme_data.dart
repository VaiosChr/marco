import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColorsLight.primary),
  primaryColor: AppColorsLight.primary,
  scaffoldBackgroundColor: AppColorsLight.scaffoldBackground,
  canvasColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColorsDark.primary,
    brightness: Brightness.dark,
  ),
  primaryColor: AppColorsDark.primary,
  scaffoldBackgroundColor: AppColorsDark.scaffoldBackground,
  canvasColor: Colors.black,
  appBarTheme: AppBarTheme(backgroundColor: Colors.black),
);


// ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff3cb77e)),
//         primaryColor: Color(0xff3cb77e),
//         scaffoldBackgroundColor: Color(0xfff6f8fa),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xfff6f8fa),
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.black),
//         ),
//       );