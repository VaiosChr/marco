import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffixPressed;
  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomFormField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.onPrefixPressed,
    this.label = 'Phone Number',
    this.keyboardType = TextInputType.text,
    this.icon,
    this.suffixIcon,
    this.onSuffixPressed,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.body,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: Colors.white,
        filled: true,
        labelStyle: AppTextStyles.bodyHint,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: icon != null
            ? IconButton(
                iconSize: 18,
                onPressed: onPrefixPressed,
                icon: Icon(icon, color: AppColorsLight.textSecondary, size: 18),
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                iconSize: 18,
                onPressed: onSuffixPressed,
                icon: Icon(
                  suffixIcon,
                  color: AppColorsLight.textTetriary,
                  size: 18,
                ),
              )
            : null,
      ),
      keyboardType: keyboardType,
    );
  }
}
