import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle headline1 = TextStyle(
    fontSize: 16,
    color: AppColorsLight.textSecondary,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.8,
  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    color: AppColorsLight.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle bodyHint = TextStyle(
    color: AppColorsLight.textTetriary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle onButton = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle textButton = TextStyle(
    color: AppColorsLight.primary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    color: AppColorsLight.textTetriary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
