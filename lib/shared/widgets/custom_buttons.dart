import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColorsLight.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: AppTextStyles.onButton),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: AppTextStyles.textButton),
    );
  }
}
