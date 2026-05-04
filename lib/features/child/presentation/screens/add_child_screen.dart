import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/child/domain/models/consent_model.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController(
    text: '+30',
  );
  final ConsentModel _consentModel = ConsentModel();

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
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Child', style: AppTextStyles.title),
            const Text(
              'Step 3 of 3 - Set Up Child Profile',
              style: AppTextStyles.headline1,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormField(
                controller: _nameController,
                label: 'Child\'s Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              CustomFormField(
                controller: _ageController,
                label: 'Age',
                icon: Icons.cake,
              ),
              const SizedBox(height: 16),
              CustomFormField(
                controller: _schoolController,
                label: 'School',
                icon: Icons.school,
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
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
              ParentalConsent(consent: _consentModel),
              const SizedBox(height: 16),
              const InviteCoparent(),
              const SizedBox(height: 16),
              const AddAnotherChild(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(onPressed: () {}, text: 'Finish Setup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
