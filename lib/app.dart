import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/constants/theme_data.dart';
import 'package:marco/core/utils/theme/theme_provider.dart';
import 'core/router/app_router.dart';

class MarcoApp extends ConsumerWidget {
  const MarcoApp({super.key});

  // Future<ThemeMode?> _loadThemeFromPrefs() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final stored = prefs.getString('themeMode');
  //     if (stored == 'light') return ThemeMode.light;
  //     if (stored == 'dark') return ThemeMode.dark;
  //     if (stored == 'system') return ThemeMode.system;
  //   } catch (_) {}
  //   return null;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Marco',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
