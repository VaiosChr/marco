import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColorsLight.primary,
  scaffoldBackgroundColor: AppColorsLight.scaffoldBackground,
  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColorsDark.primary,
  scaffoldBackgroundColor: AppColorsDark.scaffoldBackground,
  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
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