import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marco/core/constants/app_colors.dart';

class EnterOtp extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final List<FocusNode> otpFocusNodes;
  final Function(String, int) onChangedOtp;

  const EnterOtp({
    super.key,
    required this.otpControllers,
    required this.otpFocusNodes,
    required this.onChangedOtp,
  });

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 50,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: TextField(
          controller: otpControllers[index],
          focusNode: otpFocusNodes[index],
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColorsLight.primary, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          onChanged: (value) => onChangedOtp(value, index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) => _buildOtpBox(index)),
        ),
      ],
    );
  }
}
