import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';
import 'package:marco/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:marco/features/auth/presentation/widgets/home_area.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';

class SignupScreen extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(
    text: '+30',
  );

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign Up', style: AppTextStyles.title)),
      ),
      body: Center(
        child: authState.isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomFormField(
                        controller: _nameController,
                        label: 'Name',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        controller: _passwordController,
                        isPassword: true,
                        label: 'Password',
                        keyboardType: TextInputType.text,
                        icon: Icons.lock,
                        suffixIcon: Icons.visibility_off,
                        onSuffixPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      CustomFormField(
                        controller: _confirmPasswordController,
                        isPassword: true,
                        label: 'Confirm Password',
                        keyboardType: TextInputType.text,
                        icon: Icons.lock,
                        suffixIcon: Icons.visibility_off,
                        onSuffixPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomFormField(
                              controller: _countryCodeController,
                              keyboardType: TextInputType.number,
                              icon: Icons.phone,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: CustomFormField(
                              controller: _phoneController,
                              label: 'Phone Number',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      HomeAreaDropdown(onAreaSelected: (area) {}),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
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
                          onPressed: () {
                            // Handle sign up logic
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
    );
  }
}
