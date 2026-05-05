import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marco/core/constants/app_colors.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/core/utils/scaffold_message.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';
import 'package:marco/features/child/presentation/providers/child_provider.dart';
import 'package:marco/features/child/presentation/widgets/add_another_child.dart';
import 'package:marco/features/child/presentation/widgets/invite_coparent.dart';
import 'package:marco/features/child/presentation/widgets/parental_consent.dart';
import 'package:marco/shared/widgets/custom_buttons.dart';
import 'package:marco/shared/widgets/custom_form_field.dart';

class AddChildScreen extends ConsumerStatefulWidget {
  final String? childId;
  const AddChildScreen({super.key, this.childId});

  @override
  ConsumerState<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends ConsumerState<AddChildScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(
    text: '+30',
  );
  ConsentModel _consentModel = ConsentModel();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _schoolController.dispose();
    _phoneController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final childState = ref.watch(childProvider);
    final authState = ref.watch(authProvider);
    final isLoading = childState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.childId == null ? 'Add Child' : 'Edit Child',
              style: AppTextStyles.title,
            ),
            Text(
              widget.childId == null
                  ? 'Step 3 of 3 - Set Up Child Profile'
                  : 'Update Child Profile',
              style: AppTextStyles.headline1,
            ),
          ],
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          controller: _nameController,
                          label: 'Child\'s Name',
                          keyboardType: TextInputType.text,
                          icon: Icons.person,
                          validator: _validateName,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          label: 'Age',
                          icon: Icons.cake,
                          validator: _validateAge,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16),
                        CustomFormField(
                          controller: _schoolController,
                          label: 'School',
                          keyboardType: TextInputType.text,
                          icon: Icons.school,
                          validator: _validateSchool,
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
                        const SizedBox(height: 5),
                        const Text(
                          'An invitation to install the kid app will be sent here',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        ParentalConsent(
                          consent: _consentModel,
                          onConsentChanged: (newConsent) {
                            setState(() => _consentModel = newConsent);
                          },
                        ),
                        const SizedBox(height: 16),
                        const InviteCoparent(),
                        const SizedBox(height: 16),
                        const AddAnotherChild(),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            backgroundColor: _canEnableButton()
                                ? AppColorsLight.primary
                                : AppColorsLight.primary.withAlpha(50),
                            onPressed: _canEnableButton()
                                ? () async => _submit(authState)
                                : () {
                                    showScaffoldMessage(
                                      context,
                                      'Please complete the form and consents.',
                                    );
                                  },
                            text: widget.childId == null
                                ? 'Finish Setup'
                                : 'Save Changes',
                          ),
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

  bool _isValidAge(String age) {
    final parsedAge = int.tryParse(age);
    return parsedAge != null && parsedAge > 0 && parsedAge <= 18;
  }

  bool _isValidSchool(String school) {
    return school.trim().isNotEmpty;
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

  String? _validateAge(String? value) {
    if (!_isValidAge(value ?? '')) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? _validateSchool(String? value) {
    if (!_isValidSchool(value ?? '')) {
      return 'Please enter a valid school';
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
        _isValidAge(_ageController.text) &&
        _isValidSchool(_schoolController.text) &&
        _isValidPhoneNumber(_phoneController.text) &&
        _isValidCountryCode(_countryCodeController.text) &&
        _consentModel.processingRoutes &&
        _consentModel.aiSuggestions;
  }

  Future<void> _submit(AuthState authState) async {
    final isFormValid = _formKey.currentState?.validate() == true;
    if (!isFormValid) return;

    if (!_consentModel.processingRoutes || !_consentModel.aiSuggestions) {
      showScaffoldMessage(
        context,
        'Please accept the required consent options.',
      );
      return;
    }

    if (authState.parent == null) {
      showScaffoldMessage(
        context,
        'Your session expired. Please sign in again.',
      );
      return;
    }

    final child = await ref
        .read(childProvider.notifier)
        .createChild(
          parentId: authState.parent!.id,
          name: _nameController.text.trim(),
          age: int.parse(_ageController.text),
          school: _schoolController.text.trim(),
          phone: '${_countryCodeController.text}${_phoneController.text}',
          consents: _consentModel,
        );

    if (!mounted) return;

    if (child == null) {
      showScaffoldMessage(
        context,
        'Error: ${ref.read(childProvider).error ?? 'Unable to create child.'}',
      );
      return;
    }

    context.pushReplacementNamed('rewards');
  }
}
