import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/utils/scaffold_message.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';
import 'package:marco/shared/widgets/custom_form_field.dart';
import 'package:marco/features/auth/presentation/widgets/home_area.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(
    text: '+30',
  );
  String _neighborhood = '';
  bool isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up', style: AppTextStyles.title),
            const Text(
              'Step 1 of 3: Create Your Account',
              style: AppTextStyles.headline1,
            ),
          ],
        ),
      ),
      body: Center(
        child: authState.isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomFormField(
                          controller: _nameController,
                          label: 'Name',
                          icon: Icons.person,
                          validator: _validateName,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          controller: _emailController,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                          validator: _validateEmail,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          controller: _passwordController,
                          isPassword: true,
                          label: 'Password',
                          keyboardType: TextInputType.text,
                          icon: Icons.lock,
                          suffixIcon: Icons.visibility_off,
                          validator: _validatePassword,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          controller: _confirmPasswordController,
                          isPassword: true,
                          label: 'Confirm Password',
                          keyboardType: TextInputType.text,
                          icon: Icons.lock,
                          suffixIcon: Icons.visibility_off,
                          validator: _validateConfirmPassword,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomFormField(
                                label: '',
                                controller: _countryCodeController,
                                keyboardType: TextInputType.number,
                                icon: Icons.phone,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                validator: _validateCountryCode,
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 2,
                              child: CustomFormField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                keyboardType: TextInputType.phone,
                                validator: _validatePhoneNumber,
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        HomeAreaDropdown(
                          onAreaSelected: (area) {
                            setState(() => _neighborhood = area);
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              side: BorderSide(width: 1),
                              value: isTermsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  isTermsAccepted = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'I confirm I am the legal guardian and agree to the ',
                                  style: AppTextStyles.body,
                                  children: [
                                    TextSpan(
                                      text: 'Terms',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColorsLight.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Handle terms and conditions tap
                                        },
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColorsLight.primary,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // Handle privacy policy tap
                                        },
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            backgroundColor: _canEnableButton()
                                ? AppColorsLight.primary
                                : AppColorsLight.primary.withAlpha(50),
                            onPressed: () {
                              final isFormValid =
                                  _formKey.currentState?.validate() == true;

                              if (!isFormValid) return;

                              if (!isTermsAccepted) {
                                showScaffoldMessage(
                                  context,
                                  'You must accept the terms and conditions',
                                );
                                return;
                              }

                              if (_neighborhood.isEmpty) {
                                showScaffoldMessage(
                                  context,
                                  'Please select a neighborhood',
                                );
                                return;
                              }

                              _submit();
                            },
                            text: 'Send Verification Code',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            CustomTextButton(
                              onPressed: () {
                                // Navigate to login screen
                              },
                              text: 'Log In',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  bool _isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  bool _doPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool _isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phone);
  }

  bool _isValidCountryCode(String code) {
    final countryCodeRegex = RegExp(r'^\+\d{1,3}$');
    return countryCodeRegex.hasMatch(code);
  }

  String? _validateName(String? value) {
    if (!_isValidName(value ?? '')) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (!_isValidEmail(value ?? '')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (!_isValidPassword(value ?? '')) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (!_doPasswordsMatch(_passwordController.text, value ?? '')) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (!_isValidPhoneNumber(value ?? '')) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateCountryCode(String? value) {
    if (!_isValidCountryCode(value ?? '')) {
      return 'Please enter a valid country code (e.g., +30)';
    }
    return null;
  }

  bool _canEnableButton() {
    return _isValidName(_nameController.text) &&
        _isValidEmail(_emailController.text) &&
        _isValidPassword(_passwordController.text) &&
        _doPasswordsMatch(
          _passwordController.text,
          _confirmPasswordController.text,
        ) &&
        _isValidPhoneNumber(_phoneController.text) &&
        _isValidCountryCode(_countryCodeController.text) &&
        isTermsAccepted &&
        _neighborhood.isNotEmpty;
  }

  void _submit() {
    try {
      context.pushNamed(
        'otp',
        queryParameters: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'phone': '${_countryCodeController.text}${_phoneController.text}',
          'neighborhood': _neighborhood,
        },
      );
    } catch (e) {
      showScaffoldMessage(context, 'An unexpected error occurred: $e');
    }
  }
}
