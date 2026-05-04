import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onPrefixPressed;
  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomFormField({
    super.key,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.onPrefixPressed,
    this.label = 'Phone Number',
    this.keyboardType = TextInputType.text,
    this.icon,
    this.suffixIcon,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.validator != null
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: AppTextStyles.body,
      controller: widget.controller,
      obscureText: isPasswordVisible,
      decoration: InputDecoration(
        floatingLabelBehavior: widget.floatingLabelBehavior,
        fillColor: Colors.white,
        filled: true,
        labelStyle: AppTextStyles.bodyHint,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.icon != null
            ? IconButton(
                iconSize: 18,
                onPressed: widget.onPrefixPressed,
                icon: Icon(
                  widget.icon,
                  color: AppColorsLight.textSecondary,
                  size: 18,
                ),
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                iconSize: 18,
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
                icon: Icon(
                  isPasswordVisible ? widget.suffixIcon : Icons.visibility,
                  color: AppColorsLight.textTetriary,
                  size: 18,
                ),
              )
            : null,
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
