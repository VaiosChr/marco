import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marco/core/router/nav_bar.dart';
import 'package:marco/features/auth/presentation/providers/auth_provider.dart';
import 'package:marco/features/settings/presentation/settings_screen.dart';

import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/child/presentation/screens/add_child_screen.dart';
import '../../features/route/presentation/screens/route_entry_screen.dart';
import '../../features/route/presentation/screens/live_status_screen.dart';
import '../../features/ai_suggestion/presentation/screens/ai_suggestion_screen.dart';
import '../../features/trip_log/presentation/screens/trip_log_screen.dart';
import '../../features/rewards/presentation/screens/rewards_screen.dart';

// ---------------------------------------------------------------------------
// Route name constants
// ---------------------------------------------------------------------------
abstract class AppRoutes {
  static const splash = '/';
  static const signup = '/signup';
  static const otp = '/otp';
  static const addChild = '/add-child';
  static const routeEntry = '/route-entry';
  static const liveStatus = '/live-status';
  static const aiSuggestion = '/ai-suggestion';
  static const tripLog = '/trip-log';
  static const rewards = '/rewards';
  static const kidView = '/kid';
  static const settings = '/settings';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.splash,

    // ----- Auth guard -----
    redirect: (context, state) {
      final authState = ref.read(authProvider);

      if (authState.isLoading) {
        return null;
      }

      final isAuthenticated = authState.isAuthenticated;
      final isOnAuthFlow =
          state.matchedLocation == AppRoutes.signup ||
          state.matchedLocation == AppRoutes.otp;

      // Not logged in and trying to reach a protected screen → signup
      if (!isAuthenticated && !isOnAuthFlow) {
        // If they are on the splash screen when loading finishes, send them to sign-up
        if (state.matchedLocation == AppRoutes.splash) {
          return AppRoutes.signup;
        }
        return AppRoutes.signup;
      }

      // Already logged in and landing on auth screens → go to rewards (or your home route)
      if (isAuthenticated && isOnAuthFlow) {
        return AppRoutes.rewards;
      }

      // Once loading finishes, handle the initial splash screen location
      if (state.matchedLocation == AppRoutes.splash) {
        return isAuthenticated ? AppRoutes.rewards : AppRoutes.signup;
      }

      return null; // no redirect needed
    },

    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),

      // ── Screen 1: Parent sign-up ──────────────────────────────────────
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (context, state) => SignupScreen(),
      ),

      // ── Screen 2: OTP verification ────────────────────────────────────
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        builder: (context, state) {
          final name = state.uri.queryParameters['name'] ?? '';
          final email = state.uri.queryParameters['email'] ?? '';
          final password = state.uri.queryParameters['password'] ?? '';
          final phone = state.uri.queryParameters['phone'] ?? '';
          final neighborhood = state.uri.queryParameters['neighborhood'] ?? '';
          return OtpScreen(
            name: name,
            email: email,
            password: password,
            phoneNumber: phone,
            neighborhood: neighborhood,
          );
        },
      ),

      // ── Screen 3: Add child & invite co-parent ────────────────────────
      GoRoute(
        path: AppRoutes.addChild,
        name: 'addChild',
        builder: (context, state) {
          final childId = state.uri.queryParameters['childId'];
          return AddChildScreen(childId: childId);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              // ── Screen 4: Route entry (map) ───────────────────────────
              GoRoute(
                path: AppRoutes.routeEntry,
                name: 'routeEntry',
                builder: (context, state) => RouteEntryScreen(),
                routes: [
                  GoRoute(
                    path: 'live-status',
                    name: 'liveStatus',
                    builder: (context, state) => LiveStatusScreen(
                      routeId: state.uri.queryParameters['routeId'] ?? '',
                    ),
                  ),
                  GoRoute(
                    path: 'ai-suggestion',
                    name: 'aiSuggestion',
                    builder: (context, state) => AiSuggestionScreen(
                      routeId: state.uri.queryParameters['routeId'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // ── Screen 8: Rewards ─────────────────────────────────────
              GoRoute(
                path: AppRoutes.rewards,
                name: 'rewards',
                builder: (context, state) => const RewardsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              // ── Screen 7: Manual trip log ─────────────────────────────
              GoRoute(
                path: AppRoutes.tripLog,
                name: 'tripLog',
                builder: (context, state) => const TripLogScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    // ----- Error fallback -----
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );

  // Trigger GoRouter to re-evaluate the redirect logic on auth changes
  ref.listen(authProvider, (_, _) {
    router.refresh();
  });

  return router;
});
