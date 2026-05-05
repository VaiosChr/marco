import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/utils/theme/theme_provider.dart';

class ThemeModeToggle extends ConsumerWidget {
  const ThemeModeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(Icons.light_mode),
          Switch(value: isDark, onChanged: (_) => themeNotifier.toggleTheme()),
          const Icon(Icons.dark_mode),
        ],
      ),
    );
  }
}
