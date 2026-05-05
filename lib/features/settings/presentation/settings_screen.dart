import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/app_text_styles.dart';
import 'package:marco/features/settings/presentation/widgets/logout_button.dart';
import 'package:marco/features/settings/presentation/widgets/theme_mode_toggle.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: AppTextStyles.title),
        actions: [ThemeModeToggle()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [SizedBox(width: double.infinity, child: LogoutButton())],
        ),
      ),
    );
  }
}
