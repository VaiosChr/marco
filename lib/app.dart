import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

class MarcoApp extends ConsumerWidget {
  const MarcoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'MARCO',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff3cb77e)),
        primaryColor: Color(0xff3cb77e),
        scaffoldBackgroundColor: Color(0xfff6f8fa),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff6f8fa),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }
}
