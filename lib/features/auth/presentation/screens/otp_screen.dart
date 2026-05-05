import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/utils/scaffold_message.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';
import 'package:marco/features/auth/presentation/widgets/enter_otp.dart';
import 'package:marco/features/auth/presentation/widgets/phone_info.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String neighborhood;

  const OtpScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.neighborhood,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  bool _canResend = false;
  int _resendCountdown = 30;
  Timer? _resendTimer;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  Widget _resendButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          if (_canResend) {
            _startResendTimer();
          } else {
            showScaffoldMessage(
              context,
              'Please wait $_resendCountdown seconds before resending OTP.',
            );
          }
        },
        child: Text(
          _canResend ? 'Resend OTP' : 'Resend OTP ($_resendCountdown)',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: _canResend
                ? AppColorsLight.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }

  Widget _verifyButton() {
    bool isOtpComplete = _otpControllers.every(
      (controller) => controller.text.isNotEmpty,
    );

    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        backgroundColor: isOtpComplete
            ? AppColorsLight.primary
            : AppColorsLight.primary.withAlpha(50),
        onPressed: isOtpComplete
            ? () async {
                String otp = _otpControllers.map((c) => c.text).join();

                final isValid = ref
                    .read(authProvider.notifier)
                    .verifyOtp(phone: widget.phoneNumber, code: otp);

                if (!isValid && mounted) {
                  showScaffoldMessage(
                    context,
                    'Invalid OTP. Please try again.',
                  );
                  return;
                }

                _submit();
              }
            : () {
                showScaffoldMessage(
                  context,
                  'Please enter the complete 6-digit OTP.',
                );
              },
        text: 'Verify & Continue',
      ),
    );
  }

  void _onChangedOtp(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up', style: AppTextStyles.title),
            const Text(
              'Step 2 of 3 - Verify Your Phone',
              style: AppTextStyles.headline1,
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Enter the 6-digit code sent to:\n${widget.phoneNumber}',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 16),
              EnterOtp(
                otpControllers: _otpControllers,
                otpFocusNodes: _otpFocusNodes,
                onChangedOtp: _onChangedOtp,
              ),
              const SizedBox(height: 12),
              _resendButton(),
              const SizedBox(height: 12),
              const PhoneInfo(),
              const Spacer(),
              _verifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    try {
      await ref
          .read(authProvider.notifier)
          .signUp(
            name: widget.name,
            email: widget.email,
            password: widget.password,
            phone: widget.phoneNumber,
            neighborhood: widget.neighborhood,
          );

      if (!mounted) return;

      final authState = ref.read(authProvider);

      if (authState.error != null) {
        showScaffoldMessage(context, authState.error!);
        return;
      }

      context.pushNamed('addChild');
    } catch (e) {
      showScaffoldMessage(context, 'An error occurred: $e');
    }
  }
}
