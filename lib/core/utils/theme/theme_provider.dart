// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';

// final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
//   ThemeNotifier.new,
// );

// class ThemeNotifier extends Notifier<ThemeMode> {
//   @override
//   ThemeMode build() => ThemeMode.light;

//   void toggleTheme() {
//     state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//   }

//   bool get isDark => state == ThemeMode.dark;
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeMode> {
  static const _key = 'themeMode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key);

    if (stored == 'dark') {
      state = ThemeMode.dark;
    } else if (stored == 'light') {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.system;
    }
  }

  @override
  ThemeMode build() {
    _loadTheme();

    return ThemeMode.system;
  }

  Future<void> toggleTheme() async {
    final currentState = state;
    final newMode = currentState == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newMode.name);
  }

  bool get isDark => state == ThemeMode.dark;
}
